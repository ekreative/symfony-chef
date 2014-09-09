node[:deploy].each do |app_name, deploy|
  directory "#{deploy[:deploy_to]}/current/var/cache" do
      action :delete
      recursive true
  end
  execute "cache" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/bin/console cache:clear --env=prod"
  end
end
