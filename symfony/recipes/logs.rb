node[:deploy].each do |app_name, deploy|
    directory "#{deploy[:deploy_to]}/current/var/logs" do
        action :delete
    end
    link "#{deploy[:deploy_to]}/current/var/logs" do
        group deploy[:group]
        if platform?("ubuntu")
            owner "www-data"
        elsif platform?("amazon")
            owner "apache"
        end
        to "#{deploy[:deploy_to]}/shared/log"
    end
end
