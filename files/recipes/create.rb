node[:deploy].each do |app_name, deploy|
  next unless node[app_name].present? && node[app_name][:files].present?
  node[app_name][:files].each do |name, content|
    file_name = if name[0] == '/'
                  name
                else
                  "#{deploy[:deploy_to]}/current/#{name}"
                end
    template file_name do
      source 'content.erb'
      mode 0o660
      owner deploy[:user]
      group deploy[:group]
      variables(
        content: content
      )
    end
  end
end
