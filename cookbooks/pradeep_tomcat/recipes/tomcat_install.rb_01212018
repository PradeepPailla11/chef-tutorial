# make sure we have java installed

user 'user'


# Install Tomcat 8.0.47 to the default location
tomcat_install 'helloworld' do
  dir_mode '0755'
  tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
  tomcat_user 'user'
  tomcat_group 'user'
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
