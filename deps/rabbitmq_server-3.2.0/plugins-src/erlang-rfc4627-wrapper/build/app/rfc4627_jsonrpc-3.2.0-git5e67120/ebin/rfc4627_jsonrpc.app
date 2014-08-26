{application, rfc4627_jsonrpc,
 [{description, "JSON RPC Service"},
  {vsn,"3.2.0-git5e67120"},
  {modules, [
    rfc4627,
    rfc4627_jsonrpc,
	rfc4627_jsonrpc_app,
	rfc4627_jsonrpc_sup,
    rfc4627_jsonrpc_http,
    rfc4627_jsonrpc_inets,
    rfc4627_jsonrpc_mochiweb,
    rfc4627_jsonrpc_registry
  ]},
  {registered, []},
  {mod, {rfc4627_jsonrpc_app, []}},
  {env, []},
  {applications, [kernel, stdlib]}]}.
