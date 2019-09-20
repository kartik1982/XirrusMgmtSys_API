module AccessPoints
  #Access Points AP
  #GET /accesspoints/statuses
  def get_accesspoints_status
    get_papi("accesspoints.json/statuses/")  
  end
  #GET /accesspoints.json
  def get_accesspoints
    get_papi("accesspoints.json")
  end
  #PUT /accesspoints.json/{serialNumber}
  def update_accesspoint_by_serial(ap_sn, load)
    put_papi("accesspoints.json"+"/#{ap_sn}/", load)
  end  
  def cust_get_accesspoint_id_by_serial(serial_number)
    response = get_accesspoints
    if response.size > 0
      arrays= JSON.parse(response.body)['data'] 
      array = nil
      arrays.each do |item|
        if item.value?(serial_number)
          array= item
          break
        end
      end 
      return array['id']
    else
      serial_number
    end      
  end
end

