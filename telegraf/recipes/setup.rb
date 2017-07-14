if platform?('ubuntu')
  source = node[:telegraf][:source][:ubuntu]
elsif platform?('amazon')
  source = node[:telegraf][:source][:amazon]
end

remote_file '/tmp/telegraf' do
  source source
end

package "telegraf" do
  source '/tmp/telegraf'
  action :install
end
