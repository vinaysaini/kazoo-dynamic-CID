{application, callflow,
 [
  {description, "Callflow - traversing through the tree..."}
  ,{vsn, "3.0.0"}
  ,{modules, [callflow_app, callflow, callflow_maintenance, callflow_sup, cf_attributes, cf_endpoint, cf_event_handler_sup, cf_exe, cf_exe_sup, cf_listener, cf_route_req, cf_route_resume, cf_route_win, cf_shared_listener, cf_util, wapi_callflow,cf_acdc_agent, cf_acdc_member, cf_acdc_queue, cf_automatic_cid, cf_callflow, cf_call_forward, cf_check_cid, cf_conference, cf_device, cf_directory, cf_disa, cf_do_not_disturb, cf_dynamic_cid, cf_group, cf_group_pickup, cf_group_pickup_feature, cf_hotdesk, cf_intercom, cf_manual_presence, cf_menu, cf_offnet, cf_page_group, cf_park, cf_pivot, cf_play, cf_prepend_cid, cf_privacy, cf_receive_fax, cf_record_call, cf_record_call_listener, cf_resources, cf_response, cf_ring_group, cf_set, cf_skel, cf_sleep, cf_temporal_route, cf_user, cf_voicemail]}
  ,{registered, []}
  ,{applications, [
		   kernel
		   ,stdlib
		  ]}
  ,{mod, { callflow_app, []} }
  ,{env, []}
 ]}.
