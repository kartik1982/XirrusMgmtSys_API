require_relative "local_lib/public_api_lib.rb"
describe "*******TESTCASE: PUBLIC API FOR ACCESS POINTS ************" do
  ap_serial, ap_host_name, ap_location =nil
  before :all do    
     @papi= public_api
     if @env=="test03" || @env=="test01" || @env=="preview"
        ap_serial = "X30744903864E"
        ap_host_name = "Host-X30744903864E"
        ap_location = "SQA-WALL-SETUP"
      elsif @env=="production"
        ap_serial = "X30744903864E"
        ap_host_name = "HOst-Test01-X30744903864E"
        ap_location = "Test03-Setup-Desk"
      end
  end
  it "verify public API to get status of all access point for tenant" do
    response = @papi.get_accesspoints_status
    expect(response.code).to eq(200)
  end
  it "verify public api to update access point hostname and location using serial number" do      
    load={ hostName: "#{ap_host_name}", location: "#{ap_location}" }
    response = @papi.update_accesspoint_by_serial(ap_serial, load) 
    expect(response.code).to eq(204)    
  end
  it "verify public API to list all access point for tenant" do
    response = @papi.get_accesspoints
    expect(response.code).to eq(200)
    arrays= JSON.parse(response.body)['data'] 
    array = nil
    arrays.each do |item|
      if item.value?(ap_serial)
        array= item
        break
      end
    end   
    expect(array['hostName']).to eq ap_host_name
    expect(array['location']).to eq ap_location
  end  
end



