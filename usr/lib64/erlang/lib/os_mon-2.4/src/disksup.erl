%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 1996-2013. All Rights Reserved.
%% 
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%% 
%% %CopyrightEnd%
%%
-module(disksup).
-behaviour(gen_server).

%% API
-export([start_link/0]).
-export([get_disk_data/0,
	 get_check_interval/0, set_check_interval/1,
	 get_almost_full_threshold/0, set_almost_full_threshold/1]).
-export([dummy_reply/1, param_type/2, param_default/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

%% Other exports
-export([format_status/2]).

-record(state, {threshold, timeout, os, diskdata = [],port}).

%%----------------------------------------------------------------------
%% API
%%----------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, disksup}, disksup, [], []).

get_disk_data() ->
    os_mon:call(disksup, get_disk_data, infinity).

get_check_interval() ->
    os_mon:call(disksup, get_check_interval, infinity).
set_check_interval(Minutes) ->
    case param_type(disk_space_check_interval, Minutes) of
	true ->
	    os_mon:call(disksup, {set_check_interval, Minutes}, infinity);
	false ->
	    erlang:error(badarg)
    end.

get_almost_full_threshold() ->
    os_mon:call(disksup, get_almost_full_threshold, infinity).
set_almost_full_threshold(Float) ->
    case param_type(disk_almost_full_threshold, Float) of
	true ->
	    os_mon:call(disksup, {set_almost_full_threshold, Float}, infinity);
	false ->
	    erlang:error(badarg)
    end.

dummy_reply(get_disk_data) ->
    [{"none", 0, 0}];
dummy_reply(get_check_interval) ->
    minutes_to_ms(os_mon:get_env(disksup, disk_space_check_interval));
dummy_reply({set_check_interval, _}) ->
    ok;
dummy_reply(get_almost_full_threshold) ->
    round(os_mon:get_env(disksup, disk_almost_full_threshold) * 100);
dummy_reply({set_almost_full_threshold, _}) ->
    ok.

param_type(disk_space_check_interval, Val) when is_integer(Val),
						Val>=1 -> true;
param_type(disk_almost_full_threshold, Val) when is_number(Val),
						 0=<Val,
						 Val=<1 -> true;
param_type(disksup_posix_only, Val) when Val==true; Val==false -> true;
param_type(_Param, _Val) -> false.

param_default(disk_space_check_interval) -> 30;
param_default(disk_almost_full_threshold) -> 0.80;
param_default(disksup_posix_only) -> false.

%%----------------------------------------------------------------------
%% gen_server callbacks
%%----------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    process_flag(priority, low),

    PosixOnly = os_mon:get_env(disksup, disksup_posix_only),
    OS = get_os(PosixOnly),
    Port = case OS of
		{unix, Flavor} when Flavor==sunos4;
				    Flavor==solaris;
				    Flavor==freebsd;
				    Flavor==dragonfly;
				    Flavor==darwin;
				    Flavor==linux;
				    Flavor==posix;
				    Flavor==openbsd;
				    Flavor==netbsd;
				    Flavor==irix64;
				    Flavor==irix ->
		   start_portprogram();
	       {win32, _OSname} ->
		   not_used;
	       _ ->
		   exit({unsupported_os, OS})
	   end,

    %% Read the values of some configuration parameters
    Threshold = os_mon:get_env(disksup, disk_almost_full_threshold),
    Timeout = os_mon:get_env(disksup, disk_space_check_interval),

    %% Initiation first disk check
    self() ! timeout,

    {ok, #state{port=Port, os=OS,
		threshold=round(Threshold*100),
		timeout=minutes_to_ms(Timeout)}}.

