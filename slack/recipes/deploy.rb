node[:deploy].each do |app_name, deploy|
    unless node[:slack][:hook].nil?
        message = {
            :text => "Deployed #{app_name} on stack #{node["opsworks"]["stack"]["name"]}"
        }
        unless node[:slack][:channel].nil?
            message[:channel] = node[:slack][:channel]
        end
        
        http_request 'hook' do
            action :post
            url node[:slack][:hook]
            headers ({
                "content-type" => "application/json"
            })
            message (message.to_json)
            retries 0
            ignore_failure true
        end
    end
end
