% rabbit.erl
-module(rabbit).
-export([init/1]).
%% File: "rabbit.erl"
%% ------------------
-spec init(Name:: string()) -> string().
init(Name) when is_list(Name) -> Name.