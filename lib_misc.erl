-module(lib_misc).
-export([test/0]).

on_exit(Pid, Fun) ->
    spawn(
        fun() -> 
            Ref = monitor(process, Pid),
            receive 
                {'DOWN', Ref, process, Pid, Why} ->
                    Fun(Why)
            end
        end
    ).

test() ->
    F = fun() -> 
            receive  
                X -> list_to_atom(X)
            end
        end,
    Pid = spawn(F),
    on_exit(Pid, fun(Why) -> io:format("~p died, reason:~p~n", [Pid, Why]) end),

    receive
    after 2000->
        Pid ! hello
    end.    

