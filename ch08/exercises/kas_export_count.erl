%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% 
%%
-module(kas_export_count).
-export([test/0]).
-export([export_count/1]).

test() ->
	Count = export_count(dict),
	io:format("~p; ~p~n", [dict, Count]),
	io:format("~p; ~p~n", [lists, Count]),
	test_worked.

export_count(ModName) ->
    List = ModName:module_info(exports),
	length(List).
	
	
% c(kas_export_count).
% c(kas_export_count). kas_export_count:test().