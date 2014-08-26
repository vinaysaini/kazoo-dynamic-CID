{application, conference,
 [
  {description, "Conferencing Service Provider"},
  {vsn, "1.0.0"},
  {modules, [conf_authn_req, conf_config_req, conf_discovery_req, conference_app, conference, conference_listener, conference_maintenance, conference_shared_listener, conference_sup, conf_participant, conf_participant_sup, conf_route_req, conf_route_win, wapi_conf_participant]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { conference_app, []}},
  {env, []}
 ]}.
