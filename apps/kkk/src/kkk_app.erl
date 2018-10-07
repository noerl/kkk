%%%-------------------------------------------------------------------
%% @doc kkk public API
%% @end
%%%-------------------------------------------------------------------

-module(kkk_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(normal, []) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", cowboy_static, {priv_file, kkk, "index.html"}},
			{"/websocket", kkk_ws, []},
			{"/xx", kkk_handle_xx, []},
			{"/static/[...]", cowboy_static, {priv_dir, kkk, "static"}}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
    kkk_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
