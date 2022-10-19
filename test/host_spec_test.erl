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
-module(host_spec_test).      
 
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
  
    {ok,Spec}=host_spec:read_spec(),
    [
     [{hostname,"c100"},{local_ip,"192.168.1.100"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},{uid,"joq62"},{passwd,"festum01"},
      {application_config,[{conbee,[{conbee_addr,"172.17.0.2"},{conbee_port,80},{conbee_key,"D83FA13F74"}]}]}],
     [{hostname,"c200"},{local_ip,"192.168.1.200"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},{uid,"ubuntu"},{passwd,"festum01"},
      {application_config,[]}],
     [{hostname,"c201"},{local_ip,"192.168.1.201"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},{uid,"ubuntu"},{passwd,"festum01"},
      {application_config,[{conbee,[{conbee_addr,"172.17.0.2"},{conbee_port,80},{conbee_key,"D83FA13F74"}]}]}],
     [{hostname,"c202"},{local_ip,"192.168.1.202"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},{uid,"ubuntu"},{passwd,"festum01"},
      {application_config,[{conbee,[{conbee_addr,"172.17.0.2"},{conbee_port,80},{conbee_key,"D83FA13F74"}]}]}],
     [{hostname,"c300"},{local_ip,"192.168.1.230"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},{uid,"ubuntu"},{passwd,"festum01"},{application_config,[]}]
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

    AllNames=host_spec:all_names(),
   ["c100","c200","c201","c202","c300"]=lists:sort(AllNames),
  
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
info()->
     io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    
    Info=host_spec:info("c100"),
    [{hostname,"c100"},{local_ip,"192.168.1.100"},{public_ip,"joqhome.asuscomm.com"},{ssh_port,22},
     {uid,"joq62"},{passwd,"festum01"},
     {application_config,[{conbee,[{conbee_addr,"172.17.0.2"},{conbee_port,80},{conbee_key,"D83FA13F74"}]}]}
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

    "192.168.1.100"=config_node:host_local_ip("c100"),
    "joqhome.asuscomm.com"=host_spec:item(public_ip,"c100"),
    22=config_node:host_ssh_port("c100"),
    "joq62"=config_node:host_uid("c100"),
    "festum01"=config_node:host_passwd("c100"),
    [{conbee,
      [{conbee_addr,"172.17.0.2"},
       {conbee_port,80},
       {conbee_key,"D83FA13F74"}]}
    ]=config_node:host_application_config("c100"),
  
   
    {error,[undefined_key,glurk]}=host_spec:item(glurk,"c100"),
    {error,[host_name_eexists,"glurk"]}=host_spec:item(uid,"glurk"),
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    

    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
-define(SourceFile,"./test/specs/spec.host").
-define(File,"spec.host").
	 	 

setup()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    file:delete(?File),
    {ok,Bin}=file:read_file(?SourceFile),
    ok=file:write_file(?File,Bin),
       
     io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