handle_call(get_disk_data, _From, State) ->
    {reply, State#state.diskdata, State};

handle_call(get_check_interval, _From, State) ->
    {reply, State#state.timeout, State};
handle_call({set_check_interval, Minutes}, _From, State) ->
    Timeout = minutes_to_ms(Minutes),
    {reply, ok, State#state{timeout=Timeout}};

handle_call(get_almost_full_threshold, _From, State) ->
    {reply, State#state.threshold, State};
handle_call({set_almost_full_threshold, Float}, _From, State) ->
    Threshold = round(Float * 100),
    {reply, ok, State#state{threshold=Threshold}};

handle_call({set_threshold, Threshold}, _From, State) -> % test only
    {reply, ok, State#state{threshold=Threshold}}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(timeout, State) ->
    NewDiskData = check_disk_space(State#state.os, State#state.port,
				   State#state.threshold),
    timer:send_after(State#state.timeout, timeout),
    {noreply, State#state{diskdata = NewDiskData}};
handle_info({'EXIT', _Port, Reason}, State) ->
    {stop, {port_died, Reason}, State#state{port=not_used}};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, State) ->
    clear_alarms(),
    case State#state.port of
	not_used ->
	    ok;
	Port ->
	    port_close(Port)
    end,
    ok.

%% os_mon-2.0.1
%% For live downgrade to/upgrade from os_mon-1.8[.1]
code_change(Vsn, PrevState, "1.8") ->
    case Vsn of

	%% Downgrade from this version
	{down, _Vsn} ->
	    State = case PrevState#state.port of
			not_used -> PrevState#state{port=noport};
			_ -> PrevState
		    end,
	    {ok, State};

	%% Upgrade to this version
	_Vsn ->
	    State = case PrevState#state.port of
			noport -> PrevState#state{port=not_used};
			_ -> PrevState
		    end,
	    {ok, State}
    end;
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%----------------------------------------------------------------------
%% Other exports
%%----------------------------------------------------------------------

format_status(_Opt, [_PDict, #state{os = OS, threshold = Threshold,
				    timeout = Timeout,
				    diskdata = DiskData}]) ->
    [{data, [{"OS", OS},
	     {"Timeout", Timeout},
	     {"Threshold", Threshold},
	     {"DiskData", DiskData}]}].

%%----------------------------------------------------------------------
%% Internal functions
%%----------------------------------------------------------------------

get_os(PosixOnly) ->
    case os:type() of
	{unix, sunos} ->
            case os:version() of
		{5,_,_} -> {unix, solaris};
		{4,_,_} -> {unix, sunos4};
		V -> exit({unknown_os_version, V})
            end;
	{unix, _} when PosixOnly ->
	    {unix, posix};
        {unix, irix64} -> {unix, irix};
	OS ->
	    OS
    end.

%%--Port handling functions---------------------------------------------

start_portprogram() ->
    os_mon:open_port(disksup, []).

%%--Check disk space----------------------------------------------------

check_disk_space({unix, linux}, Port, Threshold) ->
    Port ! {self(), {command, <<>>}},
    receive
        {Port, Msg} ->
            [check_disk(Info, Threshold) || Info <- Msg ],
            Msg;
        {'EXIT', Port, Reason} ->
	    exit({port_died, Reason})
    end.

check_disk({MntOn, _KB, Cap}, Threshold)
  when Cap >= Threshold ->
    set_alarm({disk_almost_full, MntOn}, []);
check_disk({MntOn, _KB, _Cap}, _Threshold) ->
    clear_alarm({disk_almost_full, MntOn}).

%%--Alarm handling------------------------------------------------------

set_alarm(AlarmId, AlarmDescr) ->
    case get(AlarmId) of
	set ->
	    ok;
	undefined ->
	    alarm_handler:set_alarm({AlarmId, AlarmDescr}),
	    put(AlarmId, set)
    end.

clear_alarm(AlarmId) ->
    case get(AlarmId) of
	set ->
	    alarm_handler:clear_alarm(AlarmId),
	    erase(AlarmId);
	undefined ->
	    ok
    end.

clear_alarms() ->
    lists:foreach(fun({{disk_almost_full, _MntOn} = AlarmId, set}) ->
			  alarm_handler:clear_alarm(AlarmId);
		     (_Other) ->
			  ignore
		  end,
		  get()).

%%--Auxiliary-----------------------------------------------------------

%% Type conversion
minutes_to_ms(Minutes) ->
    trunc(60000*Minutes).
