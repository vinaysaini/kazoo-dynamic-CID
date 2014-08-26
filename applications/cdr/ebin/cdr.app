{application, cdr,
 [
  {description, "Listen and record CDR events into CouchDB"}
  ,{vsn, "0.4.1"}
  ,{modules, [cdr_app, cdr_channel_destroy, cdr_deps, cdr, cdr_listener, cdr_maintenance, cdr_sup, cdr_util, cdr_v3_migrate_lib, cdr_v3_migrate_server, cdr_v3_migrate_worker, csv_util]}
  ,{registered, []}
  ,{applications, [
                   kernel,
                   stdlib
                  ]}
  ,{mod, { cdr_app, []}}
  ,{env, []}
 ]}.
