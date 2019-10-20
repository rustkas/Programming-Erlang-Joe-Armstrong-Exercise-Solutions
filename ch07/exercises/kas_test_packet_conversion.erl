%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% 
%%

-module(kas_packet_to_term).
-export([test/0]).


test1() ->
	Value = [],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

test2() ->
	Value = 10,
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).
	
test3() ->
	Value = hello,
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

test3() ->
	Value = [3.12, hello, {abc, 1}],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).
	
test3() ->
	Value = [{"Hello World1"}],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

test() ->
	test1(),
	test2(),
	test3(),
	
	test_worked.
	
packet_to_term(<<_Size:4/integer-unit:8, Bin/binary>>) ->
	binary_to_term(Bin).
	

% c(kas_test_packet_conversion).
% c(kas_test_packet_conversion). kas_test_packet_conversion:test().	