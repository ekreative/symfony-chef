node[:deploy].each do |app_name, deploy|
    if node[app_name].present? and node[app_name][:resque].present?
        if platform?("ubuntu")
            user = "www-data"
        elsif platform?("amazon")
            user = "apache"
        end

        host = node[:resque][:host]
        port = node[:resque][:port]
        if node[app_name][:resque][:redis].present?
            host = node[app_name][:resque][:redis][:host] || host
            port = node[app_name][:resque][:redis][:port] || port
        end

        resque_env = {
            'REDIS_BACKEND' => "#{host}:#{port}",
            'INTERVAL' => node[app_name][:resque][:interval] || node[:resque][:interval],
            'QUEUE' => node[app_name][:resque][:queue] || node[:resque][:queue],
            'PREFIX' => node[app_name][:resque][:prefix],
            'BLOCKING' => node[app_name][:resque][:blocking] || node[:resque][:blocking]
        }

        if (node[:resque][:verbose])
            resque_env['VVERBOSE'] = '1'
        end

        app_include = node[app_name][:resque][:app_include] || node[:resque][:app_include]
        if app_include
            resque_env['APP_INCLUDE'] = "#{deploy[:deploy_to]}/current/#{app_include}"
        end

        template "/etc/supervisor/conf.d/#{app_name}.conf" do
            source "process.conf.erb"
            mode 0644
            variables(
                :name => app_name,
                :command => "#{deploy[:deploy_to]}/current/#{node[app_name][:resque][:bin] || node[:resque][:resque_bin]}",
                :number => node[app_name][:resque][:workers] || node[:resque][:workers],
                :user => user,
                :env => resque_env
            )
        end

        resque_scheduler_env = {
            'REDIS_BACKEND' => "#{host}:#{port}",
            'INTERVAL' => node[app_name][:resque][:interval_scheduler] || node[:resque][:interval_scheduler],
            'PREFIX' => node[app_name][:resque][:prefix]
        }

        if (node[:resque][:verbose])
            resque_scheduler_env['VVERBOSE'] = '1'
        end

        if node[app_name][:resque][:scheduler]
            template "/etc/supervisor/conf.d/#{app_name}-scheduler.conf" do
                source "process.conf.erb"
                mode 0644
                variables(
                    :name => "#{app_name}-scheduler",
                    :command => "#{deploy[:deploy_to]}/current/#{node[app_name][:resque][:scheduler_bin] || node[:resque][:resque_scheduler_bin]}",
                    :number => 1,
                    :user => user,
                    :env => resque_scheduler_env
                )
            end
        end
    end
end
