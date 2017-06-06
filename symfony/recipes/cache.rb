node[:deploy].each do |_app_name, deploy|
  directory "#{deploy[:deploy_to]}/current/#{node[:symfony][:cache]}" do
    action :delete
    recursive true
  end
  directory "#{deploy[:deploy_to]}/current/#{node[:symfony][:cache]}" do
    group deploy[:group]
    if platform?('ubuntu')
      user 'www-data'
    elsif platform?('amazon')
      user 'apache'
    end
    recursive true
  end
  execute 'cache_clear' do
    group deploy[:group]
    if platform?('ubuntu')
      user 'www-data'
    elsif platform?('amazon')
      user 'apache'
    end

    cwd "#{deploy[:deploy_to]}/current"
    command "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} cache:clear --no-warmup --env=prod"
    only_if { File.exist?("#{deploy[:deploy_to]}/current/#{node[:symfony][:console]}") }
  end
  execute 'cache_warmup' do
    group deploy[:group]
    if platform?('ubuntu')
      user 'www-data'
    elsif platform?('amazon')
      user 'apache'
    end

    cwd "#{deploy[:deploy_to]}/current"
    command "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} cache:warmup --env=prod"
    only_if { File.exist?("#{deploy[:deploy_to]}/current/#{node[:symfony][:console]}") }
  end
end
