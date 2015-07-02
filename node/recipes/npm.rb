node[:deploy].each do |app_name, deploy|
  execute "npm" do
      cwd "#{deploy[:deploy_to]}/current"
      command "npm install"
      environment "HOME" => "#{deploy[:deploy_to]}/current"
  end
end
