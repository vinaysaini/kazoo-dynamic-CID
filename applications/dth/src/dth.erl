%%%-------------------------------------------------------------------
%%% @copyright (C) 2011-2013, 2600Hz
%%% @doc
%%% Application for passing CDRs to DTH billing service
%%% @end
%%% @contributors
%%%   James Aimonetti
%%%-------------------------------------------------------------------
-module(dth).

-export([start_link/0
         ,start/0
         ,stop/0
         ,add_binding_to_q/2
         ,rm_binding_from_q/1
        ]).

-include("dth.hrl").

%%--------------------------------------------------------------------
%% @public
%% @doc
%% Starts the app for inclusion in a supervisor tree
%% @end
%%--------------------------------------------------------------------
-spec start_link() -> startlink_ret().
start_link() ->
    _ = start_deps(),
    _ = declare_exchanges(),
    dth_sup:start_link().

%%--------------------------------------------------------------------
%% @public
%% @doc
%% Starts the application
%% @end
%%--------------------------------------------------------------------
-spec start() -> 'ok' | {'error', _}.
start() ->
    application:start(?MODULE).

%%--------------------------------------------------------------------
%% @public
%% @doc
%% Stop the app
%% @end
%%--------------------------------------------------------------------
-spec stop() -> 'ok'.
stop() -> 
    exit(whereis('dth_sup'), 'shutdown'),
    'ok'.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Ensures that all dependencies for this app are already running
%% @end
%%--------------------------------------------------------------------
-spec start_deps() -> 'ok'.
start_deps() ->
    whistle_apps_deps:ensure(?MODULE), % if started by the whistle_controller, this will exist
    _ = [wh_util:ensure_started(App) || App <- ['crypto'
                                                ,'inets'
                                                ,'lager'
                                                ,'whistle_amqp'
                                                ,'whistle_couch'
                                               ]],
    'ok'.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Ensures that all exchanges used are declared
%% @end
%%--------------------------------------------------------------------
-spec declare_exchanges() -> 'ok'.
declare_exchanges() ->
    _ = wapi_call:declare_exchanges(),
    wapi_self:declare_exchanges().


add_binding_to_q(Q, _Props) ->
    amqp_util:bind_q_to_callmgr(Q, ?KEY_DTH_BLACKLIST_REQ),
    'ok'.

rm_binding_from_q(Q) ->
    amqp_util:unbind_q_from_callmgr(Q, ?KEY_DTH_BLACKLIST_REQ).