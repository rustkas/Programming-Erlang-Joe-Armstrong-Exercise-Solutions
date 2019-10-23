%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  BIF tuple_to_list(T) 
-module(kas_converter).
-export([test/0, tuple_to_list/1]).

%% File: "kas_converter.erl"
%% -------------------------

%% test function
-spec test() -> 'test_ok'.

test() ->
	[] = erlang:tuple_to_list({}),
	[test, ok] = erlang:tuple_to_list({test, ok}),
	
	[] = kas_converter:tuple_to_list({}),
	[test, ok] = kas_converter:tuple_to_list({test, ok}),
	
	true = lists:seq(1, 100) =:= kas_converter:tuple_to_list(erlang:list_to_tuple(lists:seq(1, 100))),
	
	% registered/0
	true = erlang:list_to_tuple(erlang:registered()) ==  erlang:list_to_tuple(erlang:registered()),
	true = erlang:tuple_to_list(erlang:localtime()) == kas_converter:tuple_to_list(erlang:localtime()),
	
	% localtime_to_universaltime/2
	true = erlang:tuple_to_list(       erlang:localtime_to_universaltime(erlang:localtime(), true)) == 
		   kas_converter:tuple_to_list(erlang:localtime_to_universaltime(erlang:localtime(), true)),
			
	true = erlang:tuple_to_list(       erlang:localtime_to_universaltime(erlang:localtime(), false)) == 
		   kas_converter:tuple_to_list(erlang:localtime_to_universaltime(erlang:localtime(), false)),
			
	true = erlang:tuple_to_list(       erlang:localtime_to_universaltime(erlang:localtime(), undefined)) == 
		   kas_converter:tuple_to_list(erlang:localtime_to_universaltime(erlang:localtime(), undefined)),			
	
	% time/0
	true = erlang:tuple_to_list(       erlang:time()) == 
		   kas_converter:tuple_to_list(erlang:time()),			
	
	% now/0
	Now = erlang:now(),
	true = erlang:tuple_to_list(       Now) == 
		   kas_converter:tuple_to_list(Now),			
	
	% memory/0
	% compare last list items
	true = lists:last(erlang:tuple_to_list(       erlang:list_to_tuple(erlang:memory()))) == 
	       lists:last(kas_converter:tuple_to_list(erlang:list_to_tuple(erlang:memory()))),
	
	test_ok.


-spec tuple_to_list({}) -> []
				;  (Tuple :: tuple()) -> [term()].
	
tuple_to_list({}) -> [];	
tuple_to_list(T) ->
	% create function with inner function.
	TupleElement = fun(Y,X) when is_tuple(Y) -> erlang:element(X, Y) end,	
	
	% get tuple size
	N = erlang:size(T),
	
	% generate list of integers from 1 to N
	% put each item of this sequence to the function variable
	% list comprihansion produce a list
	
	List = [TupleElement(T, X)||X <- lists:seq(1, N)],
	List.
	
%% commands
%
% c(kas_converter).
% c(kas_converter). kas_converter:test().
	