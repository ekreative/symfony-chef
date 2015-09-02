['unzip', 'libwww-perl', 'libdatetime-perl'].each do |package_name|
    package package_name do
        action :install
    end
end


directory "/opt/aws/cloudwatch-metrics" do
    recursive true
end

remote_file "/opt/aws/cloudwatch-metrics/CloudWatchMonitoringScripts.zip" do
    source node[:metrics][:script_url]
end

execute "Unzip the scripts" do
    command "unzip -o /opt/aws/cloudwatch-metrics/CloudWatchMonitoringScripts.zip"
    cwd "/opt/aws/cloudwatch-metrics"
end

cron "cloudwatch-metrics" do
    minute '*/5'
    command '/opt/aws/cloudwatch-metrics/aws-scripts-mon/mon-put-instance-data.pl --disk-path=/ --disk-space-util --disk-space-used --disk-space-avail --from-cron'
end
