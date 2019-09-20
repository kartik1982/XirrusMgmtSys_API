require_relative "local_lib/entitlement_api_lib.rb"
describe "*********TESTCASE: ENTITLEMENT API FOR CUSTOMER***********" do
  erp_id = "entitlement-tenant-automation-api"
  tenant_name ="entitlement-erpid-automation-api"
  email_address = "entitlement.user01@contact.com"
  count= 20
  before :all do
    @eapi = entitlement_api
  end
  it "verify entitlement API to add-update tenant with erpid" do    
    tenant_load={erpId: erp_id,
                 transactionId: "1234567890",
                 name: tenant_name, 
                 contactEmail: [ email_address, "entitlement.user02@contact.com" ],  
                 product: "XMS", 
                 term: 14, 
                 count: count, 
                 appControl: true, 
                 easyPass: true, 
                 parentErpId: "parent.erp1"}         
    response = @eapi.put_add_tenant(tenant_load)
    expect(response.code).to eq(200)
  end
  it "verify entitlement API for get cusomter using erpid" do    
    response = @eapi.get_tenant_by_erpid(erp_id)
    expect(response.code).to eq(200)
    tenant= JSON.parse(response.body)
    expect(tenant['erpId']).to eq(erp_id)
    expect(tenant['name']).to eq(tenant_name)
    expect(tenant['maxCount']).to eq(count)    
  end
  
  it "verify entitlement API for get customer usinmg email address" do
    response = @eapi.get_tenant_by_email(email_address)
    expect(response.code).to eq(200)
    tenant= JSON.parse(response.body)
    expect(tenant['erpId']).to eq(erp_id)
    expect(tenant['name']).to eq(tenant_name)
    expect(tenant['maxCount']).to eq(count)
  end  
end