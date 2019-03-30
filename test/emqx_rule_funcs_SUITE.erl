%% Copyright (c) 2019 EMQ Technologies Co., Ltd. All Rights Reserved.
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

-module(emqx_rule_funcs_SUITE).

%% -include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

-export([ t_msgid/1
        , t_qos/1
        ]).

-export([ all/0
        , suite/0
        ]).

t_msgid(_) ->
    ?assertEqual(undefined, apply(func(msgid), [#{}])),
    ?assertEqual(<<"id">>, apply(func(msgid), [#{id => <<"id">>}])).

t_qos(_) ->
    ?assertEqual(1, apply(func(qos), [#{qos => 1}])),
    ?assertEqual(undefined, apply(func(qos), [#{}])).

func(Name) ->
    erlang:apply(emqx_rule_funcs, Name, []).

all() ->
    IsTestCase = fun("t_" ++ _) -> true; (_) -> false end,
    [F || {F, _A} <- module_info(exports), IsTestCase(atom_to_list(F))].

suite() ->
    [{ct_hooks, [cth_surefire]}, {timetrap, {seconds, 30}}].
