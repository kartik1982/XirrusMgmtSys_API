require_relative '../../../api/public_api/public_api.rb'

def get_public_api_args
  env = @env
  case env
  when "production"
  args={
        username: @username,
        password:@password,
        host: @login_url,
        ap_serial: "X2187488B5C22",
        ap_host_name: "Kartik-XD2-230-Prod",
        papi_url: "https://api.cloud.xirrus.com",
        x_api_key: "ng1iwvvJ0T3iXVB6yxJXv9nsBjKOpd8l1lkc4L0t",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
  }
  when "preview"
    # $VERBOSE = nil
    # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    args={
        username: @username,
        password:@password,
        host: @login_url,
        ap_serial: "X6137425FD2FC",
        ap_host_name: "Kartik-XD2-240-Prev-01",
        papi_url: "https://api-preview.cloud.xirrus.com",        
        x_api_key: "1sXmZ7iy7P84UWdZ3hQxj8PRCpmUOVm093AYjs0u",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
    }
  when "test03"
    args={
        username: @username,
        password:@password,
        host: @login_url,
        papi_url: "https://api-uswest1-test03.cloud.xirrus.com",
        x_api_key: "OslLhuOfuO9Unn2X9D2Hhaewt9gUHWNg7GM3AIjL",
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
    }
  when "test01"
    args={
        username: @username,
        password:@password,
        host: @login_url,
        papi_url: "https://api-test01.cloud.xirrus.com",
        x_api_key: "KEu68RCVyt1wx4nlBpFhH3QYBkuBJ9S03amk2F9z",        
        papi_load: { product: "PAPI", scope: "READ_WRITE"}
    }
    args
 end
end

def public_api
  API::PublicApi.new(get_public_api_args)
end