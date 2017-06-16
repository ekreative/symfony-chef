node[:deploy].each do |_app_name, deploy|
  execute 'schema' do
    group deploy[:group]
    if platform?('ubuntu')
      user 'www-data'
    elsif platform?('amazon')
      user 'apache'
    end

    cwd "#{deploy[:deploy_to]}/current"
    command "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} doctrine:schema:update --dump-sql --force"
    only_if { File.exist?("#{deploy[:deploy_to]}/current/#{node[:symfony][:console]}") }
  end
end
