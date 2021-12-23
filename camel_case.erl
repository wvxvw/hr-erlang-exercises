-module(camel_case).
-export([main/0, camelcase/1]).
-import(os, [getenv/1]).

%
% Complete the 'camelcase' function below.
%
% The function is expected to return an INTEGER.
% The function accepts STRING s as parameter.
%

camelcase(S) -> length(re:split(S, "[A-Z]")).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    S = case io:get_line("") of
            eof -> "";
            SData -> re:replace(SData, "(\\r\\n$)|(\\n$)", "", [global, {return, list}])
        end,

    Result = camelcase(S),
    io:fwrite(Fptr, "~w~n", [Result]),
    file:close(Fptr),
    ok.
