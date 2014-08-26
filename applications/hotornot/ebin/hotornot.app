{application, hotornot,
 [
  {description, "HotOrNot - Rate calls based on prefix"}
  ,{vsn, "0.0.1"}
  ,{modules, [hon_rater, hon_util, hotornot_app, hotornot, hotornot_listener, hotornot_maintenance, hotornot_sup]}
  ,{registered, []}
  ,{applications, [
		   kernel
		   ,stdlib
		  ]}
  ,{mod, { hotornot_app, []} }
  ,{env, []}
 ]}.
