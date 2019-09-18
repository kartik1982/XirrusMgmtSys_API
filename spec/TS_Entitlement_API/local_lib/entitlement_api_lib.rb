require_relative '../../../api/entitlement_api/entitlement_api.rb'

def get_entitlement_api_args
  env = @env
  case env
  when "production"
  args={
        username: @username,
        password:@password,
        host: "https://login.xirrus.com",
        papi_url: "https://api.cloud.xirrus.com",
        sc_api_url: "https://prod1-lb-api-32063211.cloud.xirrus.com",
        x_api_key: "ng1iwvvJ0T3iXVB6yxJXv9nsBjKOpd8l1lkc4L0t",
        ap_serial: "X2187488B5C22",
        ap_host_name: "Kartik-XD2-230-Prod",
        group_name: "Kartik_pro_Group",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
  }
  when "preview"
    # $VERBOSE = nil
    # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    args={
        username: @username,
        password:@password,
        host: "https://login-preview.xirrus.com",
        papi_url: "https://api-preview.cloud.xirrus.com",
        sc_api_url: "https://prev-prd1-api-923206858.cloud.xirrus.com",
        x_api_key: "1sXmZ7iy7P84UWdZ3hQxj8PRCpmUOVm093AYjs0u",
        ap_serial: "X6137425FD2FC",
        ap_host_name: "Kartik-XD2-240-Prev-01",
        group_name: "Kartik_Group",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
    }
  when "test03"
    args={
        username: @username,
        password:@password,
        host: @login_url,
        ent_url: "https://test03-api-94151060.cloud.xirrus.com",
        ent_load: { product: "ENTITLEMENTS", scope: "READ_WRITE"}
    }
  when "test01"
    args={
        username: @username,
        password:@password,
        host: "https://login-test01.cloud.xirrus.com",
        papi_url: "https://api-test01.cloud.xirrus.com",
        sc_api_url: "https://test01-api-311195077.cloud.xirrus.com",
        x_api_key: "KEu68RCVyt1wx4nlBpFhH3QYBkuBJ9S03amk2F9z",        
        group_name: "NEW_Kartik_GROUP",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
    }
    args
 end
end

def entitlement_api
  API::EntitlementApi.new(get_entitlement_api_args)
end