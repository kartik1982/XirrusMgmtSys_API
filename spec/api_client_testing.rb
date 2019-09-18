require_relative '../api/api_client/api_client.rb'
require 'rest-client'
require 'json'
require 'rspec'

args={
        username: "kartik.aiyar@riverbed.com",
        password:"Kartik@123",
        api_url: "https://login-test03.cloud.xirrus.com"
  }
api_client = API::ApiClient.new(args)
api_client.get_users
sleep 2
