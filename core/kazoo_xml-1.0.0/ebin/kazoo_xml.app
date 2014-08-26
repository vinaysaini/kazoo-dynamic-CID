{application, kazoo_xml,
 [
  {description, "Helpers for manipulating XML records"},
  {vsn, "1.0.0"},
  {registered, []},
  {modules, [kz_xml]},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { kazoo_xml_app, []}},
  {env, []}
 ]}.
