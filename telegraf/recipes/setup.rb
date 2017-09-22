if platform?('ubuntu')
  source = node[:telegraf][:source][:ubuntu]
  pkg_resource = :dpkg_package
elsif platform?('amazon')
  source = node[:telegraf][:source][:amazon]
  pkg_resource = :rpm_package
end

remote_file '/tmp/telegraf' do
  source source
end

declare_resource(pkg_resource, '/tmp/telegraf') do
  action :install
end
