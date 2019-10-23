%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% term_to_packet(Term) -> Packet
%%

-module(kas_term_to_packet).
-export([test/0]).
-export([term_to_packet/1]).

%% File: "kas_term_to_packet.erl"
%% ------------------------------

-spec test1() -> 'ok'.

test1() ->
	Value = [],
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1,Rest1, Value]).

-spec test2() -> 'ok'.

test2() ->
	Value = 0,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(0),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test3() -> 'ok'.

test3() ->
	Value = 1.1,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1), 
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test4() -> 'ok'.

test4() ->
	Value = {},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).
	
-spec test5() -> 'ok'.

test5() ->
	Value = #{},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test6() -> 'ok'.
	
test6() ->
	Value = <<"hello">>,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test7() -> 'ok'.

test7() ->
	Value = <<65,66,67>>,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test8() -> 'ok'.

test8() ->
	Value = {binaries,"are", useful},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test9() -> 'ok'.

test9() ->
	Value = {<<16#12345678:32/big>>,<<16#12345678:32/little>>, <<16#12345678:32/native>>,<<16#12345678:32>>},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

-spec test() -> 'test_worked'.

test() ->
	test1(), 
	test2(), 
	test3(), 
	test4(),
	test5(), 	
	test6(),
	test7(),
	test8(),
	test9(),

test_worked.	

-spec term_to_packet(Term :: term()) -> Result :: <<_:32,_:_*8>>.

term_to_packet(Term) -> 
	Bin = term_to_binary(Term),
	Size = byte_size(Bin),
	<<Size:4/integer-unit:8, Bin/binary>>.
	
% c(kas_term_to_packet).
% c(kas_term_to_packet). kas_term_to_packet:test().