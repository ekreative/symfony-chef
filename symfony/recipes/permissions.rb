node[:deploy].each do |app_name, deploy|
  directory "#{deploy[:deploy_to]}/current/app/cache" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end
      recursive true
  end
  execute "chmod -R g+w #{deploy[:deploy_to]}/current/app/cache"
  execute "chmod -R g+w #{deploy[:deploy_to]}/shared/log"
end
