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
-module(all).      
 
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
   
    ok=setup(),
    
    ok=test_1(),
    rpc:call(node(),config_node,deployment_all_filenames,[]),
    ok=test_1(),
    
  
     
           
    io:format("Test OK !!! ~p~n",[?MODULE]),
    init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_1()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    ok=deployment_spec_test:start(),
    ok=host_spec_test:start(),
    ok=cluster_spec_test:start(),
    ok=application_spec_test:start(),
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),
    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
-define(DepFile,"spec.deployment").
-define(ClusterFile,"spec.cluster").
-define(HostFile,"spec.host").
-define(ApplicationFile,"spec.application").

setup()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    ConfigNodeEnv=[{config_node,[{deployment_spec,?DepFile},
				 {cluster_spec,?ClusterFile},
				 {host_spec,?HostFile},
				 {application_spec,?ApplicationFile},
				 {spec_dir,"."}]}],
    ok=application:set_env(ConfigNodeEnv),
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
