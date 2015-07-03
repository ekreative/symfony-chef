node[:deploy].each do |app_name, deploy|
    if node[app_name][:files].present?
        node[app_name][:files].each do |name, content|
            template "#{deploy[:deploy_to]}/current/#{name}" do
                source "content.erb"
                mode 0644
                variables(
                    :content => content
                )
            end
        end
    end
end
