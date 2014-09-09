node[:deploy].each do |app_name, deploy|
  execute "bower" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/node_modules/.bin/bower install"
  end
end
