node[:deploy].each do |app_name, deploy|
    params = {
        "database_driver" => "pdo_#{deploy[:database][:adapter]}",
        "database_host" => deploy[:database][:host],
        "database_port" => deploy[:database][:port],
        "database_name" => deploy[:database][:database],
        "database_user" => deploy[:database][:username],
        "database_password" => deploy[:database][:password],
        "memcached_host" => deploy[:memcached][:host],
        "memcached_port" => deploy[:memcached][:port]
    }
    if node[app_name].present? and node[app_name][:resque].present?
        host = node[:resque][:host]
        port = node[:resque][:port]
        if node[app_name][:resque][:redis].present?
            host = node[app_name][:resque][:redis][:host] || host
            port = node[app_name][:resque][:redis][:port] || port
        end

        params["redis_host"] = host
        params["redis_port"] = port
        params["resque_queue"] = node[app_name][:resque][:queue] || node[:resque][:queue]
        params["resque_prefix"] = node[app_name][:resque][:prefix]
    end

    template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
        source "parameters.yml.erb"
        mode 0660
        user deploy[:user]
        group deploy[:group]
        variables(
            :params => {
                :parameters => params
                    .merge((node[app_name] and node[app_name][:parameters]) || {})
            }.to_json
        )
        only_if do File.directory?("#{deploy[:deploy_to]}/current/app/config") end
    end
end
