require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR EASYPASS ************" do
  profile_name = "Public_API_Profile"
  ssid_name = "Public_API_SSID"  
  portal_name = "Public_API_Portal"
  guest_01 = {name: "papi_guest_01", email: "papi_guest_01@test.com", password: {value: "Qwerty1@", isSet: true}}
  guest_02 = {name: "papi_guest_02", email: "papi_guest_02@test.com", password: {value: "Qwerty1@", isSet: true}}
  onboarding_portal ={name: "Public_API_Onboarding_Portal", description: "Description for Public_API_Onboarding_Portal", type: "UPSK"} #UPSK SECRETARY
  psk={psk: "apiuserpskgenerate", userid: "apiuserpsk01", name: "api_user_01", preferredEmail: "api.user@testing.com", enabled: true}
  before :all do    
     @papi= public_api
     portal_load = {name: portal_name, description: "Description for "+portal_name, type: "SECRETARY"}
     profile_load = { name: profile_name, description: "Description for "+profile_name} 
     @api.post_profile(profile_load) 
     #create Self Registration portal 
     @api.post_add_easypass_portal(portal_load)
     #Create Onboarding portal
     @api.post_add_easypass_portal(onboarding_portal)
  end
  it "verify public API to get list of all easypass portals" do
    response = @papi.get_all_easypass_portals
    expect(response.code).to eq(200)
  end
  it "verify public API to get easypass portal by name" do
    response = @papi.get_easypass_portal_by_name(portal_name)
    expect(response.code).to eq(200)
    portal = JSON.parse(response.body)
    expect(portal['name']).to eq(portal_name)
  end
  it "verify public API to get list all ssids for easypass portal" do
    @papi.put_assign_ssid_from_profile_to_portal(profile_name, ssid_name, portal_name)
    response = @papi.get_ssids_for_easypass_portal(portal_name)
    expect(response.code).to eq(200)
    ssids= JSON.parse(response)
    expect(ssids[0]['ssidName']).to eq(ssid_name)
  end
  it "verify public API to add guest to easypass portal" do
    response = @papi.post_add_guest_to_easypass_portal(portal_name, guest_01)
    response = @papi.post_add_guest_to_easypass_portal(portal_name, guest_02)
    expect(response.code).to eq(200)
    guest= JSON.parse(response.body)
    expect(guest['name']).to eq(guest_02[:name])    
  end
  it "verify public API to get all guest from easypass portal" do
    response = @papi.get_all_guest_from_easypass_portal(portal_name)
    expect(response.code).to eq(200)
    guests= JSON.parse(response.body)
    expect(guests.size).to eq(2)    
  end
  it "verify public API to update guest to easypass portal" do
    response = @papi.put_update_guest_to_easypass_portal(portal_name, guest_01[:email], guest_01.update({name: "papi_guest_01_updated"}))
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)).to eq("Guest updated")    
  end
  it "verify public API to get guest from easypass portal using email" do
    response = @papi.get_guest_from_easypass_portal_with_email(portal_name, guest_01[:email])
    expect(response.code).to eq(200)
    guest= JSON.parse(response.body)
    expect(guest['name']).to eq(guest_01[:name])    
  end
  it "verify public API to delete guest from easypass portal using email address" do
    response = @papi.delete_guest_from_easypass_portal_using_email(portal_name, guest_02[:email])
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)).to eq("Guest deleted")
  end
  it "verify public API to delete all guest from easypass portal" do
    response = @papi.delete_all_guest_from_easypass(portal_name)
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)).to eq("Guests are deleted")
  end
  it "verify public API to add psks to onboarding easypass portal" do
    response = @papi.post_add_psk_to_easypass_portal(onboarding_portal[:name], psk)
    expect(response.code).to eq(200)
  end
  it "verify public API to get psk for onboarding easypass portal using user ID" do
    response = @papi.get_psk_for_easypass_portal_with_userid(onboarding_portal[:name], psk[:userid])
    expect(response.code).to eq(200)
    user = JSON.parse(response.body)
    expect(user['name']).to eq(psk[:name])
  end
  it "verify public API to get list of all psk for onboarding easypass portal" do
    response = @papi.get_psk_for_easypass_portal(onboarding_portal[:name])
    expect(response.code).to eq(200)
  end
  it "verify public API to update psk for onboarding easypass portal" do
    response = @papi.put_update_psk_to_easypass_portal(onboarding_portal[:name], psk[:userid], psk.update({name: "api_user_01_updated", preferredEmail: "api.user.updated@testing.com"}))
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)).to eq("PSK updated")
  end
  it "verify public API to delete psk from onboarding easypass portal" do
    response = @papi.delete_psk_for_easypass_portal(onboarding_portal[:name], psk[:userid])
    expect(response.code).to eq(200)
    expect(JSON.parse(response.body)).to eq("PSK deleted")
  end
end