%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  my_time_func, my_date_string().
%% There functions are hidden.
%% Public API are work_time/1, date_string/0
%% Since As from Erlang/OTP 18 erlang:now/0 is depricated
%% Read more at http://erlang.org/doc/apps/erts/time_correction.html
%%
-module(kas_date).
-export([test/0]).
-export([work_time/1, date_string/0]).

test() ->
	%io:fwrite("~p", [pythag(200)]),
	io:fwrite("~p",[work_time(fun()-> pythag(100) end)]),
	io:nl(),
	
	date_string(),
	ok.
	
my_time_func(F,TimeUnit) ->

 Before = erlang:monotonic_time(),
 F(),
 After = erlang:monotonic_time(),
 TimeDiff = After - Before,

 Seconds = erlang:convert_time_unit(TimeDiff, native, TimeUnit),
 calendar:seconds_to_time(Seconds).
 
	
my_date_string() ->
	{Y, M, D} = date(),
	{H, Min, Sec} = time(),
	io:format("Date: ~p/~p/~p", [D,M,Y]),
	io:nl(),
	io:format("Time: ~p:~p:~p", [H,Min,Sec]),
	io:nl(),
	ok.

%% Run function F and calcuate working time of this function.
%% Return tuple{hours, minutes, seconds}
work_time(F) ->
	TimeUnit = second,
	my_time_func(F, TimeUnit).
	
date_string() ->
	my_date_string().

pythag(N) ->
	[ {A,B,C} ||
		A <- lists:seq(1,N),
		B <- lists:seq(1,N),
		C <- lists:seq(1,N),
		A+B+C =< N,
		A*A + B*B =:= C*C
	].	

% c(kas_date).
% c(kas_date). kas_date:test(). 