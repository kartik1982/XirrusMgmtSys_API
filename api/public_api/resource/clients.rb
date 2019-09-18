module Clients
  #Clients
  #GET /clients.json/statuses
  def get_clients_status
    resource_path= "clients.json/statuses/"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)   
  end
  #GET /clients.json/stats/top
  def get_top_clients_stat
    resource_path= "clients.json/stats/top"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load}) 
    get(args)
  end
  #GET /clients.json
  def get_all_clients
    resource_path= "clients.json"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load}) 
    get(args)
  end 
end