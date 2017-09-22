default[:telegraf][:source][:ubuntu] = 'https://dl.influxdata.com/telegraf/releases/telegraf_1.4.0-1_amd64.deb'
default[:telegraf][:source][:amazon] = 'https://dl.influxdata.com/telegraf/releases/telegraf-1.4.0-1.x86_64.rpm'
default[:telegraf][:database] = "telegraf"
default[:telegraf][:retention_policy] = ""
default[:telegraf][:write_consistency] = "any"
default[:telegraf][:timeout] = "5s"
default[:telegraf][:apache][:url] = "http://localhost/server-status?auto"
