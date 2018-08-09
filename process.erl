-module(process).
-export([max/1]).

max(N) ->
    Max = erlang:system_info(process_limit),
    io:format("max allow process, ~p~n", [Max]),
    N.