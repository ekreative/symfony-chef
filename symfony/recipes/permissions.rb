node[:deploy].each do |app_name, deploy|
  execute "chmod -R g+w #{deploy[:deploy_to]}/shared/log"
  node[:symfony][:writable].each do |dir|
      directory "#{deploy[:deploy_to]}/current/#{dir}" do
          group deploy[:group]
          if platform?("ubuntu")
              user "www-data"
          elsif platform?("amazon")
              user "apache"
          end
          recursive true
      end
      execute "chmod -R g+w #{deploy[:deploy_to]}/current/#{dir}"
  end
end
