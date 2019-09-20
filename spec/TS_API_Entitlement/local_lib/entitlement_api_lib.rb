require_relative '../../../api/entitlement_api/entitlement_api.rb'

def get_entitlement_api_args
  env = @env
  case env
  when "production"
  args={
        username: @username,
        password:@password,
        host: @login_url,
        ent_url: "https://test03-api-94151060.cloud.xirrus.com",
        ent_load: { product: "ENTITLEMENTS", scope: "READ_WRITE"}
  }
  when "preview"
    # $VERBOSE = nil
    # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    args={
        username: @username,
        password:@password,
        host: @login_url,
        ent_url: "https://test03-api-94151060.cloud.xirrus.com",
        ent_load: { product: "ENTITLEMENTS", scope: "READ_WRITE"}
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
        host: @login_url,
        ent_url: "https://test01-api-311195077.cloud.xirrus.com",
        ent_load: { product: "ENTITLEMENTS", scope: "READ_WRITE"}
    }
    args
 end
end

def entitlement_api
  API::EntitlementApi.new(get_entitlement_api_args)
end