node[:deploy].each do |app_name, deploy|
    directory "#{deploy[:deploy_to]}/current/app/logs" do
        action :delete
        recursive true
    end
    link "#{deploy[:deploy_to]}/current/app/logs" do
        group deploy[:group]
        if platform?("ubuntu")
            owner "www-data"
        elsif platform?("amazon")
            owner "apache"
        end
        to "#{deploy[:deploy_to]}/shared/log"
        only_if do File.directory?("#{deploy[:deploy_to]}/current/app") end
    end
end
