module Domains
  #Domains
  #GET /domains.json/applications/stats/top
  def get_domain_top_app_stats
    resource_path= "domains.json/applications/stats/top"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)    
  end
  #GET /domains.json
  def get_all_domains
    resource_path= "domains.json"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args)
  end 
end