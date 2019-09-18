require 'optparse'

require_relative "executor/helper.rb"

options={}
options[:browser]="chrome"
options[:env]="test03"
options[:ui]=false
options[:telnet] = false
options[:skip_api]=false
options[:remote_report]= true
options[:remote_srvr]="10.100.185.250"

OptionParser.new do |opts|
  opts.on("--env ENVIRONMENT"){|obj| options[:env]=obj}
  opts.on("--username USERNAME"){|obj| options[:username]=obj}
  opts.on("--password PASSWORD"){|obj| options[:password]=obj}
  opts.on("--release_id RELEASEID"){|obj| options[:release_id]=obj}
  opts.on("--testcycle_id TESTCYCLEID"){|obj| options[:testcycle_id]=obj}
  opts.on("--spec SPEC"){|obj| options[:spec]=obj}
  opts.on("--browser BROWSERNAME"){|obj| options[:browser]=obj}
  opts.on("--ui GUIENABLED"){|obj| options[:ui]=obj}
  opts.on("--telnet TELNET"){|obj| options[:telnet]=obj}
  opts.on("--skip_api TELNET"){|obj| options[:skip_api]=obj}
  opts.on("--remote_report RemoteREPORTINGENABLED"){|obj| options[:remote_report]=obj}
end.parse!

settings={
  env: options[:env],
  username: options[:username],
  password: options[:password],
  browser_name: options[:browser],
  ui: options[:ui],
  remote_srvr: options[:remote_srvr],
  remote_report: options[:remote_report],
  project_id: options[:project_id],
  testcycle_id: options[:testcycle_id],
  release_id: options[:release_id]
 }
spec = options[:spec]
#spec= "TS_Profiles/TC_Profile_01_spec.rb"
EXECUTOR.run_specs([spec], settings)