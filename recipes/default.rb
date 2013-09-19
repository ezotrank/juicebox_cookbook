#
# Cookbook Name:: juicebox
# Recipe:: default
#
# Copyright 2013, Go Travel Ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java::openjdk'
include_recipe 'monit'

directory node['juicebox']['install_dir'] do
  owner node['juicebox']['user']
  group node['juicebox']['user']
  mode 0755
  action :create
end

remote_file "#{node['juicebox']['install_dir']}/juicebox-#{node['juicebox']['package']['version']}.war" do
  owner node['juicebox']['user']
  group node['juicebox']['user']
  source node['juicebox']['package']['url']
  checksum node['juicebox']['package']['checksum']
  action :create_if_missing
end

# monitrc 'juicebox_monit' do
#   template_cookbook 'juicebox'
#   variables 'pid' => File.join(node['juicebox']['install_dir'], 'juicebox.pid'),
#   'juicebox_war' => "#{node['juicebox']['install_dir']}/juicebox-#{node['juicebox']['package']['version']}.war",
#   'user' => node['juicebox']['user'],
#   'install_dir' => node['juicebox']['install_dir'],
#   'port' => node['juicebox']['port']
# end