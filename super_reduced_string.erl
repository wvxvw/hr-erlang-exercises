-module(super_reduced_string).
-export([main/0, super_reduced_string/1]).
-import(os, [getenv/1]).

%
% Complete the 'superReducedString' function below.
%
% The function is expected to return a STRING.
% The function accepts STRING s as parameter.
%

super_reduced_string_rec([], _, R) -> lists:reverse(R);
super_reduced_string_rec([S, S | Ss], N, R) ->
    super_reduced_string_rec(Ss, N + 1, R);
super_reduced_string_rec([S1 | S], N, R) ->
    super_reduced_string_rec(S, N + 1, [S1 | R]).

super_reduced_string(S) ->
    case super_reduced_string_rec(S, 0, []) of
        [] -> "Empty String";
        X -> case super_reduced_string_rec(X, 0, []) of
                 X -> X;
                 Y -> super_reduced_string(Y)
             end
    end.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    S = case io:get_line("") of
            eof -> "";
            SData -> re:replace(SData, "(\\r\\n$)|(\\n$)", "", [global, {return, list}])
        end,

    Result = super_reduced_string(S),
    io:fwrite(Fptr, "~s~n", [Result]),
    file:close(Fptr),
    ok.
