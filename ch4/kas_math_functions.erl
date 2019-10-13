%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  my_time_func, my_date_string().
%% There functions are hidden.
%%
-module(kas_math_functions).
-export([test/0]).
-export([even/1, odd/1]).

test() ->
	
	true = even(2),
	%io:fwrite("~p~n", [even(3)] ),
	
	true = not odd(2),
	false = not odd(3),
		
	test_worked.
	
even(X) when is_integer(X) ->
	X rem 2 =:= 0.

odd(X) ->
	not even(X).
	
% c(kas_math_functions).
% c(kas_math_functions). kas_math_functions:test().