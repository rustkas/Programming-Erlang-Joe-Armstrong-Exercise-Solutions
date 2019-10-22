-module(world).
-export([start/0]).

%% File: "world.erl"
%% -----------------
-spec start() -> 'ok'.
start() ->
	Joe      = spawn(person, init, ["Joe"]),
	Susannah = spawn(person, init, ["Susannah"]),
	Dave     = spawn(person, init, ["Dave"]),
	Andy     = spawn(person, init, ["Andy"]),
	Rover    = spawn(person, init, ["Rover"]),
	
	% recipient ! {sender, Message},
	Dave !     {Joe, "Hello!"},
	Susannah ! {Joe, "Hello!"},
	Andy !     {Joe, "Hello!"},
	Rover !    {Joe, "Hello!"},
	
	Joe !      {Dave, "Hello!"},
	Joe !      {Susannah, "Hello!"},
	Joe !      {Andy, "Hello!"},
	Joe !      {Rover, "Hello!"},
	
	Joe !      {Susannah, "Hope the dogs don't chase the rabbits"},
	%io:nl(),
	io:nl(),
	%[Joe, Dave, Susannah,Andy, Rover].
	%[is_process_alive(Joe), is_process_alive(Dave), is_process_alive(Susannah), is_process_alive(Andy), is_process_alive(Rover)].
	
	%[[Joe, Dave, Susannah,Andy, Rover], [is_process_alive(Joe), is_process_alive(Dave), is_process_alive(Susannah), is_process_alive(Andy), is_process_alive(Rover)]].
	
	%Susannah ! {Joe, "Hope the dogs don't chase the rabbits"},
	ok.
	
	