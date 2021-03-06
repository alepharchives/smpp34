
-module(smpp34_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, infinity, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, { {one_for_one, 5, 10}, [?CHILD(smpp34_log_sup, supervisor),
                                  ?CHILD(smpp34_snum_sup, supervisor),
                                  ?CHILD(smpp34_hbeat_sup, supervisor),
			 					  ?CHILD(smpp34_tcprx_sup, supervisor),
								  ?CHILD(smpp34_tx_sup, supervisor),
								  ?CHILD(smpp34_rx_sup, supervisor),
								  ?CHILD(smpp34_esme_core_sup, supervisor)]}}.

