%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  my_time_func, my_date_string().
%% There functions are hidden.
%%
-module(kas_math_functions).
-export([test/0]).
-export([even/1, odd/1]).
-export([filter/2]).
-export([split/1]).


%% File: "kas_math_functions.erl"
%% ------------------------------
-spec test() -> 'test_worked'.
test() ->

	% Exercise 5	
	true = even(2),
	%io:fwrite("~p~n", [even(3)] ),
	
	true = not odd(2),
	false = not odd(3),

	% Exercise 6
	[] = filter(fun even/1, []),
	[] = filter(fun odd/1, []),
	[2,4] = filter(fun even/1, [2,4]),
	[1,3] = filter(fun odd/1, [1,3]),
	[2,4] = filter(fun even/1, [1,2,4,5]),
	[1,3] = filter(fun odd/1, [2,1,3,6]),

	% Exercise 7	
	{[],[]} = split([]),
	{[1,3],[2,4]} = split([1,2,3,4]),
	
	test_worked.


%% Return true if X is even	
-spec even(Value :: integer()) -> boolean().

even(X) when is_integer(X) ->
	X rem 2 =:= 0.

%% Return true if X is odd
-spec odd(Value :: integer()) -> boolean().
odd(X) ->
	not even(X).

%% Filter function
-spec filter(Function :: fun((_) -> any()),List :: [any()]) -> [any()].

filter(F,L) when is_function(F,1), is_list(L)	->
	[X || X<-L, F(X) == true].

%% Split function
-spec split(List :: [integer()]) -> {[integer()],[integer()]}.
split(L) when is_list(L)->	
	split_acc(L,[],[]).

-spec split_acc([integer()],Odds,Evens) -> {Odds,Evens} when 
				Odds :: [integer()],
				Evens :: [integer()]
			; 	([],Odds,Evens) -> {Odds,Evens} when 
				Odds :: [integer()],
				Evens :: [integer()].

split_acc([H|T], Odds, Evens) ->
	case (H rem 2) of
		1 -> split_acc(T, [H|Odds], Evens);
		0 -> split_acc(T, Odds, [H|Evens])
	end;
split_acc([], Odds, Evens) ->
{lists:reverse(Odds), lists:reverse(Evens)}.


% c(kas_math_functions).
% c(kas_math_functions). kas_math_functions:test().