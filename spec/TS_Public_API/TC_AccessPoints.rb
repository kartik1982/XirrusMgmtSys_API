require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR ACCESS POINTS ************" do
  before :all do    
     @papi= public_api
  end
  it "verify public API to status of all access point for tenant" do
    response = @papi.get_accesspoints_status
    expect(response.code).to eq(200)
  end
  it "verify public API to list all access for tenant" do
    response = @papi.get_accesspoints
    expect(response.code).to eq(200)
  end
  it "verify public api to update access point hostname and location using serial number" do
      if @env=="test03"
        ap_serial = "X5147480F922C"
        ap_host_name = "Kartik-XD4-240-Test03"
        ap_location = "Test03-Setup-Desk"
      elsif @env=="test01"
        ap_serial = "X017629FA6984"
        ap_host_name = "Kartik-XA4-240-Test01"
        ap_location = "Test03-Setup-Desk"
      end
    response = @papi.update_accesspoints_location(ap_serial, ap_host_name, ap_location)    
    expect(response.code).to eq(204)
  end
end



