%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%%

-module(kas_byte_reverse).
-export([test/0]).
-export([reverse_binary/1,reverse_binary_bif/1]).

%% File: "kas_byte_reverse.erl"
%% ----------------------------

-spec list_generator(Counter :: pos_integer()) -> Result :: [1].

list_generator(C) when C > 0 ->
	list_generator(C, []).

-spec list_generator(Counter :: 0,List :: list()) -> Result :: list();
					(Counter :: pos_integer(),List :: [1]) -> Result :: [1].

list_generator(0, L) when is_list(L)->	
	L;
list_generator(C, L) ->
	list_generator(C - 1, [1|L]).

-spec test() -> 'test_worked'.

test() ->
	%io:fwrite("~p",[time()]),


	true = <<"olleh">> =:= reverse_binary(<<"hello">>),
	true = <<"olleh">> =:= reverse_binary_bif(<<"hello">>),

	% Find fastest function for reversing:

	String = list_to_binary(list_generator(10000)),
	io:fwrite("~p",[String]),

	T1_1 = erlang:timestamp(),
	reverse_binary(String),
	T1_2 = erlang:timestamp(),
	Sec1 = timer:now_diff(T1_2, T1_1)/1000000,

	T2_1 = erlang:timestamp(),
	reverse_binary_bif(String),
	T2_2 = erlang:timestamp(),
	Sec2 = timer:now_diff(T2_2, T2_1)/1000000,

	%io:fwrite("~p, ~p, ~p, ~p ~n",[T1_1, T1_2, T1_2, T2_2]),
	io:fwrite("binary time = ~p sec, bif time = ~p sec ~n",[Sec1, Sec2]),

	% Test shows that using BIF is prefer way to work with binary manipulation

	test_worked.

%% Using binary as a container
-spec reverse_binary(String :: binary()) -> Result :: binary().

reverse_binary(B) when is_binary(B) ->
    reverse_binary(B, <<>>).

-spec reverse_binary(String :: binary(),Accumulator :: binary()) -> Result :: binary().

reverse_binary(<<H, T/binary>>, Acc) when is_binary(Acc) ->
    reverse_binary(T, <<H, Acc/binary>>);
reverse_binary(<<>>, Acc) ->                  
    Acc.

%% Using BIF fuctions (converters, reverse functions)
%% Fastest worsion of reversing.
-spec reverse_binary_bif(String :: binary()) -> Result :: binary().

reverse_binary_bif(B) ->
	L = binary_to_list(B),
	RL = lists:reverse(L),
	list_to_binary(RL).
	
	
% c(kas_byte_reverse).
% c(kas_byte_reverse). kas_byte_reverse:test(). 