% afile_server.erl
-module(afile_server).
-export([start/1, loop/1]).

%% File: "afile_server.erl"
%% ------------------------
-spec start(Dir:: string()) -> pid().
start(Dir) when is_list(Dir) -> spawn(afile_server, loop, [Dir]).

-spec loop(Dir:: string()) -> no_return().
loop(Dir) when is_list(Dir) -> 
	receive
		{Client, list_dir} ->
			Client !  {self(), file:list_dir(Dir)};
		{Client, {get_file, File}} ->
			Full = filename:join(Dir, File),
			Client ! {self(), file:read_file(Full)}
	end,
	loop(Dir).