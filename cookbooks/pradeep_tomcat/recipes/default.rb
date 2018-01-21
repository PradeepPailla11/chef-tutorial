#
# Cookbook:: pradeep_tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'

include_recipe 'pradeep_tomcat::tomcat_install'
