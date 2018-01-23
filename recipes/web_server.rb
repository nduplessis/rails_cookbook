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
package 'apache2'
package 'dirmngr'
package 'gnupg'

# group node[:web_server][:group] do
#   action :create
# end
#
# user node[:web_server][:user] do
#   home "/home/#{node[:web_server][:user]}"
#   shell '/bin/bash'
#   manage_home true
#   gid node[:web_server][:group]
#   system true
#   action :create
# end
#
# directory "/home/#{node[:web_server][:user]}" do
#   owner node[:web_server][:user]
#   group node[:web_server][:group]
#   mode '0755'
#   action :create
# end
#
# user node[:web_server][:user] do
#   home "/home/#{node[:web_server][:user]}"
#   shell '/bin/bash'
#   manage_home true
#   gid node[:web_server][:group]
#   system true
#   action :create
# end

remote_file "/tmp/ruby.tar.gz" do
  source 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz'
  # owner node[:web_server][:user]
  # group node[:web_server][:group]
  mode '0755'
  action :create
end

execute 'extract ruby source' do
  command "tar xvfz /tmp/ruby.tar.gz"
  cwd "/tmp"
end

execute 'compile ruby' do
  command "sh configure && make && make install"
  cwd "/tmp/ruby-2.5.0"
end

execute 'gem install passenger' do
  command "gem install passenger"
end

execute 'gem install passenger' do
  command "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7"
end

execute 'gem install passenger' do
  command "apt-get install -y apt-transport-https ca-certificates"
end

execute 'gem install passenger' do
  command "sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'"
end

execute 'gem install passenger' do
  command "apt-get install -y libapache2-mod-passenger"
end

#
# execute 'passenger-install-nginx-module' do
#   command "passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx"
# end
#
# template '/etc/init/nginx.conf' do
#   source 'nginx_service.erb'
#   owner 'root'
#   group 'root'
#   mode '0755'
# end
