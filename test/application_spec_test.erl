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
-module(application_spec_test).      
 
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
  
    {ok,Spec}=application_spec:read_spec(),
   [
    [{name,"common"},{vsn,["0.1.0"]},{app,common},{gitpath,"https://github.com/joq62/common.git"}],
    [{name,"nodelog"},{vsn,["0.1.0"]},{app,nodelog},{gitpath,"https://github.com/joq62/node.git"}],
    [{name,"sd"},{vsn,["0.1.0"]},{app,sd},{gitpath,"https://github.com/joq62/sd.git"}],
    [{name,"test_add"},{vsn,["0.1.0"]},{app,test_add},{gitpath,"https://github.com/joq62/test_add.git"}],
    [{name,"test_divi"},{vsn,["0.1.0"]},{app,test_divi},{gitpath,"https://github.com/joq62/test_divi.git"}],
    [{name,"test_math"},{vsn,["0.1.0"]},{app,test_math},{gitpath,"https://github.com/joq62/test_math.git"}],
    [{name,"test_sub"},{vsn,["0.1.0"]},{app,test_sub},{gitpath,"https://github.com/joq62/test_sub.git"}],
    [{name,"web_conbee_c201"},{vsn,["0.1.0"]},{app,web_conbee_c201},{gitpath,"https://github.com/joq62/web_conbee_c201.git"}]
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

    AllNames=application_spec:all_names(),
   ["common","nodelog","sd",
    "test_add","test_divi","test_math","test_sub",
    "web_conbee_c201"
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
    
    Info=application_spec:info("sd"),
    [
     {name,"sd"},
     {vsn,["0.1.0"]},
     {app,sd},
     {gitpath,"https://github.com/joq62/sd.git"}
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

    
    ["0.1.0"]=config_node:application_vsn("sd"),
    sd=config_node:application_app("sd"),
    "https://github.com/joq62/sd.git"=config_node:application_gitpath("sd"),

    {error,[application_name_eexists,"glurk"]}=config_node:application_gitpath("glurk"),
    
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),    

    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
-define(SourceFile,"./test/specs/spec.application").
-define(File,"spec.application").
	 	 

setup()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    file:delete(?File),
    {ok,Bin}=file:read_file(?SourceFile),
    ok=file:write_file(?File,Bin),
       
    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
