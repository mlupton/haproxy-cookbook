#
# Cookbook Name:: haproxy-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum"
include_recipe "yum-epel"

package 'haproxy' do
  action :install
end

cookbook_file "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg"
  mode "0644"
end

nginxnodes = search(:node, "role:nginx")
nginxnodes.each do |node|
  Chef::Log.info("#{node["name"]} has IP address #{node["ipaddress"]}")
  bash 'extract_module' do
    user 'root'
    cwd '/root'
    code <<-EOH
      echo "   server #{node["name"]} #{node["ipaddress"]}:80 check" | tee -a /etc/haproxy/haproxy.cfg
    EOH
  end
end 

service 'haproxy' do
  action [ :enable, :start ]
end 
