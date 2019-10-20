%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%%

-module(kas_log).
-export([test/0]).
-export([log/3]).

test() ->

	try kas_file:read("nothing") 
    catch
       error:X:Stacktrace  ->
			log(error,X,Stacktrace)
    end,
	
	test_worked.
	
log(Type, Course, Stacktrace)	->
	%io:format("logging start...~n"),
	case file:open("log-messages.log", [append,binary,{encoding, utf8}]) of
		{ok, Fd} -> 
		%io:format("file open~nStack trace:~n~p~n---~n"),
			
			io:fwrite(Fd,        
            "~s~n~s: ~ts~nStack trace:~n~p~n---~n",
            [current_date(),Type, Course,Stacktrace]
            ),
			
            file:close(Fd)
	end,
	%io:format("end start...~n"),
			{Type, Course, Stacktrace}.
			
current_date() ->
	
	{Y, M, D} = date(),
	{H, Min, Sec} = time(),
	Date = io_lib:format("~p/~p/~p", [D,M,Y]),
	Time = io_lib:format("~p:~p:~p", [H,Min,Sec]),
	
	io_lib:format("~s ~s", [Date, Time]).
	
% c(kas_log).
% c(kas_log). kas_log:test().

% {ok,F} = file:open("log-messages.log",[read]).
% io:getopts(F).