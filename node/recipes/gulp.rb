node[:deploy].each do |app_name, deploy|
  execute "gulp" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/node_modules/.bin/gulp"
  end
end
