execute "Install CloudWatch Logs agent" do
  command "#{node[:logs][:install_dir]}/#{node[:logs][:script]} -n -r #{node[:logs][:region]} -c /tmp/cwlogs.cfg"
  not_if { system "pgrep -f aws-logs-agent-setup" }
end
