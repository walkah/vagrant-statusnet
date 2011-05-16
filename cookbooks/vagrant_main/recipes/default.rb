require_recipe "apt"
require_recipe "memcached"
require_recipe "java::openjdk"
require_recipe "activemq"
require_recipe "mysql::server"
require_recipe "php::package"
require_recipe "php::module_apc"
require_recipe "php::module_curl"
require_recipe "php::module_gd"
require_recipe "php::module_mysql"
require_recipe "php::module_memcache"
require_recipe "apache2"
require_recipe "apache2::mod_php5"

%w{ pwgen php5-gmp }.each do |a_package|
  package a_package
end

directory "/etc/statusnet" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# setup.cfg
template "/etc/statusnet/setup.cfg" do
  source "setup.cfg.erb"
  mode "0644"
  owner "root"
  group "root"
end

# statusnet.php
template "/etc/statusnet/statusnet.php" do
  source "statusnet.php.erb"
  mode "0644"
  owner "root"
  group "root"
end

web_app node[:host] do
  server_name node[:host]
  server_aliases ["*.#{node[:host]}"]
  docroot "/vagrant/public/statusnet"
end
