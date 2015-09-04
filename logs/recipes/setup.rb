directory node[:logs][:install_dir] do
  recursive true
end

remote_file "#{node[:logs][:install_dir]}/#{node[:logs][:script]}" do
  source node[:logs][:script_url]
  mode "0755"
end

execute "Install CloudWatch Logs agent" do
  command "#{node[:logs][:install_dir]}/#{node[:logs][:script]} -n -r #{node[:logs][:region]} -c /tmp/cwlogs.cfg"
  not_if { system "pgrep -f aws-logs-agent-setup" }
end
