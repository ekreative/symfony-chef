node[:deploy].each do |app_name, deploy|
    execute "assetic" do
        cwd "#{deploy[:deploy_to]}/current"
        command "#{deploy[:deploy_to]}/current/#{node[:symfony][:console]} assetic:dump --env=prod"
        returns [0, 1]
        only_if do File.exists?("#{deploy[:deploy_to]}/current/#{node[:symfony][:console]}") end
    end
end
