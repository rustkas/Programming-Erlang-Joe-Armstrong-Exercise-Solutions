%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% term_to_packet(Term) -> Packet
%%

-module(kas_term_to_packet).
-export([test/0]).
-export([term_to_packet/1]).

test1() ->
	Value = [],
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1,Rest1, Value]).

test2() ->
	Value = 0,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(0),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).


test3() ->
	Value = 1.1,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1), 
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

test4() ->
	Value = {},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).
	

test5() ->
	Value = #{},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).
	
test6() ->
	Value = <<"hello">>,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

test7() ->
	Value = <<65,66,67>>,
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

test8() ->
	Value = {binaries,"are", useful},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).

test9() ->
	Value = {<<16#12345678:32/big>>,<<16#12345678:32/little>>, <<16#12345678:32/native>>,<<16#12345678:32>>},
	<<Size1:4/integer-unit:8, Rest1/binary>> = term_to_packet(Value),
	true = Value =:= binary_to_term(Rest1),
	io:format("size = ~p; binary = ~p; value = ~p~n", [Size1, Rest1, Value]).




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

term_to_packet(Term) -> 
	Bin = term_to_binary(Term),
	Size = byte_size(Bin),
	<<Size:4/integer-unit:8, Bin/binary>>.
	
% c(kas_term_to_packet).
% c(kas_term_to_packet). kas_term_to_packet:test().