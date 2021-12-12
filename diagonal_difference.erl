-module(diagonal_difference).
-export([main/1, read_matrix/2]).
-import(os, [getenv/1]).

%
% Complete the 'diagonalDifference' function below.
%
% The function is expected to return an INTEGER.
% The function accepts 2D_INTEGER_ARRAY arr as parameter.
%

diagonal_difference_rec(Size, Size, _, SoFar) -> abs(SoFar);
diagonal_difference_rec(Row, Size, Mat, SoFar) ->
    Left = array:get(Row * Size + Row, Mat),
    Right = array:get(Row * Size + (Size - Row - 1), Mat),
    diagonal_difference_rec(Row + 1, Size, Mat, SoFar + Left - Right).

diagonal_difference({Size, Mat}) ->
    diagonal_difference_rec(0, Size, Mat, 0).

read_matrix_rec(Arr, N, 0, N, _) -> Arr;
read_matrix_rec(Arr, X, Y, N, Fptr) ->
    {ok, [I]} = io:fread(Fptr, "", " ~d"),
    Narr = array:set(X * N + Y, I, Arr),
    case Y + 1 of
        N -> read_matrix_rec(Narr, X + 1, 0, N, Fptr);
        _ -> read_matrix_rec(Narr, X, Y + 1, N, Fptr)
    end.

read_matrix(N, Fptr) ->
    Result = array:new(N * N),
    {N, read_matrix_rec(Result, 0, 0, N, Fptr)}.

main(Path) ->
    {ok, Fptr} = file:open(Path, [read]),
    io:fwrite("Opened file~n", []),
    {ok, [N]} = io:fread(Fptr, "", " ~d"),
    io:fwrite("Rading matrix of size ~w~n", [N]),
    Arr = read_matrix(N, Fptr),
    Result = diagonal_difference(Arr),
    io:fwrite("~w~n", [Result]),
    file:close(Fptr),
    ok.
