if platform?('ubuntu')
  source = node[:node][:source][:ubuntu]
elsif platform?('amazon')
  source = node[:node][:source][:amazon]
end

execute 'Setup node packages' do
  command "curl -sL #{source} | bash -"
end

node[:node][:packages].each do |package_name|
  package package_name do
    action :install
  end
end
