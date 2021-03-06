# make sure we have java installed

user 'user'
require 'json'

Current_Hostname = node["hostname"]
instances_hash = ""

ruby_block "ReadPorts" do
	block do
#		jsonfile = File.read("/home/user/chef-repo/cookbooks/pradeep_tomcat/templates/test.json")
		jsonfile = File.read("/home/user/test.json")
		instances_hash = JSON.parse(jsonfile)
	end
	action :run
end

# Install Tomcat 8.0.47 to the default location
tomcat_install 'helloworld' do
  dir_mode '0755'
  tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
  tomcat_user 'user'
  tomcat_group 'user'
end

ruby_block "FileCopy" do
	block do 
		def findAndReplace(current_string, replacement_string, location)
			location_path = location + "**/*"
			Dir.glob(location_path) do |file_name|
				if File.file?(file_name)
				text = File.read(file_name)
				if text.valid_encoding?
					text.gsub!(current_string, replacement_string)
					File.open(file_name, "w") { |file| file.puts text }
					end
				end
			end
		end
		adminport = instances_hash["AdminPort"]
		findAndReplace('8080',"#{adminport}",'/opt/tomcat_helloworld/conf/')
	end
end

remote_file '/opt/tomcat_helloworld/webapps/sample.war' do
  owner 'user'
  mode '0755'
  source 'https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war'
  checksum '89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5'
end

# start the helloworld tomcat service using a non-standard pic location
tomcat_service 'helloworld' do
  action [:start, :enable]
  env_vars [{ 'CATALINA_BASE' => '/opt/tomcat_helloworld/' }, { 'CATALINA_PID' => '/opt/tomcat_helloworld/bin/non_standard_location.pid' }, { 'SOMETHING' => 'some_value' }]
  sensitive true
  tomcat_user 'user'
  tomcat_group 'user'
end

tomcat_service 'helloworld' do
 action :restart
end
