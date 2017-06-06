node[:deploy].each do |_app_name, deploy|
  execute 'gulp' do
    cwd "#{deploy[:deploy_to]}/current"
    command "#{deploy[:deploy_to]}/current/#{node[:node][:gulp_bin]}"
    environment 'HOME' => "#{deploy[:deploy_to]}/current"
    user deploy[:user]
    group deploy[:group]
    only_if { File.exist?("#{deploy[:deploy_to]}/current/gulpfile.js") }
  end
end
