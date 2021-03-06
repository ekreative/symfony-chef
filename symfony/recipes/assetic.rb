node[:deploy].each do |_app_name, deploy|
  execute 'assetic' do
    cwd "#{deploy[:deploy_to]}/current"
    command "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} assetic:dump --env=prod"
    returns [0, 1]
    group deploy[:group]
    if platform?('ubuntu')
      user 'www-data'
    elsif platform?('amazon')
      user 'apache'
    end
    only_if { File.exist?("#{deploy[:deploy_to]}/current/#{node[:symfony][:console]}") }
  end
end
