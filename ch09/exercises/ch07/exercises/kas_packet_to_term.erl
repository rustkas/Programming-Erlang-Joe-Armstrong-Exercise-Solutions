%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% packet_to_term(Packet) -> Term
%%

-module(kas_packet_to_term).
-export([test/0]).
-export([packet_to_term/1]).

%% File: "kas_packet_to_term.erl"
%% ------------------------------
-spec test1() -> 'true'.

test1() ->
	Value = [],
	Packet = kas_term_to_packet:term_to_packet(Value),
	true = Value =:= packet_to_term(Packet).
	
-spec test() -> 'test_worked'.
test() ->
	test1(),
	
	test_worked.

-spec packet_to_term(Packet :: <<_:32,_:_*8>>) -> Result :: term().
	
packet_to_term(<<_Size:4/integer-unit:8, Bin/binary>>) ->
	binary_to_term(Bin).
	

% c(kas_packet_to_term).
% c(kas_packet_to_term). kas_packet_to_term:test().	