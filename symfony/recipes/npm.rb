node[:deploy].each do |app_name, deploy|
  directory "/root/.npm" do
      action :delete
      recursive true
  end
  execute "npm" do
      group deploy[:group]
      if platform?("ubuntu")
          user "www-data"
      elsif platform?("amazon")
          user "apache"
      end

      cwd "#{deploy[:deploy_to]}/current"
      command "npm install"
      environment "HOME" => "#{deploy[:deploy_to]}/current"
  end
end
