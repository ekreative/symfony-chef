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
    if node[app_name][:resque].present? and node[app_name][:resque][:redis].present?
        params["redis_host"] = node[app_name][:resque][:redis][:host]
        params["redis_port"] = node[app_name][:resque][:redis][:port]
        params["redis_queue"] = node[app_name][:resque][:queue]
    end

    template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
        source "parameters.yml.erb"
        mode 0644
        variables(
            :params => {
                :parameters => params
                    .merge(redis)
                    .merge((node[app_name] and node[app_name][:parameters]) || {})
            }.to_json
        )
        only_if do
             File.directory?("#{deploy[:deploy_to]}/current/app/config")
        end
    end
end
