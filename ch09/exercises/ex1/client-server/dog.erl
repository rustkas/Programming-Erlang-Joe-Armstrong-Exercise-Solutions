% dog.erl
-module(dog).
-export([init/1]).

%% File: "dog.erl"
%% ---------------
-spec init(Name:: string()) -> string().
init(Name) when is_list(Name) ->
	Name.