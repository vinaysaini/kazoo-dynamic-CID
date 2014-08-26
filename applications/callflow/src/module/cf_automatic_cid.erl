%%%-------------------------------------------------------------------
%%% @copyright (C) 2011-2014, 2600Hz INC
%%% @contributors
%%%   Vinay Saini 
%%%-------------------------------------------------------------------
-module(cf_automatic_cid).

-include("../callflow.hrl").

-export([handle/2]).


%% @public
%% @doc
%% Entry point for this module, attempts to call an endpoint as defined
%% in the Data payload.  Returns continue if fails to connect or
%% stop when successfull.
%%
%% NOTE: It is written in a strange way This was my first erlang code. ;)
%% @end
%%--------------------------------------------------------------------
-spec handle(wh_json:object(), whapps_call:call()) -> 'ok'.
handle(Data, Call) ->
 	_ = case maybe_allowed_to_intercept(wh_json:get_ne_value(<<"group_id">>, Data), Call) of
            'true' -> lager:info("Caller belongs to the group Automatic CID Rules will apply"),
	              Patterns = wh_json:get_ne_value(<<"patterns">>, Data),
        	      CalleeID = whapps_call:to(Call),
		    lager:info("ppppppppppffffffff----fff****** ~p",[CalleeID]),
        	      [CID,Realm] = binary:split(CalleeID,<<"@">>),
        	      CID2 = binary:bin_to_list(CID),
        	      Realm2 = binary:bin_to_list(Realm),
        	      GetNewCalleeID = get_match_pattern(Patterns,CID2) ++ "@" ++ Realm2,
        	      lager:info("=================++++++NEW CALLEEID-------- ~p",[GetNewCalleeID]),
        	      {CIDtoSet} = case wh_json:get_ne_value(<<"caller_id_override_select">>, Data) of
                    		true -> 
					case check_pattern(Patterns,CID2) of
						true -> {wh_json:get_ne_value(<<"caller_id_override">>, Data)};
						false -> {whapps_call:caller_id_number(Call)}
					end;
                    		_ -> {whapps_call:caller_id_number(Call)}
               	       end,
		     case check_pattern(Patterns,CID2) of
 	        	   true ->  lager:info("Pattern Matched--setting the caller id number to ~s", [CIDtoSet]),
		                     {'ok', C1} = cf_exe:get_call(Call),
                		     UpdateCalleeID2 = binary:list_to_bin(GetNewCalleeID),
                   		     Updates = [{fun whapps_call:kvs_store/3, 'dynamic_cid', CIDtoSet}
                        			,{fun whapps_call:set_request/2, UpdateCalleeID2}
                        			,{fun whapps_call:set_caller_id_number/2, CIDtoSet}
                     				],
                     	       	     lager:info("Updates++++++++ ~p", [Updates]),
                     		     lager:info("Call++++++++ ~p", [Call]),
				     cf_exe:set_call(whapps_call:exec(Updates, C1)),
        		     	     cf_exe:continue(Call);
			   false ->  lager:info("Pattern Not Matched NO Rules Will Apply"),
				     cf_exe:continue(Call)
		     end;
            'false' -> lager:info("Caller does not belongs to the group Automatic CID Rules will not apply"),
		       cf_exe:continue(Call)	
        end.

-spec get_match_pattern(list(),list()) -> list().
   get_match_pattern([Patterns|Rest],C) ->
	lager:info("pattern++++++++ ~p", [Patterns]),
	Regex = case wh_json:get_ne_value(<<"regex">>, Patterns) of
                        undefined -> "";
                        BinaryRegex when is_binary(BinaryRegex) -> binary:bin_to_list(BinaryRegex)
                  end,
        Prepend = case wh_json:get_ne_value(<<"prepend">>, Patterns) of
                        undefined -> "";
                        BinaryPrepend when is_binary(BinaryPrepend) -> binary:bin_to_list(BinaryPrepend)
                  end,
	Prefix = case wh_json:get_ne_value(<<"prefix">>, Patterns) of
        		undefined -> "";
        		BinaryPrefix when is_binary(BinaryPrefix) -> binary:bin_to_list(BinaryPrefix)
    		  end,
	 
	 Num = case re:run(C, Regex) of
		{match, Cd} -> C;
		nomatch -> 
			LengthPrefix = string:len(Prefix),
                        string:substr(C,LengthPrefix+1)
	        end,

	
        lager:info("------- --Regex-- ~p--Callee- ~p -- Prepend --~p --Prefix --~p",[Regex,C,Prepend,Prefix]),
	C1 = case re:run(Num, Regex) of
 		 {match, Captured} ->  
				    %%LengthPrefix = string:len(Prefix),
				    %%Num = string:substr(C,LengthPrefix+1),
                                    Number = Prepend ++ Num,
				    lager:info("--------NUMBER---- ~p",[Number]),
				    Number;
  		 nomatch ->  C
	end,
	get_match_pattern(Rest,C1);
  get_match_pattern([],C) ->
         C.	

