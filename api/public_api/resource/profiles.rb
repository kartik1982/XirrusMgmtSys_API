module Profiles
  #PUT /profiles.json/{profileName}/accesspoints/unassign
  def put_unassign_accesspoints_from_profile(profile_name, array_load)
    put_papi("profiles.json/#{profile_name}/accesspoints/unassign", array_load)
  end
  #PUT /profiles.json/{profileName}/accesspoints
  def put_assign_accesspoints_to_profile(profile_name, array_load)
    put_papi("profiles.json/#{profile_name}/accesspoints", array_load)
  end
  #GET /profiles.json/{profileName}/accesspoints/statuses
  def get_accesspoints_status_in_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/accesspoints/statuses")
  end
  #POST /profiles.json/{profileName}/ssids
  def post_add_ssids_into_profile(profile_name, ssid_load)
    post_papi("profiles.json/#{profile_name}/ssids", ssid_load)
  end
  #PUT /profiles.json/{profileName}/ssids/{ssidName}/portals
  def put_assign_ssid_from_profile_to_portal(profile_name, ssid_name, portal_name)
    url = "#{@papi_url}/v1/rest/api/"
    path = "#{url}profiles.json/#{profile_name}/ssids/#{ssid_name}/portals?portalName=#{portal_name}&access_token=#{@papi_token}"
    load = {}
    headers = {format: 'json', content_type: 'json', 'x-api-key': @x_api_key}
    begin
      response =RestClient.put(path, load.to_json, headers)
    rescue => e
      puts e
      e.response
    end
  end
  #DELETE /profiles.json/{profileName}/ssids/{ssidName}
  def delete_ssid_from_from_profile_and_portal(profile_name, ssid_name)
    delete_papi("profiles.json/#{profile_name}/ssids/#{ssid_name}")
  end
  #GET /profiles.json/{profileName}/applications/stats/top
  def get_top_application_stats_for_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/applications/stats/top")
  end  
  #GET /profiles.json/{profileName}/clients/statuses
  def get_client_statuses_for_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/clients/statuses")
  end  
  #GET /profiles.json/{profileName}/accesspoints
  def get_accesspoints_for_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/accesspoints")
  end
  #GET /profiles.json/{profileName}/ssids
  def get_ssids_for_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/ssids")
  end
  #GET /profiles.json
  def get_list_of_profiles
    get_papi("profiles.json")
  end
  #GET /profiles.json/{profileName}/clients/stats/top
  def get_top_clients_stats_for_profile(profile_name)
    get_papi("profiles.json/#{profile_name}/clients/stats/top")
  end 
  # PUT /profiles.json/{profileName}/ssids/{ssidName}
  def put_update_ssid_for_profile(profile_name, ssid_name, ssid_load)
    put_papi("profiles.json/#{profile_name}/ssids/#{ssid_name}", ssid_load)
  end
end