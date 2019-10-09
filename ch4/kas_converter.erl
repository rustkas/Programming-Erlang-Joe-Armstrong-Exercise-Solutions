%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  BIF tuple_to_list(T) 
-module(kas_converter).
-export([test/0, tuple_to_list/1]).

%% test function
test() ->
	[] = erlang:tuple_to_list({}),
	[test, ok] = erlang:tuple_to_list({test, ok}),
	
	[] = kas_converter:tuple_to_list({}),
	[test, ok] = kas_converter:tuple_to_list({test, ok}),
	
	true = lists:seq(1, 100) =:= kas_converter:tuple_to_list(erlang:list_to_tuple(lists:seq(1, 100))),
	
	test_ok.
	
tuple_to_list({}) -> [];	
tuple_to_list(T) ->
	% create function with inner function.
	Element = fun(Y) -> (fun(X) when is_tuple(Y) -> erlang:element(X, Y) end) end,	
	TupleElement = Element(T),
	
	% get tuple size
	N = erlang:size(T),
	
	% generate list of integers from 1 to N
	% put each item of this sequence to the function variable
	% list comprihansion produce a list
	
	List = [TupleElement(X)||X <- lists:seq(1, N)],
	List.
	
%% commands
%
% c(kas_converter).
% c(kas_converter). kas_converter:test().
	