node[:deploy].each do |app_name, deploy|
  execute "assetic" do
      cwd "#{deploy[:deploy_to]}/current"
      command "#{deploy[:deploy_to]}/current/app/console assetic:dump --env=prod"
  end
end
