-module(character_count).
-export([count/1]).

-import(dict, [is_key/2, new/0, store/3, to_list/1, update/3]).
-import(string, [to_upper/1]).

count(String) ->
     dict:to_list( character_count(String, dict:new()) ).

character_count([Head|Tail], Counts) ->
    Character = string:to_upper(Head),
    NewCounts = case dict:is_key(Character, Counts) of
                    true  -> dict:update(Character, fun(Value) -> Value + 1 end, Counts);
                    false -> dict:store(Character, 1, Counts)
                end,
    character_count(Tail, NewCounts);
character_count([], Counts) ->
     Counts.