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

service 'haproxy' do
  action [ :enable, :start ]
end 
