node[:deploy].each do |app_name, deploy|
    template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
        source "parameters.yml.erb"
        mode 0644
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          owner "www-data"
        elsif platform?("amazon")
          owner "apache"
        end

        variables(
            :params => {
                :parameters => {
                }.merge(node[app_name][:parameters])
            }.to_json
        )

        only_if do
             File.directory?("#{deploy[:deploy_to]}/current/app/config")
        end
    end
end
