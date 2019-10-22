% person.erl
-module(person).
-export([init/1]).

-spec init(Name:: string()) -> no_return().
init(Name) when is_list(Name) ->
	receive 
		{From, "Hello!"} ->
			io:format("~p sad ~p: Hello, ~s!~n",[From, self(), Name]),
			From ! {self(), "Hello"};
		
		{From, "Hope the dogs don't chase the rabbits"} ->
			io:format("~p sad ~p: Hope the dogs don't chase the rabbits~n", [From, self()]),
			From ! {self(), "Me too"};
		
		{From, Message} -> io:format("~p sad ~p: ~s!~n",[From, self(), Message])
	end,		
	init(Name).