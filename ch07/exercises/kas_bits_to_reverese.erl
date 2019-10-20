%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% 
%%

-module(kas_bits_to_reverese).
-export([test/0]).
-export([reverse_bits/1]).

test1() ->
	X = 2#11010101,
	Bin = <<X>>,
	true = <<"Õ">> =:= Bin,
	Result = reverse_bits(Bin),
	true = <<"«">> =:= Result.
	
test2() ->
	X = 2#1010,
	Y = bnot X,
	X = bnot Y,
	io:format("X = ~8.2.0B; Y = ~8.2.0B~n",[X,Y]),
	io:format("<<X>> = ~p; <<Y>> = ~p~n",[<<X>>,<<Y>>]),
	true = is_bitstring(<<X>>),
	Result = reverse_bits(<<X>>),
	<<Y_Result>> = Result,
	io:format("Y_Result = ~8.2.0B~n",[Y_Result]),
	true = Y =:= Y_Result.
	

test() ->
	test1(),
	test2(),
	test_worked.
	
reverse_bits(Bin) ->
    reverse_bits(Bin, <<>>).

reverse_bits(<<>>, Acc) ->
    Acc;	
reverse_bits(<<X:1/bitstring, Rest/bitstring>>, Acc) ->
	io:format("Acc = ~p~n",[bitstring_to_list(Acc)]),
	lists:map(fun(X1) ->
		io:format(" ~p~n",[is_integer(X1)]),
		io:format(" = ~8.2.0B",[binary_to_integer(X1)]) 
		
		end, bitstring_to_list(Acc)),
    io:nl(),
	reverse_bits(Rest, << X/bitstring, Acc/bitstring >>).


% c(kas_bits_to_reverese).
% c(kas_bits_to_reverese). kas_bits_to_reverese:test().