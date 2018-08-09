-module(lib_misc).
-export([test/0]).

on_exit(Pid, Fun) ->
    spawn(fun() -> 
            Ref = monitor(process, Pid),
            receive
                {'DOWN', Ref, process, Pid, Why} ->
                    Fun(Why)
            end    
    end).


test() ->
    F = fun() -> 
            receive 
                X -> list_to_atom(X)
            end
        end,
    Pid = spawn(F),
    io:format("Pid:~p~n", [Pid]),
    Fun = fun(Why) ->
        io:format("~p died with:~p~n", [Pid, Why])
    end,
    on_exit(Pid,  Fun),
    Pid ! hello .
