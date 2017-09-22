default[:telegraf][:source][:ubuntu] = 'https://dl.influxdata.com/telegraf/releases/telegraf_1.4.0-1_amd64.deb'
default[:telegraf][:source][:amazon] = 'https://dl.influxdata.com/telegraf/releases/telegraf-1.4.0-1.x86_64.rpm'
default[:telegraf][:database] = "telegraf"
node[:telegraf][:retention_policy] = ""
node[:telegraf][:write_consistency] = "any"
node[:telegraf][:timeout] = "5s"
node[:telegraf][:apache][:url] = "http://localhost/server-status?auto"
