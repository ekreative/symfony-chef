include_recipe "composer::composer_project"

node[:deploy].each do |app_name, deploy|
    composer_project "#{deploy[:deploy_to]}/current" do
        dev false
        quiet true
        optimize_autoloader true
        action :install
    end
end
