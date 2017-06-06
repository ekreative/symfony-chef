node[:deploy].each do |app_name, deploy|
  next if node[:slack][:hook].nil?
  revision = deploy['scm']['revision'].nil? ? '' : "@#{deploy['scm']['revision']}"
  message = {
    text: "#{node['opsworks']['activity']} #{app_name}#{revision} to #{node['opsworks']['instance']['hostname']}@#{node['opsworks']['stack']['name']}"
  }
  message[:channel] = node[:slack][:channel] unless node[:slack][:channel].nil?

  hdrs = {
    'content-type' => 'application/json'
  }
  http_request 'hook' do
    action :post
    url node[:slack][:hook]
    headers hdrs
    message (message.to_json)
    retries 0
    ignore_failure true
  end
end
