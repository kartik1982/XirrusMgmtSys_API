require_relative "local_lib/entitlement_api_lib.rb"
describe "*********TESTCASE: ENTITLEMENT API FOR CUSTOMER***********" do
  email_address= "kartik.aiyar@riverbed.com"
  before :all do
    @eapi = entitlement_api
    @erpid = "f240a1a0-6774-11e9-84bf-122cde87cfa8" #TBD using xirrus api get erpid
  end
  it "verify entitlement API for get cusomter using erpid" do    
    response = @eapi.get_tenant_by_erpid(@erpid)
    expect(response.code).to eq(200)
  end
  it "verify entitlement API for get customer usinmg email address" do
    response = @eapi.get_tenant_by_email(email_address)
    expect(response.code).to eq(200)
  end
  it "verify entitlement API to add-update tenant with erpid" do    
    tenant={ erpId: "entitlement-erpid-automation-api",
         transactionId: "1234567890",
         name: "entitlement-erpid-automation-api", 
         contactEmail: [ "entitlement.user01@contact.com","entitlement.user02@contact.com" ],  
         product: "XMS", 
         term: 14, 
         count: 20, 
         appControl: true, 
         easyPass: true, 
         parentErpId: "parent.erp1"}         
    response = @eapi.add_tenant(tenant)
    expect(response.code).to eq(200)
  end
end