node[:deploy].each do |app_name, deploy|
    link "#{deploy[:deploy_to]}/current/var/cache" do
        group deploy[:group]
        if platform?("ubuntu")
            owner "www-data"
        elsif platform?("amazon")
            owner "apache"
        end
        to "#{deploy[:deploy_to]}/current/app/cache"
    end
    link "#{deploy[:deploy_to]}/current/bin/console" do
        group deploy[:group]
        if platform?("ubuntu")
            owner "www-data"
        elsif platform?("amazon")
            owner "apache"
        end
        to "#{deploy[:deploy_to]}/current/app/console"
    end
    link "#{deploy[:deploy_to]}/current/var/logs" do
        group deploy[:group]
        if platform?("ubuntu")
            owner "www-data"
        elsif platform?("amazon")
            owner "apache"
        end
        to "#{deploy[:deploy_to]}/current/app/logs"
    end
end
