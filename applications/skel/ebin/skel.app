{application, skel,
 [
  {description, "Skel - A skeleton application useful for quickly creating services"},
  {vsn, "0.0.1"},
  {modules, [skel_app, skel, skel_handlers, skel_listener, skel_sup]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { skel_app, []}},
  {env, []}
 ]}.
