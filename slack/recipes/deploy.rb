node[:deploy].each do |app_name, deploy|
    unless node[:slack][:hook].nil?
        http_request 'hook' do
            action :post
            url node[:slack][:hook]
            message ({
                :text => "Deployed #{app_name}",
                :channel => node[:slack][:channel]
            }.to_json)
        end
    end
end
