require_relative '../api/entitlement_api/entitlement_api.rb'
require 'rest-client'
require 'json'
require 'rspec'
##########SET ENV FOR PUBLIC API############
env="test03"
ext_api="papi"

case env
  when "production"
  args={
        username: "kartik.aiyar@riverbed.com",
        password:"Kartik@123",
        api_url: "https://login.xirrus.com",
        papi_url: "https://api.cloud.xirrus.com",
        sc_api_url: "https://prod1-lb-api-32063211.cloud.xirrus.com",
        x_api_key: "ng1iwvvJ0T3iXVB6yxJXv9nsBjKOpd8l1lkc4L0t",
        ap_serial: "X2187488B5C22",
        ap_host_name: "Kartik-XD2-230-Prod",
        group_name: "Kartik_pro_Group",
        papi_load: { product: "PAPI", scope: "READ_WRITE"},
        ent_url: "https://test01-api-311195077.cloud.xirrus.com",
        ent_load: { product: "PAPI", scope: "READ_WRITE"}
  }
  when "preview"
    $VERBOSE = nil
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    args={
        username: "kartik.aiyar@riverbed.com",
        password: "Kartik@123",
        api_url: "https://login-preview.xirrus.com",
        papi_url: "https://api-preview.cloud.xirrus.com",
        sc_api_url: "https://prev-prd1-api-923206858.cloud.xirrus.com",
        x_api_key: "1sXmZ7iy7P84UWdZ3hQxj8PRCpmUOVm093AYjs0u",
        ap_serial: "X6137425FD2FC",
        ap_host_name: "Kartik-XD2-240-Prev-01",
        group_name: "Kartik_Group",
        papi_load: { product: "PAPI", scope: "READ_WRITE"},
        ent_url: "https://test01-api-311195077.cloud.xirrus.com",
        ent_load: { product: "PAPI", scope: "READ_WRITE"}
    }
  when "test03"
    $VERBOSE = nil
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    args={
        username: "kartik.aiyar@riverbed.com",
        password:"Kartik@123",
        api_url: "https://login-test03.cloud.xirrus.com",
        papi_url: "https://api-uswest1-test03.cloud.xirrus.com",
        sc_api_url: "https://test03-api-94151060.cloud.xirrus.com",
        x_api_key: "OslLhuOfuO9Unn2X9D2Hhaewt9gUHWNg7GM3AIjL",
        ap_serial: "X0187167203E5",
        ap_host_name: "Kartik-XD4-240-Test03",
        group_name: "Kartik_Group",
        papi_load: { product: "PAPI", scope: "READ_WRITE"},
        ent_url: "https://test03-api-94151060.cloud.xirrus.com",
        ent_load: { product: "ENTITLEMENTS", scope: "READ_WRITE"}
    }
  when "test01"
    args={
        username: "kartik.aiyar@riverbed.com",
        password: "Kartik@123",
        api_url: "https://login-test01.cloud.xirrus.com",
        papi_url: "https://api-test01.cloud.xirrus.com",
        sc_api_url: "https://test01-api-311195077.cloud.xirrus.com",        
        x_api_key: "KEu68RCVyt1wx4nlBpFhH3QYBkuBJ9S03amk2F9z",
        ap_serial: "X017629FA6984",
        ap_host_name: "Kartik-XA4-240-Test01",
        group_name: "NEW_Kartik_GROUP",
        papi_load: { product: "PAPI", scope: "READ_WRITE"},
        ent_url: "https://test01-api-311195077.cloud.xirrus.com",
        ent_load: { product: "PAPI", scope: "READ_WRITE"}
    }
end

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
         
ent_api = API::EntitlementApi.new(args)
#Access Points API
ent_api.get_tenant_by_erpid("f240a1a0-6774-11e9-84bf-122cde87cfa8")
ent_api.get_tenant_by_email("kartik.aiyar@xirrus.com")
ent_api.add_tenant(tenant)





