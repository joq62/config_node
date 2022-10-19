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
-module(cluster_spec_test).      
 
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
  %  init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
read_spec()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
  
    {ok,Spec}=cluster_spec:read_spec(),
    [
     [{name,"test_cluster"},{cookie,"test_cluster"},{connect_name,"test_cluster_0"},
      {pod_names,["test_cluster_1",
		 "test_cluster_2",
		 "test_cluster_3",
		 "test_cluster_4",
		 "test_cluster_5",
		 "test_cluster_6"]},
      {pod_dir_extension,".dir"},
      {num_pods,6},
      {pod_services,["pod_node"]},
      {hostnames,["c100","c200","c201"]}
     ]
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

    AllNames=cluster_spec:all_names(),
    ["test_cluster"]=lists:sort(AllNames),
  
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
info()->
     io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
     
    Info=cluster_spec:info("test_cluster"),
    [{name,"test_cluster"},
     {cookie,"test_cluster"},
     {connect_name,"test_cluster_0"},
     {pod_names,["test_cluster_1",
		"test_cluster_2",
		"test_cluster_3",
		"test_cluster_4",
		"test_cluster_5",
		"test_cluster_6"]},
     {pod_dir_extension,".dir"},
     {num_pods,6},
     {pod_services,["pod_node"]},
     {hostnames,["c100","c200","c201"]}
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

  
    "test_cluster"=config_node:cluster_name("test_cluster"),
    "test_cluster"=config_node:cluster_cookie("test_cluster"),
    "test_cluster_0"=config_node:cluster_connect_name("test_cluster"),
    ["test_cluster_1",
     "test_cluster_2",
     "test_cluster_3",
     "test_cluster_4",
     "test_cluster_5",
     "test_cluster_6"]=config_node:cluster_pod_names("test_cluster"),
    ".dir"=config_node:cluster_pod_dir_extension("test_cluster"),
    6=config_node:cluster_num_pods("test_cluster"),
    ["pod_node"]=config_node:cluster_pod_services("test_cluster"),
    ["c100","c200","c201"]=config_node:cluster_hostnames("test_cluster"),
  

  {error,[cluster_name_eexists,"glurk"]}=config_node:cluster_num_pods("glurk"),
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    

    ok.



%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
-define(SourceFile,"./test/specs/spec.cluster").
-define(File,"spec.cluster").
	 	 

setup()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    file:delete(?File),
    {ok,Bin}=file:read_file(?SourceFile),
    ok=file:write_file(?File,Bin),
       
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
