%% This is an -*- erlang -*- file.
%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2006-2015. All Rights Reserved.
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

{application, dialyzer,
 [{description, "DIscrepancy AnaLYZer of ERlang programs, version 2.9"},
  {vsn, "2.9"},
  {modules, [dialyzer,
	     dialyzer_analysis_callgraph,
	     dialyzer_behaviours,
	     dialyzer_callgraph,
	     dialyzer_cl,
	     dialyzer_cl_parse,
	     dialyzer_codeserver,
	     dialyzer_contracts,
	     dialyzer_coordinator,
	     dialyzer_dataflow,
	     dialyzer_dep,
	     dialyzer_explanation,
	     dialyzer_gui_wx,
	     dialyzer_options,
	     dialyzer_plt,
	     dialyzer_races,
	     dialyzer_succ_typings,
	     dialyzer_typesig,
	     dialyzer_utils,
             dialyzer_timing,
             dialyzer_worker]},
  {registered, []},
  {applications, [compiler, gs, hipe, kernel, stdlib, wx]},
  {env, []},
  {runtime_dependencies, ["wx-1.2","syntax_tools-1.6.14","stdlib-2.5",
			  "kernel-3.0","hipe-3.13","erts-7.0",
			  "compiler-5.0"]}]}.