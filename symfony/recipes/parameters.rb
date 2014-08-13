node[:deploy].each do |app_name, deploy|
    template "#{deploy[:deploy_to]}/current/config/parameters.yml" do
        source "parameters.yml"
        mode 0644
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          owner "www-data"
        elsif platform?("amazon")
          owner "apache"
        end

        variables(
            :params => node[:vblogger].to_json
        )

        only_if do
             File.directory?("#{deploy[:deploy_to]}/current/config")
        end
    end
end
