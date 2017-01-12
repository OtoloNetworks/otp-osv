%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosEventDomainAdmin
%% Source: /home/rickp/src/otolo/otp/lib/cosEventDomain/src/CosEventDomainAdmin.idl
%% IC vsn: 4.4
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosEventDomainAdmin').
-ic_compiled("4_4").


%% Interface functions
-export(['CycleDetection'/0, 'AuthorizeCycles'/0, 'ForbidCycles'/0]).
-export(['DiamondDetection'/0, 'AuthorizeDiamonds'/0, 'ForbidDiamonds'/0]).

%%%% Constant: 'CycleDetection'
%%
'CycleDetection'() -> "CycleDetection".

%%%% Constant: 'AuthorizeCycles'
%%
'AuthorizeCycles'() -> 0.

%%%% Constant: 'ForbidCycles'
%%
'ForbidCycles'() -> 1.

%%%% Constant: 'DiamondDetection'
%%
'DiamondDetection'() -> "DiamondDetection".

%%%% Constant: 'AuthorizeDiamonds'
%%
'AuthorizeDiamonds'() -> 0.

%%%% Constant: 'ForbidDiamonds'
%%
'ForbidDiamonds'() -> 1.

