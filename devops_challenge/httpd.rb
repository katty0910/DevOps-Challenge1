#
# Cookbook:: devops_challenge
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install Apache
package 'httpd' do
  action :install
end

# Manage Apache Service
service 'httpd' do
  action [ :enable, :start ]
end

root_directory = "#{node['devops_challenge']['apache_server_root_path']}"

html_path = "#{root_directory}/index.html"

# placing the index.html file on the document root of Apache server
cookbook_file html_path do
  source "index.html"
  mode "0644"
end

# Configuring the firewall to allow http and https trraffic from external machines
execute 'httpd_firewall' do
  command '/usr/bin/firewall-cmd  --permanent --zone public --add-service http'
  ignore_failure true
end

execute 'reload_firewall' do
  command '/usr/bin/firewall-cmd --reload'
  ignore_failure true
end
