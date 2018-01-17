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
  home node[:web_server][:user]
  shell '/bin/bash'
  manage_home true
  gid node[:web_server][:group]
  system true
  action :create
end

package 'Install nginx' do
  case node[:platform]
  when 'ubuntu', 'debian'
    package_name 'nginx'
  end
end
