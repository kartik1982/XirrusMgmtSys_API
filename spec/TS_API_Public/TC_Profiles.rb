require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR PROFILES ************" do
  profile_name = "Public_API_Profile"
  ssid_name = "Public_API_SSID"
  ap_serial = "X30744903864E"
  portal_name = "Public_API_Portal"
  array_id= nil

  before :all do    
     @papi= public_api
     profile_load = { name: profile_name, description: "Description for "+profile_name}
     @api.post_profile(profile_load)
  end
  it "verify public API to unassign access points from profile" do
    array_id = @papi.cust_get_accesspoint_id_by_serial(ap_serial)
    response = @papi.put_unassign_accesspoints_from_profile(profile_name, [array_id])
    expect(response.code).to eq(200)
  end 
  it "verify public API to assign access points to profile" do
    response = @papi.put_assign_accesspoints_to_profile(profile_name, [array_id])
    expect(response.code).to eq(204)
  end   
  it "verify public API to get access points status in profile" do
    response = @papi.get_accesspoints_status_in_profile(profile_name)
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)['totalCount']).to eq(1)
  end   
  it "verify public API to add ssids into profile" do
    response = @papi.post_add_ssids_into_profile(profile_name, {ssidName: ssid_name})
    expect(response.code).to eq(200)
  end
  it "verify public API to assign ssid from profile to portal" do
    response = @papi.put_assign_ssid_from_profile_to_portal(profile_name, ssid_name, portal_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to delete ssid from profile and portal" do
    response = @papi.delete_ssid_from_from_profile_and_portal(profile_name, ssid_name)
    expect(response.code).to eq(200)
  end
  it "add ssid back to profile and assign to portal" do
    #add ssid back to profile and portal
    @papi.post_add_ssids_into_profile(profile_name, {ssidName: ssid_name})
    @papi.put_assign_ssid_from_profile_to_portal(profile_name, ssid_name, portal_name)
  end
  it "verify public API to get top application stats for profile" do
    response = @papi.get_top_application_stats_for_profile(profile_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to get client statuses for profile" do
    response = @papi.get_client_statuses_for_profile(profile_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to get access points for profile" do
    response = @papi.get_accesspoints_for_profile(profile_name)
    expect(response.code).to eq(200)
    arrays=JSON.parse(response)['data']
    expect(arrays.size).to eq(1)
    expect(arrays[0]['serialNumber']).to eq(ap_serial)    
  end
  it "verify public API to get ssids for profile" do
    response = @papi.get_ssids_for_profile(profile_name)
    expect(response.code).to eq(200)
    ssids=JSON.parse(response)
    expect(ssids.size).to eq(1)
    expect(ssids[0]['ssidName']).to eq(ssid_name)
  end
  it "verify public API to get list of profiles" do
    response = @papi.get_list_of_profiles
    expect(response.code).to eq(200)
    profiles=JSON.parse(response)['data']
    expect(profiles.size).to eq(1)
    expect(profiles[0]['name']).to eq(profile_name)
  end  
  it "verify public API to get top clients stats for profile" do
    response = @papi.get_top_clients_stats_for_profile(profile_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to update SSID in profile" do
    response = @papi.put_update_ssid_for_profile(profile_name, ssid_name, {ssidName: ssid_name, band: 'DOT11A', enabled: true, broadcast: true})
    expect(response.code).to eq(200)
    ssids = JSON.parse(@papi.get_ssids_for_profile(profile_name).body)
    expect(ssids[0]['ssidName']).to eq(ssid_name)
    expect(ssids[0]['band']).to eq("DOT11A")
    expect(ssids[0]['broadcast']).to eq(true)
  end
end