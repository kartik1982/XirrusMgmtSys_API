module Arrays
  #GET /arrays.json/serialnumber/{serialNumber}
  def get_array_by_serial(serial)   
    get_api("arrays.json/serialnumber/#{serial}")  
  end
  #GET /arrays.json/macaddress/{macAddress}
  def get_array_by_mac(mac)
    get_api("arrays.json/macaddress/#{mac}")
  end
  #GET /arrays.json/global/macaddress/{macAddress}
  def get_global_by_mac(mac)
    get("arrays.json/global/macaddress/#{mac}")
  end
  #GET /arrays.json/global/serialnumber/{serialNumber}
  def get_global_by_serial(serial)
    get_api("arrays.json/global/serialnumber/#{serial}")
  end  
end