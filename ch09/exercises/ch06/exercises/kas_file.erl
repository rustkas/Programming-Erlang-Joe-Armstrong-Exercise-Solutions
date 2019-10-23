%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%%

-module(kas_file).
-export([test/0]).
-export([read/1]).

%% File: "kas_file.erl"
%% --------------------
-spec test() -> 'test_worked'.

test() ->

	try read("nothing") 
    catch
       error:X:Stacktrace  ->
		io:format("~s~n~p~n~p~n", [error, X, Stacktrace]),
	    {error, X, Stacktrace}
    end,

	read("kas_file.erl"),
	
	
test_worked.

-spec read(FileName :: [char()]) -> FileContent :: binary().

read(Fname) when is_list(Fname) ->
    case file:read_file(Fname) of
        {ok, Bin}       -> Bin;
        {error, enoent}    -> error(lists:flatten(io_lib:format("File '~s' does not exists",[Fname])));
		{error, Why}    ->
            error(lists:flatten(io_lib:format("Could not read file '~s': ~w",         [Fname, Why])))
    end.
	
% c(kas_file). kas_file:test().