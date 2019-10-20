%% @author Anatolii Kosorukov <java1cprog@yandex.ru>
%% @copyright 2019 by rustkas
%% @version 1.0
%% 
%%
-module(kas_bif_modules_research).
-export([test/0]).
-export([module_loaded_list/0]).
-export([most_exports/0]).
-export([function_name_list_all_loaded_modules/0]).

test_module_loaded_list() ->
	List = module_loaded_list(),
	true = length(List) > 0,
	io:format("List Modules loaded:~n"),
	lists:map(fun(X)-> io:format("~p, ", [X]) end, List),
	io:nl(),
	io:format("--------------------------~n").

test_max_most_exports() ->
	
	{ModName, Count} = most_exports(),
	io:format("Module name with max export functions count is ==> ~p <==~n", [ModName]),
	io:format("Max export functions count is ==> ~p <==~n", [Count]),
	io:format("--------------------------~n").

test_most_common_function_name() ->

	SortedFunctionNameCountList = function_name_list_all_loaded_modules(),	
	% get most popular function names	
	[{PopularFunctionName1,PopularFunctionCount1},
	{PopularFunctionName2,PopularFunctionCount2},
	{PopularFunctionName3,PopularFunctionCount3}|_SortedFunctionNameCountListTail] = SortedFunctionNameCountList,
	
	io:format("Most popular function names:~n"),
	io:format("1. ~p=~p~n",[PopularFunctionName1,PopularFunctionCount1]),
	io:format("2. ~p=~p~n",[PopularFunctionName2,PopularFunctionCount2]),
	io:format("3. ~p=~p~n",[PopularFunctionName3,PopularFunctionCount3]),
	
	io:format("--------------------------~n").
	
test_unambiguous_function_names() ->
	SortedUnambiguousFunctionNameList = unambiguous_function_names(),
	io:format("~p~n",[SortedUnambiguousFunctionNameList]),
	io:format("Count of such names = ~p~n",[length(SortedUnambiguousFunctionNameList)]),
	io:format("--------------------------~n").
	
test() ->
	test_module_loaded_list(),
	test_max_most_exports(),
	test_most_common_function_name(),
	test_unambiguous_function_names(),	
	
	test_worked.

%% This function finds all unambiguous function names, that is, 
%% function names that are used in only one module.
unambiguous_function_names() ->

	% get list from a map of function names and its count in the list
	FunctionNameCountList = function_name_count_list(),
	
	UnambiguousFunctionNameList = lists:filter(fun({_,X})-> X =:= 1 end, FunctionNameCountList),
	
	% get only names of functions
	UnambiguousFunctionNames = lists:map(fun({X,_})-> X end, UnambiguousFunctionNameList),
	
	% get sorted list of function names
	SortedUnambiguousFunctionNameList =  lists:sort(UnambiguousFunctionNames),
	SortedUnambiguousFunctionNameList.


%% Return function name list all loaded modules
%% Each item is {moduleName, count}
%% List sorted in descending order
function_name_list_all_loaded_modules() ->
	
	% get list from a map of function names and its count in the list
	FunctionNameCountList = function_name_count_list(),
	
	% get sorted list of function names and its count
	SortedFunctionNameCountList =  lists:sort(fun descending/2, FunctionNameCountList),
	SortedFunctionNameCountList.

%% Get list from a map of function names and its count in the list
function_name_count_list()->
	% get list of loaded module info (tuple)
	List = code:all_loaded(),
	
	% get list of loaded module names
	LoadedModules = lists:sort(lists:map(fun({X,_Y})-> X end, List)),
	
	% get lists of functions of loaded modules
	ModuleNameLists = lists:map(fun(ModuleName)-> ModuleName:module_info(exports) end, LoadedModules),
	
	% get a list of tuples {functionName, arity} of all function names of all loaded modules 
	MergedModuleNameLists = lists:merge(ModuleNameLists),
	
	% get a list of function names of all loaded modules 
	FunctionNameList = lists:map(fun({FunctionName, _Arity})-> FunctionName end, MergedModuleNameLists),
	
	% get map of function names and its count in the list
	FunctionNameCountMap = string_count(FunctionNameList),
	
	% get list from a map of function names and its count in the list
	FunctionNameCountList = maps:to_list(FunctionNameCountMap),
	FunctionNameCountList.

% Reutrn all loaded modules info
all_loaded()->
	List = code:all_loaded(),
	LoadedModules = lists:map(fun({X,_Y})-> {X,kas_export_count:export_count(X)} end, List),
	LoadedModules.

%% Return Tuple {Module name, Export functions count}
most_exports() ->
	LoadedModules = all_loaded(),
	SortedLoadedModules = lists:sort(fun descending/2, LoadedModules),
	hd(SortedLoadedModules).

%% Return list of tuples {ModuleName, ExportedFunctionCount}
module_loaded_list() ->
	LoadedModules = all_loaded(),
	LoadedModuleNames = lists:map(fun({X,_}) -> X end, LoadedModules),
    SortedLoadedModuleNames = lists:sort(LoadedModuleNames),
	SortedLoadedModuleNames.
	
%% Collect element count to the map
string_count(List) when is_list(List) ->
	string_count(List, #{}).

string_count([H|T], X) when is_map(X), is_map_key(H, X) ->
	N= map_get(H,X),
	string_count(T, X#{ H := N+1 });

string_count([H|T], X) ->
	string_count(T, X#{ H => 1 });

string_count([], X) ->
	X.

%% Return true if A > B
descending({_,A}, {_,B})-> 
	A > B.

	
% c(kas_bif_modules_research).
% c(kas_bif_modules_research). kas_bif_modules_research:test().