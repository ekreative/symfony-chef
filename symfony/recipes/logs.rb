node[:deploy].each do |_app_name, deploy|
  directory "#{deploy[:deploy_to]}/current/#{node[:symfony][:logs]}" do
    action :delete
    recursive true
  end
  link "#{deploy[:deploy_to]}/current/#{node[:symfony][:logs]}" do
    group deploy[:group]
    if platform?('ubuntu')
      owner 'www-data'
    elsif platform?('amazon')
      owner 'apache'
    end
    to "#{deploy[:deploy_to]}/shared/log"
    only_if { File.directory?("#{deploy[:deploy_to]}/current/app") }
  end
end
