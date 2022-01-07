%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2021-2021. All Rights Reserved.
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

%%

-module(tls_dist_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callback
-export([init/1]).

%%%=========================================================================
%%%  API
%%%=========================================================================

-spec start_link() -> {ok, pid()} | ignore | {error, term()}.
			
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%=========================================================================
%%%  Supervisor callback
%%%=========================================================================

init([]) ->    
  
    TLSConnetionSup = tls_connection_child_spec(),
    ServerInstanceSup = server_instance_child_spec(), 

    {ok, {{one_for_one, 10, 3600}, [TLSConnetionSup, 
				    ServerInstanceSup
				   ]}}.

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

tls_connection_child_spec() ->
    Name = dist_tls_connection,  
    StartFunc = {tls_connection_sup, start_link_dist, []},
    Restart = permanent, 
    Shutdown = 4000,
    Modules = [tls_connection_sup],
    Type = supervisor,
    {Name, StartFunc, Restart, Shutdown, Type, Modules}.

server_instance_child_spec() ->
    Name = dist_tls_server_sup,  
    StartFunc = {tls_dist_server_sup, start_link, []},
    Restart = permanent, 
    Shutdown = 4000,
    Modules = [tls_dist_server_sup],
    Type = supervisor,
    {Name, StartFunc, Restart, Shutdown, Type, Modules}.
