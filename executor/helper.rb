require 'pathname'
require 'net/ssh'
require 'net/scp'

require_relative "spec_runner.rb"
require_relative "../api/api_client/api_client.rb"

pn = Pathname.new("#{ENV['HOME']}/.xirrus-auto")
if pn.exist?
  load "#{pn}"
else
  puts "please save your default config settings at #{ENV['HOME']}/.xirrus-auto \n"
  puts "copy the dot_xirrus-auto_example file to ~/.xirrus-auto and modify for your settings\n"
end

def api
  API::ApiClient.new(args={username: @username, password: @password, host: @login_url})
end

def get_token_by_email_password(email, password)
  begin
    path="http://10.100.185.250:3000/api/v1/login"
    response = RestClient.post path, {email: "#{email}", password: "#{password}"}.to_json, {content_type: :json, accept: :json}
    response_json = JSON.parse(response, :symbolize_names => true)
    token =  response_json[:token] 
    return token
  rescue
    puts "#{value} NOT FOUND IN DATABASE"
  end
end
def move_log_file_to_remote_server(server_addr, local_path, remote_path, testcase_name)
    begin
        Net::SSH.start(server_addr, "xirrus", password: "Xirrus!23") do |ssh|
        ssh.exec!("mkdir -p #{remote_path}")
        ssh.scp.upload! "#{local_path}/#{testcase_name}.html", "#{remote_path}/#{testcase_name}.html"
        ssh.scp.upload! "#{local_path}/#{testcase_name}.txt", "#{remote_path}/#{testcase_name}.txt"
       end
    rescue
      puts "something wrong with file transfer"
    end
  end