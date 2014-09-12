node[:deploy].each do |app_name, deploy|
    template "/etc/supervisor/conf.d/#{app_name}.conf" do
        source "process.conf.erb"
        mode 0644
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          user = "www-data"
        elsif platform?("amazon")
          user = "apache"
        end

        variables(
            :name => app_name,
            :command => "#{deploy[:deploy_to]}/current/bin/resque",
            :number => 2,
            :user => user,
            :queue => default
        )
    end
    template "/etc/supervisor/conf.d/#{app_name}-scheduler.conf" do
        source "process.conf.erb"
        mode 0644
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          user = "www-data"
        elsif platform?("amazon")
          user = "apache"
        end

        variables(
            :name => "#{app_name}-scheduler",
            :command => "#{deploy[:deploy_to]}/current/bin/resque-scheduler",
            :number => 1,
            :user => user
        )
    end
end
