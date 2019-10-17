-module(json_reader).

-export([test/0]).


test() ->
	FileName = "config.json",
	{ok, StringData} = read_string_data_from_file(FileName),
	io:format("~p~n", [StringData]),
	
	ok.


read_string_data_from_file(Filename) ->
    Size = filelib:file_size(Filename),
    {ok, IoDevice} = file:open(Filename, [read, binary]),
    {ok, Data} = file:read(IoDevice, Size),
    file:close(IoDevice),
	{ok, Data}.
	
% c(json_reader).
% c(json_reader). json_reader:test().	