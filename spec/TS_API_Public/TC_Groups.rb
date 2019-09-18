require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR DOMAINS ************" do
  group_name = "Kartik_Group"
  before :all do    
     @papi= public_api
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