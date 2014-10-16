service "supervisor" do
  action :stop
end

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
            :queue => node[app_name][:parameters][:resque_default_queue],
            :backend => "#{node[app_name][:parameters][:redis_host]}:#{node[app_name][:parameters][:redis_port]}"
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
            :user => user,
            :backend => "#{node[app_name][:parameters][:redis_host]}:#{node[app_name][:parameters][:redis_port]}"
        )
    end
end

service "supervisor" do
  action :start
end
