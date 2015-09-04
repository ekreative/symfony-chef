node[:deploy].each do |app_name, deploy|
    execute "bower" do
        cwd "#{deploy[:deploy_to]}/current"
        command "#{deploy[:deploy_to]}/current/#{node[:node][:bower_bin]} install"
        environment "HOME" => "#{deploy[:deploy_to]}/current"
        user deploy[:user]
        group deploy[:group]
        only_if do File.exists?("#{deploy[:deploy_to]}/current/bower.json") end
    end
end
