{application, kazoo_token_buckets,
 [
  {description, "Token Buckets - Throttling mechanism"},
  {vsn, "1.0.0"},
  {modules, [kazoo_token_buckets, kazoo_token_buckets_app, kazoo_token_buckets_sup, kz_buckets, kz_buckets_sup, kz_token_bucket]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]},
  {mod, { kazoo_token_buckets_app, []}},
  {env, []}
 ]}.
