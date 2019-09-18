require_relative "../api_client/api_client"
$:.unshift File.dirname(__FILE__)
require 'resource/access_points'
require 'resource/clients'
require 'resource/domains'
require 'resource/groups'
module API
  class PublicApi < API::ApiClient 
    attr_accessor :papi_url, :papi_token, :x_api_key
    include AccessPoints
    include Clients
    include Domains
    include Groups
    
    def initialize(args={})
      super
      @x_api_key = args[:x_api_key]
      @papi_url = args[:papi_url]
      @papi_token = get_ext_api_access_token(args[:papi_url], args[:papi_load], args[:x_api_key])
    end  
    def papi_common_params
      args={
          ext_api: true,
          url: @papi_url,    
          resource_path: "",
          load: {},
          access_token: @papi_token,
          x_api_key: @x_api_key      
        }  
    end 
  end
end
