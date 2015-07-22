node[:deploy].each do |app_name, deploy|
    composer_project "#{deploy[:deploy_to]}/current" do
        dev true
        quiet false
        prefer_source true
        action :install
        only_if do File.exists?("#{deploy[:deploy_to]}/current/composer.json") end
    end
end
