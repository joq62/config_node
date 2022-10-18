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
-module(application_spec).   
 

-export([
	 read_spec/0,
	 read_spec/1,
	 all_names/0,
	 all_names/1,
	 info/1,
	 info/2,
	 item/2,
	 item/3
	 
	]).

		 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(SpecFile,"spec.application").


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% -------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
read_spec()->
    read_spec(?SpecFile).
read_spec(SpecFile)->
    Result=case file:consult(SpecFile) of
	       {error,Reason}->
		   {error,Reason};
	       {ok,SpecList}->
		   {ok,SpecList}
	   end,
    Result.
		   

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_names()->
    all_names(?SpecFile).

all_names(SpecFile)->
    {ok,SpecList}=read_spec(SpecFile),
    [proplists:get_value(name,Spec)||Spec<-SpecList].

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
info(ApplicationName)->
    info(ApplicationName,?SpecFile).
info(ApplicationName,SpecFile)->
    {ok,SpecList}=read_spec(SpecFile), 
    R=[Spec||Spec<-SpecList,
		       ApplicationName=:=proplists:get_value(name,Spec)],
    Result=case R of
	       []->
		   {error,[application_name_eexists,ApplicationName]};
	       [Spec]->
		   Spec
	   end,
    Result.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
item(Key,ApplicationName)->
    item(Key,ApplicationName,?SpecFile).
item(Key,ApplicationName,SpecFile)->
    Result=case info(ApplicationName,SpecFile) of
	       {error,Reason}->
		   {error,Reason};
	       Spec->
		   case proplists:get_value(Key,Spec) of
		       undefined->
			   {error,[undefined_key,Key]};
		       Value->
			   Value
		   end
	   end,
    Result.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
