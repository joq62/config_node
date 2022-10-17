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
-module(config_node).     
-behaviour(gen_server). 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
-define(SERVER,?MODULE).
%% --------------------------------------------------------------------
%% Key Data structures
%% 
%% --------------------------------------------------------------------
-record(state, {}).



%% --------------------------------------------------------------------
%% Definitions 
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------

-export([ %application_info_specs

	  application_all_files/0,
	  application_all_filenames/0,
	  application_all_info/0,
	  application_vsn/1,
	  application_gitpath/1,
	  application_start_cmd/1,
	  application_member/1,
	  application_member/2,
	 %% host_info_specs
	  host_all_files/0,
	  host_all_filenames/0,
	  host_all_info/0,
	  host_all_hostnames/0,

	  host_local_ip/1,
	  host_public_ip/1,
	  host_ssh_port/1,
	  host_uid/1,
	  host_passwd/1,
	  host_application_config/1,
	  
	  %% deployment_specs
	  deployment_all_files/0,
	  deployment_all_filenames/0,
	  deployment_all_info/0,
	  deployment_cluster_name/1,
	  deployment_num_instances/1,
	  deployment_hostnames/1,
	  deployment_host_constraints/1,
	  deployment_pod_constraints/1,
	  deployment_services/1
	]).

-export([
	 appl_start/1,
	 ping/0,
	 start/0,
	 stop/0
	]).

%% gen_server callbacks
-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% ====================================================================
%% External functions
%% ====================================================================
appl_start([])->
    application:start(?MODULE).
%%-----------------------------------------------------------------------

%%----------------------------------------------------------------------
%% Gen server functions
start()-> gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).
stop()-> gen_server:call(?SERVER, {stop},infinity).


%% cluster spec

cluster_cookie(AppId)->
    gen_server:call(?SERVER, {cluster_cookie,AppId},infinity).
cluster_dir(AppId)->
    gen_server:call(?SERVER, {cluster_dir,AppId},infinity).
cluster_hostnames(AppId)->
    gen_server:call(?SERVER, {cluster_hostnames,AppId},infinity).
cluster_num_pods(AppId)->
    gen_server:call(?SERVER, {cluster_num_pods,AppId},infinity).


%% application spec

application_all_filenames()->
    gen_server:call(?SERVER, {application_all_filenames},infinity).
application_all_files()->
    gen_server:call(?SERVER, {application_all_files},infinity).
application_all_info()->
    gen_server:call(?SERVER, {application_all_info},infinity).
application_vsn(AppId)->
    gen_server:call(?SERVER, {application_vsn,AppId},infinity).
application_gitpath(AppId)->
    gen_server:call(?SERVER, {application_gitpath,AppId},infinity).
application_start_cmd(AppId)->
    gen_server:call(?SERVER, {application_start_cmd,AppId},infinity).
application_member(AppId)->
    gen_server:call(?SERVER, {application_member,AppId},infinity).
application_member(AppId,Vsn)->
    gen_server:call(?SERVER, {application_member,AppId,Vsn},infinity).

%% host spec

host_all_filenames()->
    gen_server:call(?SERVER, {host_all_filenames},infinity).
host_all_files()->
    gen_server:call(?SERVER, {host_all_files},infinity).
host_all_info()->
    gen_server:call(?SERVER, {host_all_info},infinity).
host_all_hostnames()->
    gen_server:call(?SERVER, {host_all_hostnames},infinity).
host_local_ip(HostName)->
    gen_server:call(?SERVER, {host_local_ip,HostName},infinity).
host_public_ip(HostName)->
    gen_server:call(?SERVER, {host_public_ip,HostName},infinity).
host_ssh_port(HostName)->
    gen_server:call(?SERVER, {host_ssh_port,HostName},infinity).
host_uid(HostName)->
    gen_server:call(?SERVER, {host_uid,HostName},infinity).
host_passwd(HostName)->
    gen_server:call(?SERVER, {host_passwd,HostName},infinity).
host_application_config(HostName)->
     gen_server:call(?SERVER, {host_application_config,HostName},infinity).

%% deployments spec

deployment_all_filenames()->
    gen_server:call(?SERVER, {deployment_all_filenames},infinity).
deployment_all_files()->
    gen_server:call(?SERVER, {deployment_all_files},infinity).
deployment_all_info()->
    gen_server:call(?SERVER, {deployment_all_info},infinity).
deployment_cluster_name(DeploymentName)->
    gen_server:call(?SERVER, {cluster_name,DeploymentName},infinity).
deployment_num_instances(DeploymentName)->
    gen_server:call(?SERVER, {num_instances,DeploymentName},infinity).
deployment_hostnames(DeploymentName)->
    gen_server:call(?SERVER, {deployment_hostnames,DeploymentName},infinity).
deployment_host_constraints(DeploymentName)->
    gen_server:call(?SERVER, {host_constraints,DeploymentName},infinity).
deployment_pod_constraints(DeploymentName)->
    gen_server:call(?SERVER, {pod_constraints,DeploymentName},infinity).
deployment_services(DeploymentName)->
    gen_server:call(?SERVER, {services,DeploymentName},infinity).


