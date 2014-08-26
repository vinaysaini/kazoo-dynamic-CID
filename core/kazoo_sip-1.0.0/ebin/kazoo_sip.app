{application, kazoo_sip,
 [
  {description, "SIP Utilities"},
  {vsn, "1.0.0"},
  {registered, []},
  {modules, [kzsip_diversion]},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { kazoo_sip_app, []}},
  {env, []}
 ]}.
