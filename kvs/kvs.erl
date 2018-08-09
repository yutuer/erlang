-module(kvs).
-export([start/0, store/2, lookUp/1]).

start() ->
    register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) ->
    rpc({store, Key, Value}).

lookUp(Key) ->
    rpc({lookUp, Key}).

rpc(Msg) ->
    kvs ! {self(), Msg},
    receive
        {kvs, Reply} -> Reply
    end.

loop() ->
    receive 
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, success},
            loop();
         {From, {lookUp, Key}} ->
            From ! {kvs, get(Key)},   
            loop()
    end.
    