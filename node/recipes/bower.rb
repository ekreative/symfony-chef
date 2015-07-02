node[:deploy].each do |app_name, deploy|
  execute "bower" do
      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/node_modules/.bin/bower install"
      environment "HOME" => "#{deploy[:deploy_to]}/current"
  end
end
