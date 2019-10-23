%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%%

-module(kas_map_search).
-export([test/0]).
-export([map_search_pred/2]).

%% File: "kas_map_search.erl"
%% --------------------------
-spec test() -> 'tests_worked'.

test() ->
	{a,1} = map_search_pred(#{a => 1, b => 2},fun(_Key,_Value)-> true end),
	{b,2} = map_search_pred(#{a => 1, b => 2},fun(Key,Value)-> Key == b andalso Value == 2 end),
	tests_worked.

-spec map_search_pred(Map, Function) -> Tuple when 
	Map :: map(),
	Function :: fun((_,_) -> any()),
	Tuple :: {_,_}.

map_search_pred(Map, Pred) when is_map(Map) andalso is_function(Pred,2) ->
	 map_search_pred(Map, Pred, maps:keys(Map)).

-spec map_search_pred(Map, Function,List) -> Tuple when 
						Map :: map(), 
						Function :: fun((any(),any()) -> any()),
						List :: [any()],
						Tuple :: {any(),any()}. 	

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