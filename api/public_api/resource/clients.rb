module Clients
  #Clients
  #GET /clients.json/statuses
  def get_clients_status
    get_papi("clients.json/statuses/")  
  end
  #GET /clients.json/stats/top
  def get_top_clients_stat
    get_papi("clients.json/stats/top")
  end
  #GET /clients.json
  def get_all_clients
    get_papi("clients.json")
  end 
end