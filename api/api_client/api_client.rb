require 'rest-client'

require_relative "./resource/users.rb"
require_relative "./resource/arrays.rb"
require_relative "./resource/groups.rb"
require_relative "./resource/profiles.rb"

module API
    
  class ApiClient 
    include Users
    include Arrays
    include Groups
    include Profiles
    
    attr_accessor :api_url, :username, :password, :token, :key_secret, :key_secret
    def initialize(args={})
        @api_url = args[:host]
        @username = args[:username]
        @password = args[:password]
        @token = get_access_token
    end 
    
    def api_common_params
      args={
          url: @api_url,    
          resource_path: "",
          load: {},
          access_token: @token,     
        }
    end
    
    def get_api(resource_path)   
      get(api_common_params.update({resource_path: resource_path, load: {}}))
    end
    def post_api(resource_path, load)   
      post(api_common_params.update({resource_path: resource_path, load: load}))
    end
    def put_api(resource_path, load)   
      put(api_common_params.update({resource_path: resource_path, load: load}))
    end
    
    def get_access_token
      api_url= @api_url
      username= @username
      password= @password
      token  = RestClient.post("#{api_url}/oauth/token", 
                                                        {grant_type: 'password', 
                                                          username: username, 
                                                          password: password, 
                                                          client_id: 'xmsmobileclient', 
                                                          client_secret: 'Xirrus!23', 
                                                          format: 'json', 
                                                          content_type: 'json', 
                                                          accept: 'json'})
      token = token[/[a-z0-9]{8}(-[a-z0-9]{4}){3}-[a-z0-9]{12}/]
    end 
    
    def get_integration_key_id_secret(load={})
      api_url= @api_url
      token= @token
      puts "#{@api_url}/api/v2/integration.json/?access_token=#{token}"
      load=load.to_json
      res = RestClient.post("#{api_url}/api/v2/integration.json/?access_token=#{token}", 
                              load, 
                              {format: 'json', 
                                content_type: 'json', 
                                accept: 'json'})
      res= JSON.parse(res.body)
      @key_id = res["keyId"]
      @key_secret =res["keySecret"]      
    end
    
    def get_ext_api_access_token(ext_url, load, x_api_key)
      get_integration_key_id_secret(load)
      key_id= @key_id
      key_secret= @key_secret
      puts "#{ext_url}/v1/oauth/token"
      ext_api_token = RestClient.get("#{ext_url}/v1/oauth/token/", 
                                    params: {grant_type: 'password', 
                                             username: key_id, 
                                             password: key_secret, 
                                             format: 'json', 
                                             content_type: 'json', 
                                             accept: 'json'}, 
                                             :'x-api-key'=> x_api_key)
      ext_api_token = ext_api_token.split(',')[0].split(':')[1].gsub(/"/,'')
    end
    def get_entitlement_api_access_token(ext_url, load)
      get_integration_key_id_secret(load)
      key_id= @key_id
      key_secret= @key_secret
      puts "#{ext_url}/oauth/token"
      ext_api_token = RestClient.post("#{ext_url}/oauth/token", 
                                            {
                                              grant_type: 'password',
                                              username: key_id, 
                                              password: key_secret,
                                              client_id: 'client.entitlements',
                                              client_secret: 'secret.entitlements',                              
                                              format: 'json',
                                              content_type: 'json',
                                              accept: 'json'})
      ext_api_token = ext_api_token.split(',')[0].split(':')[1].gsub(/"/,'')
    end

    def get(args={})
      call(:get, args)
    end
    def put(args={})
      call(:put, args)
    end
    def post(args={})
      call(:post, args)
    end
    def delete(args={})
      call(:delete, args)
    end
    
    def call(_method, args={})
      ext_api = args[:ext_api] || false
      if ext_api
        url = args[:url]+"/v1/rest/api/"
        headers = {format: 'json', content_type: 'json', :'x-api-key'=> args[:x_api_key]}
      else
        url = args[:url]+"/api/v2/"
        headers = {format: 'json', content_type: 'json', accept: 'json'}
      end
      access_token="?access_token=#{args[:access_token]}"
      resource_path= args[:resource_path]
      load= args[:load]
      path = url+resource_path+access_token
      puts "PATH = #{path}"
      begin
        case _method
        when :get
          response =RestClient.get(path, headers)
        when :put
          response =RestClient.put(path, load.to_json, headers)
        when :post
          response =RestClient.post(path, load.to_json, headers)
        when :delete
          response =RestClient.delete(path, headers)
        end
        puts response
        response
      rescue => e
          puts  e.message
          response = e.response
      end      
    end
  end #ApiClient   
end