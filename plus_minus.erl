-module(plus_minus).
-export([main/0]).

%
% Complete the 'plusMinus' function below.
%
% The function accepts INTEGER_ARRAY arr as parameter.
%


list_stats(B, [Gt, Lt, Eq]) ->
    case B > 0 of
        true ->  [Gt + 1, Lt, Eq];
        false -> case B < 0 of
                     true -> [Gt, Lt + 1, Eq];
                     false -> [Gt, Lt, Eq + 1]
                 end
    end.
            

to_six_digits(Len) -> 
    fun (N) -> io:fwrite("~.6f~n", [N / Len]) end.

plus_minus(Arr) ->
    Sums = lists:foldl(fun list_stats/2, [0, 0, 0], Arr),
    Len = length(Arr),
    _ = lists:map(to_six_digits(Len), Sums).

to_int_trimmed(X) ->
    Trimmed = re:replace(X, white(), "", [global, {return, list}]),
    {I, _} = string:to_integer(Trimmed),
    I.

white() -> "(^\\s+)|(\\s+$)".

main() ->
    _ = io:get_line(""),
    LTrimmed = re:replace(io:get_line(""), "\\s+$", "", [global, {return, list}]),
    ArrTemp = re:split(LTrimmed, "\\s+", [{return, list}]),
    Arr = lists:map(fun to_int_trimmed/1, ArrTemp),
    plus_minus(Arr),
    ok.
