node[:deploy].each do |app_name, deploy|
    execute "yarn" do
        cwd "#{deploy[:deploy_to]}/current"
        command "yarn"
        environment "HOME" => "#{deploy[:deploy_to]}/current"
        user deploy[:user]
        group deploy[:group]
        only_if do File.exists?("#{deploy[:deploy_to]}/current/package.json") end
    end
end
