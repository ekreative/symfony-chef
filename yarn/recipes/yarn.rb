node[:deploy].each do |_app_name, deploy|
  execute 'yarn' do
    cwd "#{deploy[:deploy_to]}/current"
    command 'yarn'
    environment 'HOME' => "#{deploy[:deploy_to]}/current"
    user deploy[:user]
    group deploy[:group]
    only_if { File.exist?("#{deploy[:deploy_to]}/current/package.json") }
  end
end
