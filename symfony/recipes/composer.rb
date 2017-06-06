node[:deploy].each do |_app_name, deploy|
  composer_project "#{deploy[:deploy_to]}/current" do
    dev node[:symfony][:composer_dev]
    quiet false
    action :install
    optimize_autoloader node[:symfony][:composer_optimize_autoloader]
    only_if { File.exist?("#{deploy[:deploy_to]}/current/composer.json") }
  end
end
