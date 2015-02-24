node[:deploy].each do |app_name, deploy|
    composer_project "#{deploy[:deploy_to]}/current" do
        group deploy[:group]
        if platform?("ubuntu")
            user "www-data"
        elsif platform?("amazon")
            user "apache"
        end
        dev true
        quiet false
        prefer_dist true
        action :install
    end
end
