node[:deploy].each do |_app_name, deploy|
  execute 'npm' do
    cwd "#{deploy[:deploy_to]}/current"
    command 'npm install'
    environment 'HOME' => "#{deploy[:deploy_to]}/current"
    user deploy[:user]
    group deploy[:group]
    only_if { File.exist?("#{deploy[:deploy_to]}/current/package.json") }
  end
end
