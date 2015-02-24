node[:deploy].each do |app_name, deploy|
  node[app_name][:files].each do |name, content|
    template "#{deploy[:deploy_to]}/current/#{name}" do
      source "content.erb"
      mode 0644
      mode 0660
      group deploy[:group]

      if platform?("ubuntu")
        owner "www-data"
      elsif platform?("amazon")
        owner "apache"
      end

      variables(
        :content => content
      )
    end
  end
end
