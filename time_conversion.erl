-module(time_conversion).
-export([main/0, time_conversion/1, make_time/1]).
-import(os, [getenv/1]).

%
% Complete the 'timeConversion' function below.
%
% The function is expected to return a STRING.
% The function accepts STRING s as parameter.
%

make_time_nums(Nums) ->
    [{H, _}, {M, _}, {S, _}] = lists:map(fun string:to_integer/1, Nums),
    [H, M, S].

make_time([H0, H1, _, M0, M1, _, S0, S1 | "PM"]) ->
    [H, M, S] = make_time_nums([[H0, H1], [M0, M1], [S0, S1]]),
    [case H of 12 -> 12; _ -> H + 12 end, M, S];

make_time([H0, H1, _, M0, M1, _, S0, S1 | "AM"]) ->
    make_time_nums([[H0, H1], [M0, M1], [S0, S1]]).

time_conversion(T) ->
    [H, M, S] = make_time(T),
    io_lib:format("~2..0B:~2..0B:~2..0B", [H rem 24, M, S]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    S = case io:get_line("") of
            eof -> "";
            SData -> re:replace(SData, "(\\r\\n$)|(\\n$)", "", [global, {return, list}])
        end,

    Result = time_conversion(S),
    io:fwrite(Fptr, "~s~n", [Result]),
    file:close(Fptr),
    ok.
