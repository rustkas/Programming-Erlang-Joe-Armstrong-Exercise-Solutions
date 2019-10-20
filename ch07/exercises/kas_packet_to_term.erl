%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% packet_to_term(Packet) -> Term
%%

-module(kas_packet_to_term).
-export([test/0]).
-export([packet_to_term/1]).

test1() ->
	Value = [],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).
	

test() ->
	test1(),
	
	test_worked.
	
packet_to_term(<<_Size:4/integer-unit:8, Bin/binary>>) ->
	binary_to_term(Bin).
	

% c(kas_packet_to_term).
% c(kas_packet_to_term). kas_packet_to_term:test().	