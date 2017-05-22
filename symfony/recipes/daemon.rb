node[:deploy].each do |app_name, deploy|
    if platform?("ubuntu")
        user = "www-data"
    elsif platform?("amazon")
        user = "apache"
    end

    if node[app_name].present?
        Dir.glob("/etc/supervisor/conf.d/#{app_name}-*.conf") { |filename|
            file filename do
                action :delete
            end
        }
        if node[app_name][:daemons].present?
            node[app_name][:daemons].each do |daemon|
                if daemon[:symfony].present? and !daemon[:symfony]
                    cmd = "#{daemon[:command]}"
                else
                    cmd = "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} #{daemon[:command]} --env=prod"
                end

                template "/etc/supervisor/conf.d/#{app_name}-#{daemon[:name]}.conf" do
                    source "process.conf.erb"
                    mode 0644
                    variables(
                        :name => "#{app_name}-#{daemon[:name]}",
                        :command => cmd,
                        :number => daemon[:number] || 1,
                        :user => user,
                        :startretries => daemon[:startretries] || 3
                    )
                end
            end
        end
    end
end
