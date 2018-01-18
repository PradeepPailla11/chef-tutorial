# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "pradeep"
client_key               "#{current_dir}/pradeep.pem"
chef_server_url          "https://vnsingh10102.mylabserver.com/organizations/pradeephome"
cookbook_path            ["#{current_dir}/../cookbooks"]
