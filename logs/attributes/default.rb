default[:logs][:region] = 'eu-west-1'
default[:logs][:symfony] = true
default[:logs][:apache] = true
default[:logs][:symfony_datetime] = '[%Y-%m-%d %H:%M:%S]'
default[:logs][:install_dir] = '/opt/aws/cloudwatch'
default[:logs][:script_url] = 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
default[:logs][:script] = 'awslogs-agent-setup.py'
