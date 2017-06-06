if platform?('ubuntu')
  execute 'Setup yarn package keys' do
    command "curl -sS #{node[:yarn][:source][:key]} | sudo apt-key add -"
  end

  execute 'Setup yarn package source' do
    command "echo \"#{node[:yarn][:source][:deb]}\" | sudo tee /etc/apt/sources.list.d/yarn.list"
  end

  execute 'Update apt' do
    command 'apt-get update'
  end
elsif platform?('amazon')
  execute 'Install repo' do
    command "wget #{node[:yarn][:source][:rpm]} -O /etc/yum.repos.d/yarn.repo"
  end
end

node[:yarn][:packages].each do |package_name|
  package package_name do
    action :install
  end
end
