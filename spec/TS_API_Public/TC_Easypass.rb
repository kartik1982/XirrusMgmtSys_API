require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR EASYPASS ************" do
  guest_amba_portal = "Public_API_Eassypassoup_Guest_Amba_Portal"
  guest_01 = {name: "papi_guest_01", email: "papi_guest_01@test.com"}
  guest_01 = {name: "papi_guest_02", email: "papi_guest_02@test.com"}

  before :all do    
     @papi= public_api
     group_load = { name: group_name, description: "Description for "+group_name}
     @api.post_group(group_load)
     groups = JSON.parse(@api.get_groups.body)['data']
     groups.each do |item|
       if item.value?(group_name)
         group = item
         break
       end
     end  
     array_id = JSON.parse(@api.get_array_by_serial(ap_serial))['id']
     res = @api.put_add_aps_to_group(group['id'], [array_id])  
     puts res.body
  end
  it "verify public API to get list of all groups" do
    response = @papi.get_all_groups
    expect(response.code).to eq(200)
  end
  it "verify public API to get top accesspoints status for group" do
    response = @papi.get_group_top_accesspoints_statuses(group_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to get top application stats for group" do
    response = @papi.get_group_top_app_stats(group_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to get top clients stats for group" do
    response = @papi.get_group_top_clients_stat(group_name)
    expect(response.code).to eq(200)
  end
  it "verify public API to get top clients statuses for group" do
    response = @papi.get_group_top_clients_statuses(group_name)
    expect(response.code).to eq(200)
  end
end