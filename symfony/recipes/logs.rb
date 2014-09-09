node[:deploy].each do |app_name, deploy|
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
