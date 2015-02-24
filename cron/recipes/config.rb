node[:deploy].each do |app_name, deploy|
    if platform?("ubuntu")
        user = "www-data"
    elsif platform?("amazon")
        user = "apache"
    end

    cron "sqs-tasks" do
        command "#{deploy[:deploy_to]}/current/app/console pusher >> #{deploy[:deploy_to]}/shared/log/cron.log"
        user user
    end
end
