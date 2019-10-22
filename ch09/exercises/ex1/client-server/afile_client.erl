% afile_client.erl
-module(afile_client).
-export([ls/1, get_file/2]).

%% File: "afile_client.erl"
%% ------------------------
-spec ls(pid()) -> [string()].
ls(Server)  when is_pid(Server) ->
	Server ! {self(), list_dir},
	receive 
		{Server, FileList} ->
			FileList
	end.

-spec get_file(pid(),string()) -> binary().	
get_file(Server, File)  when is_pid(Server), is_list(File) ->
	Server ! {self(), {get_file, File}},
	receive
		{Server, Content} when is_binary(Content) ->
			Content
	end.