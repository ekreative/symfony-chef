node[:deploy].each do |app_name, deploy|
  if platform?('ubuntu')
    user = 'www-data'
  elsif platform?('amazon')
    user = 'apache'
  end

  next unless node[app_name].present?
  Dir.glob("/etc/supervisor/conf.d/#{app_name}-*.conf") do |filename|
    file filename do
      action :delete
    end
  end
  next unless node[app_name][:daemons].present?
  node[app_name][:daemons].each do |daemon|
    if daemon[:symfony].present? && !daemon[:symfony]
      cmd = (daemon[:command]).to_s
    else
      cmd = "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} --env=prod #{daemon[:command]}"
        end

    template "/etc/supervisor/conf.d/#{app_name}-#{daemon[:name]}.conf" do
      source 'process.conf.erb'
      mode 0o644
      variables(
        name: "#{app_name}-#{daemon[:name]}",
        command: cmd,
        number: daemon[:number] || 1,
        user: user,
        startretries: daemon[:startretries] || 3
      )
    end
  end
end
