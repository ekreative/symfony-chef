template '/etc/telegraf/telegraf.conf' do
  source 'telegraf.cfg.erb'
  owner 'root'
  group 'root'
  mode 0o644
end
