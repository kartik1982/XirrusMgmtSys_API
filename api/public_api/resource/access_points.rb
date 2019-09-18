module AccessPoints
  #Access Points AP
  #GET /accesspoints/statuses
  def get_accesspoints_status
    resource_path= "accesspoints.json/statuses/"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})    
    get(args)    
  end
  #GET /accesspoints.json
  def get_accesspoints
    resource_path= "accesspoints.json"
    load={}
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    get(args) 
  end
  #PUT /accesspoints.json/{serialNumber}
  def update_accesspoints_location(ap_sn, ap_host, ap_location)
    resource_path="accesspoints.json"+"/#{ap_sn}/"
    load={ hostName: "#{ap_host}", location: "#{ap_location}" }
    args = papi_common_params.update({resource_path: resource_path, load: load})   
    put(args)
  end  
end

