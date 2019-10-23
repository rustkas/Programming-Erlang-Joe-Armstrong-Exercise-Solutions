-module(a).
-export([people/0, get_names/1]).
-export_type([person/0,first_name/0]).

-type person()      :: {person, first_name()}.
%-opaque person()      :: {person, first_name()}.
-type first_name()    :: string().

-spec people() -> People when
      People :: [person()].

people() ->
    [{person, "Joe"}, {person, "Cindy"}].

-spec get_names(People) -> Names when
      People     :: [person()],
      Names      :: [first_name()].

get_names(Ps) ->
    get_names(Ps, []).

-spec get_names(People| [], Names) -> Result when
		People     :: [person()],
		Names      :: [first_name()],
		Result     :: [first_name()].

get_names([], Names) -> 
    lists:reverse(Names);
get_names([ {person, Name} | Ps ], Names) -> 
    get_names(Ps, [Name|Names]).