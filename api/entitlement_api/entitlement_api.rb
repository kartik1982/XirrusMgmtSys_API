require_relative "../api_client/api_client"
$:.unshift File.dirname(__FILE__)
require 'resource/tenants'

module API
  class EntitlementApi < API::ApiClient 
    attr_accessor :ent_url, :ent_token, :x_api_key
    include Tenants
    
    def initialize(args={})
      super
      @x_api_key = args[:x_api_key]
      @ent_url = args[:ent_url]
      @ent_token = get_entitlement_api_access_token(args[:ent_url], args[:ent_load])
    end 
    def ent_common_params
      args={
          ext_api: true,
          url: @ent_url,    
          resource_path: "",
          load: {},
          access_token: @ent_token   
        }  
    end   
  end
end
