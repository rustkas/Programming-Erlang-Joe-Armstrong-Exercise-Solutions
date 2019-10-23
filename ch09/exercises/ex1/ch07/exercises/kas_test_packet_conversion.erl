%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% 
%%

-module(kas_test_packet_conversion).
-export([test/0]).

%% File: "kas_packet_to_term.erl"
%% ------------------------------

-spec test1() -> 'true'.

test1() ->
	Value = [],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

-spec test2() -> 'true'.
test2() ->
	Value = 10,
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).
	
-spec test3() -> 'true'.
	
test3() ->
	Value = hello,
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

-spec test4() -> 'true'.

test4() ->
	Value = [3.12, hello, {abc, 1}],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

-spec test5() -> 'true'.
	
test5() ->
	Value = [{"Hello World1"}],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).

-spec test() -> 'test_worked'.

test() ->
	test1(),
	test2(),
	test3(),
	test4(),
	test4(),
	test5(),
	test_worked.

-spec packet_to_term(Packet :: <<_:32,_:_*8>>) -> Result :: term().
	
packet_to_term(<<_Size:4/integer-unit:8, Bin/binary>>) ->
	binary_to_term(Bin).
	

% c(kas_test_packet_conversion).
% c(kas_test_packet_conversion). kas_test_packet_conversion:test().	