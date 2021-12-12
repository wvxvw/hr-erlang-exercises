-module(min_max_sum).
-export([main/0]).

%
% Complete the 'miniMaxSum' function below.
%
% The function accepts INTEGER_ARRAY arr as parameter.
%

int_list(X) ->
    SI = re:replace(X, "(^\\s+)|(\\s+$)", "", [global, {return, list}]),
    {I, _} = string:to_integer(SI),
    I.

mini_max_sum(Arr) ->
    Sorted = lists:sort(Arr),
    Mins = lists:droplast(Sorted),
    [_ | Maxs] = Sorted,
    Min = lists:sum(Mins),
    Max = lists:sum(Maxs),
    io:fwrite("~w ~w~n", [Min, Max]).

main() ->
    NoWhites = re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
    ArrTemp = re:split(NoWhites, "\\s+", [{return, list}]),
    Arr = lists:map(fun int_list/1, ArrTemp),
    mini_max_sum(Arr),
    ok.
