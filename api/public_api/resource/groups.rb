module Groups
  #Groups
  #GET /groups.json
  def get_all_groups
    resource_path= "groups.json"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)   
  end
  #GET /groups.json/{groupName}/clients/stats/top
  def get_group_top_clients_stat(group_name)
    resource_path= "groups.json/#{group_name}/clients/stats/top"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end
  #GET /groups.json/{groupName}/clients/statuses
  def get_group_top_clients_statuses(group_name)
    resource_path= "groups.json/#{group_name}/clients/statuses"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end
  #GET /groups.json/{groupName}/applications/stats/top
  def get_group_top_app_stats(group_name)
    resource_path= "groups.json/#{group_name}/applications/stats/top"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})    
    get(args)
  end
  #GET /groups.json/{groupName}/accesspoints/statuses
  def get_group_top_accesspoints_statuses(group_name)
    resource_path= "groups.json/#{group_name}/accesspoints/statuses"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end 
end