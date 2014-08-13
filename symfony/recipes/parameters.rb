node[:deploy].each do |app_name, deploy|
    template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
        source "parameters.yml.erb"
        mode 0644
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          owner "www-data"
        elsif platform?("amazon")
          owner "apache"
        end

        variables(
            :params => {
                :parameters => node[:vblogger][:parameters].merge({
                    :database_driver => "pdo_mysql",
                    :database_host => deploy[:database][:host],
                    :database_port => deploy[:database][:port],
                    :database_name => deploy[:database][:dbname],
                    :database_user => deploy[:database][:username],
                    :database_password => deploy[:database][:password]
                })
            }.to_json
        )

        only_if do
             File.directory?("#{deploy[:deploy_to]}/current/app/config")
        end
    end
end
