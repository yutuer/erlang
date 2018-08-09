-module(afile_client).
-export([ls/1, get_file/1]).

ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {_, FileList} -> FileList
    end.

get_file(Server) ->
    Server ! {self(), {get_file, "afile_server.erl"}},
    receive
        {_, Content} -> Content
    end.


