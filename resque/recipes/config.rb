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
            :command => "#{deploy[:deploy_to]}/current/#{node[:resque][:resque_bin]}",
            :number => node[:resque][:workers],
            :user => user,
            :queue => node[app_name][:parameters][:redis_queue],
            :backend => "#{node[app_name][:parameters][:redis_host]}:#{node[app_name][:parameters][:redis_port]}"
        )
    end
    if default[:resque][:scheduler]
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
                :command => "#{deploy[:deploy_to]}/current/bin/#{node[:resque][:resque_scheduler_bin]}",
                :number => 1,
                :user => user,
                :backend => "#{node[app_name][:parameters][:redis_host]}:#{node[app_name][:parameters][:redis_port]}"
            )
        end
    end
end
