{application, kazoo_oauth,
 [
  {description, "OAuth Utilities"},
  {vsn, "1.0.0"},
  {registered, []},
  {modules, [kazoo_oauth_client, kazoo_oauth_service, kazoo_oauth_util]},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { kazoo_oauth_app, []}},
  {env, []}
 ]}.
