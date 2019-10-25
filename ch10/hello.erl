-module(hello).
-export([start/0]).

start() ->
    io:format("Hello world~n").
	
% erlc hello.erl && erl -noshell -s hello start -s init stop	