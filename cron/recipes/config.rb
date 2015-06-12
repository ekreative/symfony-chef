node[:deploy].each do |app_name, deploy|
    if platform?("ubuntu")
        user = "www-data"
    elsif platform?("amazon")
        user = "apache"
    end

    cron "kidslox:mdm:waiting" do
        command "#{deploy[:deploy_to]}/current/app/console kidslox:mdm:waiting --env=prod -vv >> #{deploy[:deploy_to]}/shared/log/cron.log"
        user user
    end

    cron "kidslox:mdm:feedback" do
      minute '0'
      hour '*/6'
      command "#{deploy[:deploy_to]}/current/app/console kidslox:mdm:feedback --env=prod -vv >> #{deploy[:deploy_to]}/shared/log/cron.log"
      user user
    end
end
