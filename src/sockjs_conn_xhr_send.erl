-module(sockjs_conn_xhr_send).

-include("sockjs.hrl").

-export([handle_req/5]).

handle_req(Req, _Server, SessionId, xhr_send, Fun) ->
    Decoded = mochijson2:decode(Req:get(body)),
    sockjs_util:with_session(
      fun (#session{receiver = Conn}) ->
              [Fun(Conn, {recv, Msg}) || Msg <- Decoded]
      end, SessionId),
    Req:respond(204).