%%---------------------------------------------------------------
-spec ping()-> {atom(),node(),module()}|{atom(),term()}.
%% 
%% @doc:check if service is running
%% @param: non
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
ping()-> 
    gen_server:call(?SERVER, {ping},infinity).


%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: 
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%
%% --------------------------------------------------------------------
init([]) ->
    
    
    {ok, #state{}}.
    
%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (aterminate/2 is called)
%% --------------------------------------------------------------------


%% deployment_specs
handle_call({deployment_spec_all_filenames},_From,State) ->
    Reply=deployment_spec_lib:all_filenames(),
    {reply, Reply, State};
handle_call({deployment_spec_all_files},_From,State) ->
    Reply=deployment_spec_lib:all_files(),
    {reply, Reply, State};
handle_call({deployment_spec_all_info},_From,State) ->
    Reply=deployment_spec_lib:all_info(),
    {reply, Reply, State};

handle_call({deployment_cluster_name,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(cluster_name,DeploymentName),
    {reply, Reply, State};
handle_call({deployment_spec_workers,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(cluster_name,DeploymentName),
    {reply, Reply, State};
handle_call({deployment_num_instances,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(num_instances,DeploymentName),
    {reply, Reply, State};
handle_call({deployment_hostnames,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(hostnames,DeploymentName),
    {reply, Reply, State};

handle_call({deployment_host_constraints,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(host_constraints,DeploymentName),
    {reply, Reply, State};
handle_call({deployment_pod_constraints,DeploymentName},_From,State) ->
    Reply=deployment_spec_lib:item(pod_constraints,DeploymentName),
    {reply, Reply, State};

%%----------------- application_info_specs
handle_call({application_all_filenames},_From,State) ->
    Reply=appl_lib:all_filenames(),
    {reply, Reply, State};

handle_call({application_all_files},_From,State) ->
    Reply=appl_lib:all_files(),
    {reply, Reply, State};

handle_call({application_all_info},_From,State) ->
    Reply=appl_lib:all_info(),
    {reply, Reply, State};


handle_call({application_vsn,AppId},_From,State) ->
    Reply=appl_lib:item(vsn,AppId),
    {reply, Reply, State};

handle_call({application_gitpath,AppId},_From,State) ->
    Reply=appl_lib:item(gitpath,AppId),
    {reply, Reply, State};

handle_call({application_start_cmd,AppId},_From,State) ->
    Reply=appl_lib:item(cmd,AppId),
    {reply, Reply, State};

handle_call({application_member,AppId},_From,State) ->
    Reply=appl_lib:member(AppId),
    {reply, Reply, State};

handle_call({application_member,AppId,Vsn},_From,State) ->
    Reply=appl_lib:member(AppId,Vsn),
    {reply, Reply, State};

%%--------------- host_info_specs

handle_call({host_all_info},_From,State) ->
    Reply=not_implmented,
    {reply, Reply, State};

handle_call({host_all_hostnames},_From,State) ->
    Reply=not_implmented,
    {reply, Reply, State};

handle_call({host_local_ip,HostName},_From,State) ->
    Reply=host_spec:item(local_ip,HostName),
    {reply, Reply, State};

handle_call({host_public_ip,HostName},_From,State) ->
        Reply=host_spec:item(public_ip,HostName),
    {reply, Reply, State};

handle_call({host_ssh_port,HostName},_From,State) ->
    Reply=host_spec:item(ssh_port,HostName),
    {reply, Reply, State};

handle_call({host_uid,HostName},_From,State) ->
    Reply=host_spec:item(uid,HostName),
    {reply, Reply, State};

handle_call({host_passwd,HostName},_From,State) ->
    Reply=host_spec:item(passwd,HostName),
    {reply, Reply, State};

handle_call({host_application_config,HostName},_From,State) ->
    Reply=host_spec:item(application_config,HostName),
    {reply, Reply, State};

%%--------------- cluster specs

handle_call({cluster_cookie,AppId},_From,State) ->
    Reply=cluster_spec:item(cookie,AppId),
    {reply, Reply, State};

handle_call({cluster_dir,AppId},_From,State) ->
    Reply=cluster_spec:item(dir,AppId),
    {reply, Reply, State};

handle_call({cluster_hostnames,AppId},_From,State) ->
    Reply=cluster_spec:item(hostnames,AppId),
    {reply, Reply, State};

handle_call({cluster_num_pods,AppId},_From,State) ->
    Reply=cluster_spec:item(num_pods,AppId),
    {reply, Reply, State};


%%----------------------------------------------------------------------

handle_call({ping},_From,State) ->
    Reply=pong,
    {reply, Reply, State};

handle_call({stop}, _From, State) ->    
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    Reply = {unmatched_signal,?MODULE,Request,From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% -------------------------------------------------------------------
    
handle_cast(Msg, State) ->
    io:format("unmatched match cast ~p~n",[{?MODULE,?LINE,Msg}]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------


handle_info({stop}, State) ->
    io:format("stop ~p~n",[{?MODULE,?LINE}]),
    exit(self(),normal),
    {noreply, State};

handle_info(Info, State) ->
    io:format("unmatched match info ~p~n",[{?MODULE,?LINE,Info}]),
    {noreply, State}.


%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Internal functions
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------
