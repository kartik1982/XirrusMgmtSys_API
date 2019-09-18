require 'rspec'
require 'watir'

require_relative "report_status_formatter.rb"

module EXECUTOR
  def self.gem_root
    File.expand_path File.dirname(__FILE__).gsub("/executor","")
  end

  def self.spec_root
    "#{self.gem_root}/spec"
  end
  def self.run_spec(command)
    RSpec::Core::Runner.run(command)
  end
  def self.run_specs(specs, args={})
    $test_count=0
    $pass_count =0
    $fail_count=0
    $pending_count=0
    project_id = args[:project_id] || gem_root.split('/').last
    testcycle_id = args[:testcycle_id]
    release_id = args[:release_id] || "0.0.0"
    build_id=  args[:build_id] || "0000-0000"
    env= args[:env] || "test03"
    #will try to get from argument where job get trigger
    if testcycle_id == "Development"
     env == "test03"
    elsif testcycle_id =="Regression"
      env = "test01"
    end
    username = args[:username] || DEFAULT_USER
    password = args[:password] || DEFAULT_PASSWORD
    browser_name = args[:browser_name] || BROWSER_NAME
    download = args[:download] ||  Dir.home+"/Downloads" #DEFAULT_DOWNLOAD
    rspec_out = args[:rspec_out] || Dir.home+"/reports/" #RSPEC_OUT
    remote_srvr = args[:remote_srvr]
    remote_report = args[:remote_report]
    skip_api = args[:skip_api] || false
    array = args[:array]
    array_serial= args[:array_serial]
    telnet= args[:telnet]
    ui = args[:ui]
    self.spec_helper({
      env: env,
      ui: ui,
      username: username,
      password: password,
      project_id: project_id,
      release_id: release_id,
      testcycle_id: testcycle_id,
      download: download,
      array: array,
      array_serial: array_serial,
      telnet: telnet,
      skip_api: skip_api
      
    })
    
    specs.each do |spec|
      start_time= Time.now #.strftime("%Y-%m-%d %H:%M:%S")
      testsuite_id = spec.split('/').first
      testcase_id = spec.split('/').last.gsub(".rb","")
      if spec.split('/').count > 2
        child_section = spec.split('/')[1]
      else
        child_section=nil
      end
      
      date= Time.now.strftime('%m/%d/%Y')
      time= Time.now.strftime('%H-%M')
      date_path = date.gsub('/', '-')
      time_path = time.gsub('/', '-')
      #Rspec.Config
      RSpec.configuration.spec_settings[:date_path] = date_path
      RSpec.configuration.spec_settings[:time_path] = time_path

      save_folder = "#{rspec_out}/"
      section= spec.gsub('_spec.rb', '').gsub('.rb', '')
      out_file_base = "#{save_folder}#{release_id}/#{testcycle_id}/#{project_id}/#{section}" #{date_path}/
      #      out_file_base << "_#{browser_name}"
      out_path = args[:out_path] || "#{out_file_base}.html"
      #Rspec.config
      RSpec.configuration.spec_settings[:log_file] = "#{out_file_base}.txt"
      RSpec.configuration.spec_settings[:out_path] = out_path.gsub('.html','')
      # RSpec.configuration.spec_settings[:out_link] = "http://"+remote_srvr+out_path.gsub("#{rspec_out}",'')
      command = ["#{self.spec_root}/#{spec}",  "--format", "documentation", "--format","html", "--out",out_path ]
      # execute spec
      run_spec(command)
      ###############################################################################################################
      if remote_report == "false"
        remote_report = false
      end
      if remote_report
        #post result into server using APIs
        token = get_token_by_email_password('kartik.aiyar@riverbed.com','Kartik@123')
        #report params
        report_params={
         release_name: release_id,
         testcycle_name: testcycle_id,
         project_name: project_id,
         build: $build_id,
         testsuite_name: testsuite_id,
         testcase_name: testcase_id,
         testuser: username,
         testpassword: password,
         testpath: spec,
         pass: $pass_count,
         fail: $fail_count,
         pending: $pending_count,
         log_path: "http://"+remote_srvr+out_path.gsub("#{rspec_out}",''),
         start_at: start_time,
         end_at: Time.now, #.strftime("%Y-%m-%d %H:%M:%S")
         duration: Time.now-start_time,
         browser: browser_name,
         array_serial: array_serial || "none",
         os: "any"
        }
        puts "EXECUTION PARAMETERS:- #{report_params}"
        RestClient.post "http://10.100.185.250:3000/api/v1/reports", report_params.to_json, {Authorization: "Bearer #{token}", content_type: :json, accept: :json}
        ###############################################################################################################      
        #move all log files to remote location
        if child_section
          local_path="#{rspec_out}#{release_id}/#{testcycle_id}/#{project_id}/#{testsuite_id}/#{child_section}"
          remote_path="./Results/#{release_id}/#{testcycle_id}/#{project_id}/#{testsuite_id}/#{child_section}"
        else
          local_path="#{rspec_out}#{release_id}/#{testcycle_id}/#{project_id}/#{testsuite_id}"
          remote_path="./Results/#{release_id}/#{testcycle_id}/#{project_id}/#{testsuite_id}"
        end
        move_log_file_to_remote_server(remote_srvr,local_path, remote_path, testcase_id )
        ###############################################################################################################
      end #remote_report 
    end #each spec   
  end #run_specs
  def self.spec_helper(settings={})
    spec_settings = settings || {}
    RSpec.configuration.add_setting :spec_settings
    RSpec.configuration.spec_settings = spec_settings
    RSpec.configuration.add_formatter 'progress'
    RSpec.configuration.add_formatter ReportStatusFormatter
    
    RSpec.configure do | config |
      #BEFORE ALL TESTCASES
      config.before :all do
        puts "In the beginning..."
           @env = spec_settings[:env]
           @build_id = spec_settings[:build_id]
           puts "Enviornment: #{@env}"
           @xms_url = "https://xcs-#{@env}.cloud.xirrus.com"
           @login_url = "https://login-#{@env}.cloud.xirrus.com"
           puts "LOGIN_URL: #{@login_url}"
           @username = spec_settings[:username]
           @password = spec_settings[:password]
           @download = spec_settings[:download] || DEFAULT_DOWNLOAD
           puts "DOWNLOAD DIR: #{@download}"
           puts "current user , #{@username}"
           @settings = spec_settings
           @date_path = spec_settings[:date_path]
           @time_path = spec_settings[:time_path] || "#{Time.now.strftime('%H-%M')}"
           @timestamp = spec_settings[:timestamp] || Time.now.strftime("%D-%H-%M").gsub('/','-')
           @log_file = RSpec.configuration.spec_settings[:log_file]
           @no_log = spec_settings[:no_log]

           @each_sleep = 3
           array = spec_settings[:array]
           array_serial = spec_settings[:array_serial]
           telnet= spec_settings[:telnet]          
           
          #################################
          # Check for instance of an XMS::Array in settings
          # Create instance of XMS::Array @array if :array_serial flag passed in
          if(array && array.respond_to?(:ng_format))
            @array = array
          else
            unless array_serial.nil?
            ###
            # TODO add alternate way to create array - from backoffice json
            # XMS::Array - needs backoffice_json_to_attributes method and/or add
              if File.exist? "#{EXECUTOR.fixtures_root}/json/#{array_serial}.json"
                @array = EXECUTOR::Array.new(json_file: "#{EXECUTOR.fixtures_root}/json/#{array_serial}.json")
              else
                @array = EXECUTOR::Array.new(serial: array_serial)
              end
            end
          end
          @use_telnet = telnet
          puts "TELNET: #{telnet}"
          # XMS::Array instance created, setup here
          if @array
            if (telnet == true)
              @array.get_ready_for_cloud_test({env: @env})
            else
            end
          end
           ##################################
           unless @no_log
             puts "LOG FILE: #{@log_file}"
             File.open(@log_file,'w'){|f| f.write("\n-------------- Logging RSpec -------------\n  Timestamp: #{@timestamp} \n #{spec_settings[:array_serial]} - #{spec_settings[:browser_name]} \n")}
           end
           puts "SKIP API: #{spec_settings[:skip_api]}"
           if (spec_settings[:skip_api] != true)
              @api = api
            else
              @login_url = @xms_url
           end
           puts "UI: #{spec_settings[:ui]}"
           @browser_name = spec_settings[:browser_name] || BROWSER_NAME
           unless (spec_settings[:ui] == false || spec_settings[:ui] == "false")             
             @browser = Watir::Browser.new @browser_name.to_sym
             @session_id = @browser.driver.instance_variable_get("@bridge").session_id
             puts "BROWSER SESSION ID : #{@session_id}"
             @browser.driver.manage.window.maximize

             @ui = GUI::UI.new(args = {browser: @browser})
             @ui.login(@login_url, @username, @password)
             sleep 2
             @ui.main_container.wait_until(&:present?)
             i = 0
             while !@ui.user_name_dropdown.present?
                sleep 0.5
                i+=1
                if i == 50
                   @browser.refresh
                elsif i == 100
                   break
                end
              end
              @ui.id("header_logo").wait_until(&:present?)
              @build_id=current_version_number.split('-')[1]+"-"+current_version_number.split('-').last
              puts("CURRENT BUILD FOR THE APPLICATION: #{current_version_number}")
              puts("USER ACCOUNT: #{@username}")
              puts("_________________________________________________________________________________")
              if @ui.toast_dialog.present?
                 @ui.toast_dialog_ok_button.click
                 @ui.toast_dialog.wait_while_present
                 #sleep 4
              end
              sleep 2
              if @ui.easypass_upgrade_modal.present?
                 sleep 1
                 @ui.easypass_upgrade_modal_close_button.click
                 @ui.easypass_upgrade_modal.wait_while_present
               end
             sleep 3
           end #Unless NO UI
      end #Before all
      #BEFORE EACH TESTCASE
      config.before :each do |example|
        puts ("Example Description --> #{example.description} - #{Time.now}")
        unless (spec_settings[:ui] == false || spec_settings[:ui] == "false")          
          if @ui.toast_dialog.present?
             @ui.toast_dialog_ok_button.click
             @ui.toast_dialog.wait_while_present
             sleep 2
          end
        end #no UI
      end #Before each
      #AFTER EACH TESTCASE
      config.after :each do |example|
        unless (settings[:ui] == false || settings[:ui] == "false")
          if @ui.error_dialog.present?
            puts "Error Dialog Present"
            log("--- FAILED - Error Dialog Present ---")
            # @browser.screenshot
            if @ui.error_dialog.text != "A maximum of 64 whitelist items can be added to the guest portal"
              if @ui.error_title != "Error"
                if  @ui.error_dialog_close.present?
                  log("--- STILL FAILED --- but closed the ERROR DIALOG ---")
                  @ui.error_dialog_close.click
                end
                if @ui.error_title == "500 Server Error"
                  expect(@ui.error_title).not_to eq("500 Server Error")
                end
              end
            end
          end
        end # no ui
        sleep 4
      end #After each testcase
      #AFTER ALL TESTCASES
      config.after :all do  
        unless (spec_settings[:ui] == false || spec_settings[:ui] == "false")
           unless @browser.nil?
             @browser.quit
           end
        end # no ui
      end #After all testcases
    end
  end #spec_helper
end