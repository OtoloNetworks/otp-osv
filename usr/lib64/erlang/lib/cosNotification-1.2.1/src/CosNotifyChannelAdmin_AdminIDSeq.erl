%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosNotifyChannelAdmin_AdminIDSeq
%% Source: /home/rickp/src/otolo/otp/lib/cosNotification/src/CosNotifyChannelAdmin.idl
%% IC vsn: 4.4
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosNotifyChannelAdmin_AdminIDSeq').
-ic_compiled("4_4").


-include("CosNotifyChannelAdmin.hrl").

-export([tc/0,id/0,name/0]).



%% returns type code
tc() -> {tk_sequence,tk_long,0}.

%% returns id
id() -> "IDL:omg.org/CosNotifyChannelAdmin/AdminIDSeq:1.0".

%% returns name
name() -> "CosNotifyChannelAdmin_AdminIDSeq".



