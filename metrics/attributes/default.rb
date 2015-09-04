default[:metrics][:script_url] = 'http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip'
default[:metrics][:packages] = ['unzip', 'libwww-perl', 'libdatetime-perl']
default[:metrics][:install_dir] = '/opt/aws/cloudwatch-metrics'
default[:metrics][:script] = 'aws-scripts-mon/mon-put-instance-data.pl'
default[:metrics][:flags] = '--disk-path=/ --disk-space-util --disk-space-used --disk-space-avail'
