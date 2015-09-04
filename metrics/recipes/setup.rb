node[:metrics][:packages].each do |package_name|
    package package_name do
        action :install
    end
end


directory node[:metrics][:install_dir] do
    recursive true
end

remote_file "#{node[:metrics][:install_dir]}/CloudWatchMonitoringScripts.zip" do
    source node[:metrics][:script_url]
end

execute "Unzip the scripts" do
    command "unzip -o #{node[:metrics][:install_dir]}/CloudWatchMonitoringScripts.zip"
    cwd node[:metrics][:install_dir]
end

cron "cloudwatch-metrics" do
    minute '*/5'
    command "#{node[:metrics][:install_dir]}/#{node[:metrics][:script]} --from-cron #{node[:metrics][:flags]}"
end
