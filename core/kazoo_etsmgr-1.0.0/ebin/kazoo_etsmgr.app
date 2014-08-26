{application, kazoo_etsmgr
 ,[
   {description, "Kazoo ETS Manager - Protect the ETS"}
   ,{vsn, "1.0.0"}
   ,{modules, [kazoo_etsmgr_srv]}
   ,{registered, []}
   ,{applications
     ,[
       kernel
       ,stdlib
       ,crypto
       ,sasl
      ]}
   ,{mod, { kazoo_etsmgr_app
            ,[

             ]
          }
    }
   ,{env, []}
 ]}.
