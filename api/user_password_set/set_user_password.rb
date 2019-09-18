require 'rest-client'
require 'json'
#set password for user email address in array for env
user_emails=["portal+lookNfeel+automation+xms+admin@xirrus.com"]
password_to_set = "Qwerty1@"
env= "test03"

args={  
  api_url: "https://login-#{env}.cloud.xirrus.com",
  username: "kartik.aiyar@riverbed.com",
  password: "Kartik@123"
}

def get_access_token(api_url: , username: , password: )
  token  = RestClient.post("#{api_url}/oauth/token", {grant_type: 'password', username: username, password: password, client_id: 'xmsmobileclient', client_secret: 'Xirrus!23', format: 'json', content_type: 'json', accept: 'json'})
  token = token[/[a-z0-9]{8}(-[a-z0-9]{4}){3}-[a-z0-9]{12}/]
end  

def get(api_url, resource_path)
    url =api_url+"/api/v2/"
    access_token="?access_token=#{@token}"   
    path = url+resource_path+access_token    
    headers = {format: 'json', content_type: 'json'}    
    
    res =RestClient.get(path, headers)
    res= JSON.parse(res.body)
end
def put(api_url, resource_path, load={})
    url =api_url+"/api/v2/"
    access_token="?access_token=#{@token}"   
    path = url+resource_path+access_token
    headers = {format: 'json', content_type: 'json'}

    res =RestClient.put(path, load, headers)
    res= JSON.parse(res.body)
end
#get token
@token = get_access_token(api_url: args[:api_url], username: args[:username], password: args[:password])

user_emails.each do|user_email|
  puts "Updating password for #{user_email} with new password #{password_to_set}"
  user = get(args[:api_url], "users.json/global/email/#{user_email}")
  # response = put(args[:api_url], "users.json/backoffice/#{user['id']}/password/#{password_to_set}")
  puts response
end


