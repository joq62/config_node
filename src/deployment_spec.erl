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
-module(deployment_spec).   
 

-export([
	 read_spec/0,
	 read_spec/1,
	 all_names/0,
	 info/1,
	 item/2

	]).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(SpecFile,"spec.deployment").


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
		   

% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_names()->
    {ok,SpecList}=read_spec(),
    [proplists:get_value(deploy_name,Spec)||Spec<-SpecList].

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
info(DeploymentName)->
    {ok,SpecList}=read_spec(),    
    R=[Spec||Spec<-SpecList,
	     DeploymentName=:=proplists:get_value(deploy_name,Spec)],
    Result=case R of
	       []->
		   {error,[deployment_name_eexists,DeploymentName]};
	       [Spec]->
		   Spec
	   end,
    Result.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
item(Key,DeploymentName)->
    Result=case info(DeploymentName) of
	       {error,Reason}->
		   {error,Reason};
	       Spec->
		   case Key of
		       hostnames->
			   {_HostConstraints,HostNames}=proplists:get_value(host,Spec),
			   HostNames;
		       host_constraints->
			   {HostConstraints,_HostNames}=proplists:get_value(host,Spec),
			   HostConstraints;
		       Key->
			   case proplists:get_value(Key,Spec) of
			       undefined->
				   {error,[undefined_key,Key]};
			       Value->
				   Value
			   end
		   end
	   end,
    Result.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
