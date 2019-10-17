%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%%

-module(kas_map_search).
-export([test/0]).
-export([map_search_pred/2]).


test() ->
	none = map_search_pred(#{},fun(_Key,_Value)-> true end),
	{a,1} = map_search_pred(#{a => 1, b => 2},fun(_Key,_Value)-> true end),
	{b,2} = map_search_pred(#{a => 1, b => 2},fun(Key,Value)-> Key == b andalso Value == 2 end),
	tests_worked.

map_search_pred(Map, Pred) when is_map(Map), is_function(Pred,2) ->
	 map_search_pred(Map, Pred, maps:keys(Map)).

map_search_pred( _, _, []) ->
    none;
map_search_pred(Map, Pred, [Key|Keys]) ->
    Value = maps:get(Key, Map),
	PredResult = Pred(Key, Value),
	if 
		PredResult -> 
			{Key, Value};
		true ->
			map_search_pred(Map, Pred, Keys)
    end.



% c(kas_map_search).
% c(kas_map_search). kas_map_search:test().
% c(kas_map_search). kas_map_search:map_search_pred(#{ a => 1, b => 2 },fun(_Key,_Value)-> true end).