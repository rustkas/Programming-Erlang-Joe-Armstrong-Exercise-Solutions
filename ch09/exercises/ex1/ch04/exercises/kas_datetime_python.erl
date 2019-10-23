%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% Implementating  my_time_func, my_date_string().
%% There functions are hidden.
%%
-module(kas_datetime_python).
-export([test/0]).
-export([today/0,date/0,time/0,weekday/1,weekday_text/2]).

-type unistring() :: unicode:chardata().
-export_type([unistring/0]).

-type year() :: non_neg_integer().
-type month_id() :: 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12.
-type day_month_id() :: 1..255.
-opaque date() :: {year(), month_id(), day_month_id()}.
-export_type([date/0]).


-type hour() :: 0..23.
-type minute() :: 1..59.
-type second() :: 1..59.
-opaque time() :: {hour(), minute(), second()}.
-export_type[time/0].


%% File: "kas_datetime_python.erl"
%% -------------------------------
-spec test() -> 'ok'.

test() ->
	Today = today(),
	
	io:fwrite("Today: ~p", [Today]),
	io:nl(),
	
	CurrenDate = kas_datetime_python:date(),
	CurrenDate = erlang:date(),	
	io:fwrite("Current date: ~p.~p.~p", [element(3,CurrenDate), element(2,CurrenDate), element(1,CurrenDate)]),
	io:nl(),
	
	CurrenTime = kas_datetime_python:time(),
	CurrenTime = erlang:time(),
	io:fwrite("Current time: ~p:~p:~p", [element(1,CurrenTime), element(2,CurrenTime), element(3,CurrenTime)]),
	io:nl(),	
	
	CurrentWeekDay = weekday(CurrenDate),
	CurrentWeekDay = calendar:day_of_the_week(kas_datetime_python:date()) - 1,
	io:fwrite("Number of current day of week: ~p", [CurrentWeekDay]),
	io:nl(),
	
	% English
	CurrentWeekDayName = weekday_text(CurrentWeekDay, en),
	io:fwrite("Current day of week: ~p", [CurrentWeekDayName]),
	io:nl(),
	% Russian
	CurrentWeekDayNameRu = weekday_text(CurrentWeekDay, ru),
	io:fwrite("Название текущего дня недели: ~ts", [CurrentWeekDayNameRu]),
	io:nl(),
	% Deutsch
	CurrentWeekDayNameDe = weekday_text(CurrentWeekDay, de),
	io:fwrite("Aktueller Wochentag: ~ts", [CurrentWeekDayNameDe]),
	io:nl(),
	% Armenian
	CurrentWeekDayNameAm = weekday_text(CurrentWeekDay, am),
	io:fwrite("Շաբաթվա ընթացիկ օր: ~ts", [CurrentWeekDayNameAm]),
	io:nl(),
	% Thai
	CurrentWeekDayNameTh = weekday_text(CurrentWeekDay, th),
	io:fwrite("วันปัจจุบันของสัปดาห์: ~ts", [CurrentWeekDayNameTh]),
	io:nl(),
	
	% Chinese
	CurrentWeekDayNameCh = weekday_text(CurrentWeekDay, ch),
	io:fwrite("星期几: ~ts", [CurrentWeekDayNameCh]),
	io:nl(),
	
	% Korean
	CurrentWeekDayNameKr = weekday_text(CurrentWeekDay, kr),
	io:fwrite("현재 요일: ~ts", [CurrentWeekDayNameKr]),
	io:nl(),
	
	ok.

%% Since As from Erlang/OTP 18 erlang:now/0 is depricated
%% Read more at http://erlang.org/doc/apps/erts/time_correction.html
%-spec today() -> [byte(),...].
-spec today() -> string().
today() ->
	calendar:system_time_to_rfc3339(erlang:system_time(second)).

%% Return current date as a tuple
-spec date() -> Date when
	Date :: date().

date()	->
	{{_Year,_Month,_Day} = CurrenDate,{_Hour,_Min,_Sec}} = erlang:localtime(),
	CurrenDate.	

