%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Working with Geometry things
-module(kas_geometry).
-export([test/0, area/1,  perimeter/1,circumference/1]).

%% File: "kas_geometry.erl"
%% ------------------------

%% test function

-spec test() -> 'test_ok'.

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
-spec area({'circle',Radius} | {'square',Side} | {'rectangle',Width,Height} | {'triangle',A,B,C}) -> Area when 
	Radius :: float(),
	Side :: float(),
	Width :: float(),
	Height :: float(),
	A :: float(),
	B :: float(),
	C :: float(),
	Area :: float().

area({square, Side}) when Side > 0	-> Side * Side;	
area({rectangle, Width, Height}) when Width > 0, Height > 0 -> Width * Height;
area({triangle, A,B,C}) when A > 0, B > 0, C > 0 -> P=(A+B+C)/2,math:sqrt(P*(P-A)*(P-B)*(P-C));
area({circle, Radius})				-> 3.14159 * Radius * Radius.


%% perimeter function
-spec perimeter({'circle', Radius} | {'rhombus', Side} | {'square', Side}
 | {'square_d', Diagonal} | {'rectangle', Width, Height} | {'trapeze', Side_A, Side_B,Side_C,Side_D}) -> Perimeter when 
	Radius :: float(),
	Side :: float(),
	Diagonal :: float(),
	Width :: float(),
	Height :: float(),
	Side_A :: float(),
	Side_B :: float(),
	Side_C :: float(),
	Side_D :: float(),
	Perimeter :: float().

perimeter({square, Side}) when Side > 0 -> 4 * Side;
perimeter({square_d, Diagonal}) when Diagonal > 0 -> 2* math:sqrt(2) * Diagonal;
perimeter({rectangle, Width, Height}) when Width > 0, Height > 0 -> 2 * (Width + Height);
perimeter({rhombus, Side}) when Side > 0 -> 4 * Side;
perimeter({trapeze,Side_A,Side_B,Side_C,Side_D})  when Side_A > 0,Side_B > 0,Side_C > 0,Side_D > 0	-> Side_A + Side_B + Side_C + Side_D;
perimeter({circle, Radius}) when Radius > 0 -> 2 * math:pi() * Radius.

%% circumference
-spec circumference({'diameter',Diameter} | {'radius', Radius}) -> Circumference when
	Diameter :: float(),
	Radius :: float(),
	Circumference :: float().

circumference({diameter, Diameter}) when Diameter >0 	-> math:pi() * Diameter;
circumference({radius, Radius}) when Radius >0	-> 2 * math:pi() * Radius.

%% commands
%
% c(kas_geometry).
% c(kas_geometry). kas_geometry:test().

% erlc kas_geometry.erl && erl -noshell -s kas_geometry test -s init stop