-spec check_pattern(list(),list()) -> list().
   check_pattern([Patterns|Rest],C) ->
        %%Regex = binary:bin_to_list(wh_json:get_ne_value(<<"regex">>, Patterns)),
	 Regex = case wh_json:get_ne_value(<<"regex">>, Patterns) of
                        undefined -> "";
                        BinaryRegex when is_binary(BinaryRegex) -> binary:bin_to_list(BinaryRegex)
                  end,
	 Prefix = case wh_json:get_ne_value(<<"prefix">>, Patterns) of
                        undefined -> "";
                        BinaryPrefix when is_binary(BinaryPrefix) -> binary:bin_to_list(BinaryPrefix)
                  end,
	 Num = case re:run(C, Regex) of
                {match, Cd} -> C;
                nomatch ->
                        LengthPrefix = string:len(Prefix),
                        string:substr(C,LengthPrefix+1)
                end,
        C1 = case re:run(Num, Regex) of
                 {match, Captured} -> true; 
                 nomatch ->  false
        end,
	case C1 of
		true -> C1;
		false -> check_pattern(Rest,C)
        end;
  check_pattern([],C) ->
         false. 


-spec maybe_allowed_to_intercept(wh_json:object(), whapps_call:call()) -> boolean().
maybe_allowed_to_intercept([GroupsID|Rest], Call) ->
		    lager:info("---------- ~p" ,[GroupsID]),
                    case GroupsID of
                        'undefined' -> 'true';
                        GroupId -> case maybe_belongs_to_group(GroupId, Call) of
				'true' -> true;
				    _  -> maybe_allowed_to_intercept(Rest,Call)
				end
                    end;
maybe_allowed_to_intercept([],Call) -> false.


-spec maybe_belongs_to_group(ne_binary(), whapps_call:call()) -> boolean().
maybe_belongs_to_group(GroupId, Call) ->
    is_in_list(whapps_call:authorizing_id(Call), find_group_endpoints(GroupId, Call)).

-spec is_in_list(api_binary(), ne_binaries()) -> boolean().
%% NOTE: this could be replaced by list:member
is_in_list(_, []) -> 'false';
is_in_list(Suspect, [H|T]) ->
    case Suspect == H of
        'true' -> 'true';
        _ -> is_in_list(Suspect, T)
    end.
 
-spec find_group_endpoints(ne_binary(), whapps_call:call()) -> ne_binaries().
find_group_endpoints(GroupId, Call) ->
    GroupsJObj = cf_attributes:groups(Call),
    case [wh_json:get_value(<<"value">>, JObj)
          || JObj <- GroupsJObj,
             wh_json:get_value(<<"id">>, JObj) =:= GroupId
         ]
    of
        [] -> [];
        [GroupEndpoints] ->
            Ids = wh_json:get_keys(GroupEndpoints),
            find_endpoints(Ids, GroupEndpoints, Call)
    end.
-spec find_endpoints(ne_binaries(), wh_json:object(), whapps_call:call()) ->
                            ne_binaries().
find_endpoints(Ids, GroupEndpoints, Call) ->
    {DeviceIds, UserIds} =
        lists:partition(fun(Id) ->
                                wh_json:get_value([Id, <<"type">>], GroupEndpoints) =:= <<"device">>
                        end, Ids),
    find_user_endpoints(UserIds, lists:sort(DeviceIds), Call).

-spec find_user_endpoints(ne_binaries(), ne_binaries(), whapps_call:call()) ->
                                 ne_binaries().
find_user_endpoints([], DeviceIds, _) -> DeviceIds;
find_user_endpoints(UserIds, DeviceIds, Call) ->
    UserDeviceIds = cf_attributes:owned_by(UserIds, <<"device">>, Call),
    lists:merge(lists:sort(UserDeviceIds), DeviceIds).