%% Return current time as a tuple
-spec time() -> {Hour, Minute, Second} when 
	Hour :: hour(), 
	Minute :: minute(), 
	Second :: second().

time() ->
	{{_Year,_Month,_Day},{_Hour,_Min,_Sec}= CurrenTime} = erlang:localtime(),
	CurrenTime.	

%% Return the day of the week represented by the date.
%% Monday = 0 ... Sunday = 6
-type week_day_id() :: 0 | 1 | 2 | 3 | 4 | 5 | 6.
-spec weekday(Date) -> WeekDayIdNumber when 
	Date :: date(),
	WeekDayIdNumber :: week_day_id().
	
weekday(Date) when is_tuple(Date) andalso tuple_size(Date) == 3 ->
	calendar:day_of_the_week(Date)-1.

%% Return text representation of the day of week
%% DayOfWeek is the number from 0 to 6.
%% Lang is the lang of the text representation
%1..1114111,...
%unicode:chardata()
-type language() :: 'am' | 'ch' | 'de' | 'dk' | 'en' | 'kr' | 'ru' | 'th'.
-type day_of_the_week() :: 0 | 1 | 2 | 3 | 4 | 5 | 6.

-spec weekday_text(DayOfTheWeek,Language) -> WeekDayName when 
	DayOfTheWeek :: day_of_the_week(),
	Language :: language(),
	WeekDayName :: unistring().
	
weekday_text(DayOfWeek, Lang) when DayOfWeek >= 0, DayOfWeek =< 6 ->
	WeekName = case Lang of 
		en ->
			case DayOfWeek of
				0 -> "Monday";
				1 -> "Tuesday";
				2 -> "Wednesday";
				3 -> "Thursday";
				4 -> "Friday";
				5 -> "Saturday";
				6 -> "Sunday"
			end;
		ru ->
			case DayOfWeek of 
				0 -> "Понедельник";
				1 -> "Вторник";
				2 -> "Среда";
				3 -> "Четверг";
				4 -> "Пятница";
				5 -> "Суббота";
				6 -> "Воскресенье"
			end;
		de ->
			case DayOfWeek of 
				0 -> "Montag";
				1 -> "Dienstag";
				2 -> "Mittwoch";
				3 -> "Donnerstag";
				4 -> "Freitag";
				5 -> "Samstag";
				6 -> "Sonntag"
			end;	
		dk ->
			case DayOfWeek of
				0 -> "Mandag";
				1 -> "Tirsdag";
				2 -> "Onsdag";
				3 -> "Torsdag";
				4 -> "Fredag";
				5 -> "Lørdag";
				6 -> "Søndag"
			end;
		am ->
			case DayOfWeek of 
				0 -> "Երկուշաբթի";
				1 -> "Երեքշաբթի";
				2 -> "Չորեքշաբթի";
				3 -> "Հինգշաբթի";
				4 -> "Ուրբաթ";
				5 -> "Շաբաթ";
				6 -> "Կիրակի"
			end;
			 	 	 	 	 	 	 
		th ->
			case DayOfWeek of 
				0 -> "วันจันทร์";
				1 -> "วันอังคาร";
				2 -> "วันพุธ";
				3 -> "วันพฤหัสบดี";
				4 -> "วันศุกร์";
				5 -> "วันเสาร์";
				6 -> "วันอาทิตย์"
			end;
		ch ->
			case DayOfWeek of
				0 -> "月";
				1 -> "火";
				2 -> "水";
				3 -> "木";
				4 -> "金";
				5 -> "土";
				6 -> "日"
			end;
		kr ->
			case DayOfWeek of 
				0 -> "월요일";
				1 -> "화요일";
				2 -> "수요일";
				3 -> "목요일";
				4 -> "금요일";
				5 -> "토요일";
				6 -> "일요일"
			end
	end,
	WeekName.

% c(kas_datetime_python).
% kas_datetime_python:test().
% c(kas_datetime_python). kas_datetime_python:test().
% calendar:now_to_datetime(er)
% calendar:seconds_to_daystime(erlang:system_time()).
% calendar:day_of_the_week(erlang:date()).
% calendar:day_of_the_week(kas_datetime_python:date()).
