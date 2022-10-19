%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(deployment_spec_test).      
 
-export([start/0]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
   
    ok=setup(),
    
    ok=read_spec(),
    ok=all_names(),
    ok=info(),
    ok=item(),
    
           
    io:format("Test OK !!! ~p~n",[?MODULE]),
%    init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
read_spec()->
   io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
  
    {ok,Spec}=deployment_spec:read_spec(),
    [
     [{deploy_name,"any_not_same_hosts_not_same_pods"},{cluster_name,"test_cluster"},{num_instances,2},{host,{[any_host,not_same_host],["c100","c200","c201"]}},
      {pod,not_same_pod},{services,[{"test_add","1.0.0"},{"test_divi","1.0.0"},{"test_sub","1.0.0"}]}],
     [{deploy_name,"any_same_host_not_same_pod"},{cluster_name,"test_cluster"},{num_instances,2},{host,{[any_host,same_host],["c100","c200","c201"]}},
      {pod,not_same_pod},{services,[{"test_add","1.0.0"},{"test_divi","1.0.0"},{"test_sub","1.0.0"}]}],
     [{deploy_name,"any_same_host_same_pod"},{cluster_name,"test_cluster"},{num_instances,2},{host,{[any_host,same_host],["c100","c200","c201"]}},
      {pod,same_pod},{services,[{"test_add","1.0.0"},{"test_divi","1.0.0"},{"test_sub","1.0.0"}]}],
     [{deploy_name,"this_host_not_same_pod"},{cluster_name,"test_cluster"},{num_instances,2},{host,{[this_host],["c100"]}},
      {pod,not_same_pod},{services,[{"test_add","1.0.0"},{"test_divi","1.0.0"},{"test_sub","1.0.0"}]}]
    ]=lists:sort(Spec),
      
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),
    ok.




%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_names()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    AllNames=deployment_spec:all_names(),
    ["any_not_same_hosts_not_same_pods",
     "any_same_host_not_same_pod",
     "any_same_host_same_pod",
     "this_host_not_same_pod"
    ]=lists:sort(AllNames),
  
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
info()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    
    Info=deployment_spec:info("any_not_same_hosts_not_same_pods"),
    [{deploy_name,"any_not_same_hosts_not_same_pods"},
     {cluster_name,"test_cluster"},{num_instances,2},
     {host,{[any_host,not_same_host],["c100","c200","c201"]}},
     {pod,not_same_pod},
     {services,[{"test_add","1.0.0"},{"test_divi","1.0.0"},{"test_sub","1.0.0"}]}
    ]=Info, 
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
item()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    "test_cluster"=deployment_spec:item(cluster_name,"any_not_same_hosts_not_same_pods"),
    2=deployment_spec:item(num_instances,"any_not_same_hosts_not_same_pods"),
    ["c100","c200","c201"]=deployment_spec:item(hostnames,"any_not_same_hosts_not_same_pods"),
    [any_host,not_same_host]=deployment_spec:item(host_constraints,"any_not_same_hosts_not_same_pods"),
    not_same_pod=deployment_spec:item(pod,"any_not_same_hosts_not_same_pods"),
    [{"test_add","1.0.0"},
     {"test_divi","1.0.0"},
     {"test_sub","1.0.0"}]=deployment_spec:item(services,"any_not_same_hosts_not_same_pods"),

    {error,[undefined_key,glurk]}=deployment_spec:item(glurk,"any_not_same_hosts_not_same_pods"),
    {error,[deployment_name_eexists,"glurk"]}=deployment_spec:item(services,"glurk"),
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    

    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
cluster_stop_test()->
     io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
-define(SourceDepFile,"./test/specs/spec.deployment").
-define(DepFile,"spec.deployment").
	 	 

setup()->
     io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    file:delete(?DepFile),
    {ok,Bin}=file:read_file(?SourceDepFile),
    ok=file:write_file(?DepFile,Bin),
    
 
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
