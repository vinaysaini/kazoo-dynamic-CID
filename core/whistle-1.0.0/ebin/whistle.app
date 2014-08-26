{application, whistle
 ,[
   {description, "Whistle Helpers"}
   ,{vsn, "1.0.0"}
   ,{modules, [gen_listener, kazoo_transform, lager_kazoo_formatter, listener_federator, listener_utils, perf, props, wh_api, wh_cache, wh_call_response, wh_json, wh_json_validator, wh_json_validator_tests, wh_mime_types, wh_network_utils, wh_nodes, wh_notify, wh_util, whistle_maintenance,wapi_asr, wapi_authn, wapi_authz, wapi_call, wapi_conf, wapi_conference, wapi_dialplan, wapi_fs, wapi_hangups, wapi_media, wapi_money, wapi_nodes, wapi_notifications, wapi_offnet_resource, wapi_rate, wapi_registration, wapi_resource, wapi_route, wapi_self, wapi_switch, wapi_sysconf]}
   ,{registered, []}
   ,{applications
     ,[
       kernel
       ,stdlib
       ,crypto
       ,sasl
      ]}
   ,{mod, { whistle_app
            ,[

             ]
          }
    }
   ,{env, []}
 ]}.
