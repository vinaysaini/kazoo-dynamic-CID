{application, omnipresence,
 [
  {description, "Omnipresence - Who's doing what when"},
  {vsn, "1.0.0"},
  {modules, [omnipresence_app, omnipresence, omnipresence_listener, omnipresence_maintenance, omnipresence_shared_listener, omnipresence_sup, omnip_subscriptions, omnip_util, wapi_omnipresence, wapi_presence]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { omnipresence_app, []}},
  {env, []}
 ]}.
