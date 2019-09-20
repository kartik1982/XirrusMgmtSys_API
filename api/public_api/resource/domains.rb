module Domains
  #Domains
  #GET /domains.json/applications/stats/top
  def get_domain_top_app_stats
    get_papi("domains.json/applications/stats/top")  
  end
  #GET /domains.json
  def get_all_domains
    get_papi("domains.json")
  end 
end