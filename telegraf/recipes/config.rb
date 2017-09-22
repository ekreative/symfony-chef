template '/etc/telegraf/telegraf.conf' do
  source 'telegraf.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
end
