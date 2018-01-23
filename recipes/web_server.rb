apt_update 'apt update' do
  action :periodic
end

package 'git-core'
package 'curl'
package 'zlib1g-dev'
package 'build-essential'
package 'libssl-dev'
package 'libreadline-dev'
package 'libyaml-dev'
package 'libxml2-dev'
package 'libxslt1-dev'
package 'libcurl4-openssl-dev'
package 'python-software-properties'
package 'libffi-dev'
package 'nodejs'

group node[:web_server][:group] do
  action :create
end

user node[:web_server][:user] do
  home "/home/#{node[:web_server][:user]}"
  shell '/bin/bash'
  manage_home true
  gid node[:web_server][:group]
  system true
  action :create
end

directory "/home/#{node[:web_server][:user]}" do
  owner node[:web_server][:user]
  group node[:web_server][:group]
  mode '0755'
  action :create
end

user node[:web_server][:user] do
  home "/home/#{node[:web_server][:user]}"
  shell '/bin/bash'
  manage_home true
  gid node[:web_server][:group]
  system true
  action :create
end

remote_file "/home/#{node[:web_server][:user]}/ruby.tar.gz" do
  source 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz'
  owner node[:web_server][:user]
  group node[:web_server][:group]
  mode '0755'
  action :create
end

execute 'extract ruby source' do
  command "tar xvfz /home/#{node[:web_server][:user]}/ruby.tar.gz"
  cwd "/home/#{node[:web_server][:user]}/"
end

execute 'compile ruby' do
  command "sh configure && make && make install"
  cwd "/home/#{node[:web_server][:user]}/ruby-2.5.0"
end

execute 'gem install passenger' do
  command "gem install passenger"
end

execute 'passenger-install-nginx-module' do
  command "passenger-install-nginx-module –auto"
end
