{application, webhooks,
 [
  {description, "Skel - A webhookseton application useful for quickly creating services"},
  {vsn, "0.0.1"},
  {modules, [webhooks_app, webhooks, webhooks_listener, webhooks_maintenance, webhooks_sup]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { webhooks_app, []}},
  {env, []}
 ]}.
