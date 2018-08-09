-module(stimer).
-export([start/2, cancel/1]).

start(Fun, T) -> register(clock, spawn(fun() -> timer(Fun, T) end)).
cancel(Pid) -> Pid ! cancel.
timer(F, T) ->
    receive
        cancel ->
            void
        after T->
            Ret = F(),
            io:format("~p~n", [Ret]),
            timer(F, T)
    end.