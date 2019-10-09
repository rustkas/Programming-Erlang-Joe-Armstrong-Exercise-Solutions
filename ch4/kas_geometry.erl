%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
-module(kas_geometry).
-export([test/0, area/1,  perimeter/1,circumference/1]).

%% test function
test() ->

	% Area
	%
	% calculating an area of square with side = 2
	4 = area({square,2}),
	
	
	% calculating an area of the rectangle with width = 3, hight = 4
	12  = area({rectangle,3,4}),
	
	% calculating an area of the circle with radius = 10
	314.159 = area({circle,10}),
	
	%------------------
	% Perimeter
	%
	8 = perimeter({square, 2}),
	
	
	true = 5.7 >= perimeter({square_d, 2}),
	
	10 = perimeter({rectangle, 2, 3}),
	8 = perimeter({rhombus, 2}),
	true = 3.14159*2*2 =/= perimeter({circle, 2}),
	4 = perimeter({trapeze,1,1,1,1}),
	
	true = float_to_binary(math:pi()) =/= float_to_binary(circumference({radius, 1})),
	true = float_to_binary(math:pi()) == float_to_binary(circumference({diameter, 1})),
	test_ok.
	
%% area function	
area({square, Side})				-> Side * Side;	
area({rectangle, Width, Height}) 	-> Width * Height;
area({circle, Radius})				-> 3.14159 * Radius * Radius.


%% perimeter function
perimeter({square, Side}) 				-> 4 * Side;
perimeter({square_d, Diagonal}) 		-> 2* math:sqrt(2) * Diagonal;
perimeter({rectangle, Width, Height}) 	-> 2 * (Width + Height);
perimeter({rhombus, Side}) 				-> 4 * Side;
perimeter({trapeze,Side_A,Side_B,Side_C,Side_D}) -> Side_A + Side_B + Side_C + Side_D;
perimeter({circle, Radius}) 			-> 2 * math:pi() * Radius.

%% circumference
circumference({radius, Radius}) -> 2 * math:pi() * Radius;
circumference({diameter, Diameter}) -> math:pi() * Diameter.

%% commands
%
% c(kas_geometry).
% c(kas_geometry). kas_geometry:test().

% erlc kas_geometry.erl && erl -noshell -s kas_geometry test -s init stop
