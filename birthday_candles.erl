-module(birthday_candles).
-export([main/0, read_list_rec/2, birthday_cake_candles/1, read_list_chunk/1]).
-import(os, [getenv/1]).

%
% Complete the 'birthdayCakeCandles' function below.
%
% The function is expected to return an INTEGER.
% The function accepts INTEGER_ARRAY candles as parameter.
%

birthday_cake_candles_rec([], Max, Nmax) -> {Max, Nmax};
birthday_cake_candles_rec([C | Candles], Max, Nmax)
  when C < Max ->
    birthday_cake_candles_rec(Candles, Max, Nmax);
birthday_cake_candles_rec([C | Candles], Max, _)
  when C > Max ->
    birthday_cake_candles_rec(Candles, C, 1);
birthday_cake_candles_rec([Max | Candles], Max, Nmax) ->
    birthday_cake_candles_rec(Candles, Max, Nmax + 1).


birthday_cake_candles(Candles) ->
    {_, N} = birthday_cake_candles_rec(Candles, 0, 0),
    N.

read_list_rec(0, SoFar) -> SoFar;
read_list_rec(N, SoFar) ->
    {ok, [M]} = io:fread("", " ~d"),
    read_list_rec(N - 1, [M | SoFar]).

read_ints_rec([], Acc, Leftover, N) -> {Acc, Leftover, N};
read_ints_rec([C | Buf], Acc, Leftover, N)
  when (C >= $0) and (C =< $9) ->
    read_ints_rec(Buf, Acc, Leftover * 10 + (C - 48), N + 1);
read_ints_rec([_ | Buf], Acc, Leftover, N) ->
    read_ints_rec(Buf, [Leftover | Acc], 0, N + 1).

read_ints(Buf, Leftover, N) ->
    read_ints_rec(Buf, [], Leftover, N).

read_list_chunk(Leftover) ->
    {ok, Buf} = file:read(standard_io, 512),
    read_ints(Buf, Leftover, 0).

read_list_ints(Leftover, Total) ->
    case read_list_chunk(Leftover) of
        {Acc, Rem, 512} ->
            read_list_ints(Rem, lists:append([Total, Acc]));
        {Acc, Rem, _} -> lists:append([Total, Acc, [Rem]])
    end.

print_time() ->
    TS = erlang:timestamp(),
    {_, _, Micro} = TS,
    {_, {H, M, S}} = calendar:now_to_universal_time(TS),
    io:fwrite(
      "~2..0w:~2..0w:~2..0w.~6..0w~n", [H, M, S, Micro]
     ).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
    {ok, [N]} = io:fread("", " ~d"),
    io:fwrite("Will read ~w integers~n", [N]),
    print_time(),
    Candles = read_list_ints(0, []),
    print_time(),
    io:fwrite("Finished reading input~n", []),
    Result = birthday_cake_candles(Candles),
    print_time(),
    io:fwrite("Finished computing~n", []),
    io:fwrite(Fptr, "~w~n", [Result]),
    file:close(Fptr),
    ok.


%% main() ->
%%     Ints = read_list_ints(0, []),
%%     io:fwrite("Ints: ~w, ~w~n", [lists:sublist(Ints, 10), length(Ints)]),
%%     ok.
