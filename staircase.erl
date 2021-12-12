-module(staircase).
-export([main/0]).

%
% Complete the 'staircase' function below.
%
% The function accepts INTEGER n as parameter.
%

stair(0) -> false;
stair(M) ->
    io:fwrite("#"),
    stair(M - 1).

white(1) -> false;
white(M) ->
    io:fwrite(" "),
    white(M - 1).

staircase_rec(N, N) -> false;
staircase_rec(N, M) ->
    white(N - M),
    stair(M + 1),
    io:fwrite("~n"),
    staircase_rec(N, M + 1).

staircase(N) -> staircase_rec(N, 0).

main() ->
    {ok, [N]} = io:fread("", " ~d"),
    staircase(N),
    ok.
