require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR CLIENTS ************" do
  before :all do    
     @papi= public_api
  end
  it "verify public API to get list of all clients connected to tenant" do
    response = @papi.get_all_clients
    expect(response.code).to eq(200)
  end
  it "verify public API to get all clients stats connected  to tenant" do
    response = @papi.get_top_clients_stat
    expect(response.code).to eq(200)
  end
  it "verify public API to get all clients status connected  to tenant" do
    response = @papi.get_clients_status
    expect(response.code).to eq(200)
  end
end