-module(kkk_ws).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

init(Req, Opts) ->
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
	self() ! start,
	{ok, State}.

websocket_handle({text, <<0, 0, 0, 1>>}, State) ->
	{reply, {text, <<"xxxx">>}, State};
websocket_handle(_Data, State) ->
	{ok, State}.

websocket_info(start, State) ->
	{reply, {text, <<0, 0, 0, 1>>}, State};
websocket_info(_Info, State) ->
	{ok, State}.
