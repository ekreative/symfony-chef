node[:deploy].each do |app_name, deploy|
  if platform?('ubuntu')
    user = 'www-data'
  elsif platform?('amazon')
    user = 'apache'
  end

  next unless node[app_name].present? && node[app_name][:crons].present?
  node[app_name][:crons].each do |cron|
    cmd = if cron[:symfony].present? && !cron[:symfony]
            "#{cron[:command]} >> #{deploy[:deploy_to]}/shared/log/cron.log"
          else
            "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} #{cron[:command]} --env=prod -vv >> #{deploy[:deploy_to]}/shared/log/cron.log"
          end

    cron "symfony-#{cron[:name] || cron[:command]}" do
      minute cron[:minute] || '*'
      hour cron[:hour] || '*'
      day cron[:day] || '*'
      month cron[:month] || '*'
      weekday cron[:weekday] || '*'
      command cmd
      user user
    end
  end
end
