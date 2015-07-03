node[:deploy].each do |app_name, deploy|
    execute "npm" do
        cwd "#{deploy[:deploy_to]}/current"
        command "npm install"
        environment "HOME" => "#{deploy[:deploy_to]}/current"
        user deploy[:user]
        group deploy[:group]
        only_if do File.exists?("#{deploy[:deploy_to]}/current/package.json") end
    end
end
