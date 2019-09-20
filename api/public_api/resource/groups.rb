module Groups
  #Groups
  #GET /groups.json
  def get_all_groups
    get_papi("groups.json")  
  end
  #GET /groups.json/{groupName}/clients/stats/top
  def get_group_top_clients_stat(group_name)
    get_papi("groups.json/#{group_name}/clients/stats/top")
  end
  #GET /groups.json/{groupName}/clients/statuses
  def get_group_top_clients_statuses(group_name)
    get_papi("groups.json/#{group_name}/clients/statuses")
  end
  #GET /groups.json/{groupName}/applications/stats/top
  def get_group_top_app_stats(group_name)
    get_papi("groups.json/#{group_name}/applications/stats/top")
  end
  #GET /groups.json/{groupName}/accesspoints/statuses
  def get_group_top_accesspoints_statuses(group_name)
    get_papi("groups.json/#{group_name}/accesspoints/statuses")
  end 
end