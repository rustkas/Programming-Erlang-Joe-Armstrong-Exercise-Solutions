-module(b).
-export([do/0]).

-spec do() -> Name when
      Name :: a:first_name().

do() ->
    [{person, Name} | _People] = a:people(),
    Name.