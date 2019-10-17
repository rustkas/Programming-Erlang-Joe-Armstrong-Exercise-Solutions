-module(counter).
-export([count_characters/1]).

count_characters(Str) ->
	count_characters(Str, #{}).

count_characters([H|T], X) when is_map(X),is_map_key(H, X) ->
	N= map_get(H,X),
	count_characters(T, X#{ H := N+1 });
	
count_characters([H|T], X) ->
	count_characters(T, X#{ H => 1 });	
	
count_characters([], X) ->
	X.