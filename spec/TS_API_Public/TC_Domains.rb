require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR DOMAINS ************" do
  before :all do    
     @papi= public_api
  end
  it "verify public API to get list of all domains" do
    response = @papi.get_all_domains
    expect(response.code).to eq(200)
  end
  it "verify public API to get top application stats" do
    response = @papi.get_domain_top_app_stats
    expect(response.code).to eq(200)
  end 
end