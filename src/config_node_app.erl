%%%-------------------------------------------------------------------
%% @doc config_node public API
%% @end
%%%-------------------------------------------------------------------

-module(config_node_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    config_node_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
