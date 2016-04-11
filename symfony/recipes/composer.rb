node[:deploy].each do |app_name, deploy|
    composer_project "#{deploy[:deploy_to]}/current" do
        dev node[:symfony][:composer_dev]
        quiet false
        action :install
        only_if do File.exists?("#{deploy[:deploy_to]}/current/composer.json") end
    end
end
