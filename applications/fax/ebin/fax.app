{application, fax,
 [
  {description, "Fax - Why is everyone faxinated with fax?"},
  {vsn, "1.0.0"},
  {registered, []},
  {modules, [fax_app, fax, fax_file_proxy, fax_jobs, fax_listener, fax_request, fax_requests_sup, fax_smtp, fax_sup, fax_util, fax_worker, wapi_fax]},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { fax_app, []}},
  {env, []}
 ]}.
