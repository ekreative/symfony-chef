node[:deploy].each do |app_name, deploy|
    log "going to compose"
    log "going to use #{node['composer']['bin']}"
    composer_project "#{deploy[:deploy_to]}/current" do
        group deploy[:group]
        if platform?("ubuntu")
            user "www-data"
        elsif platform?("amazon")
            user "apache"
        end
        dev true
        quiet false
        action :install
    end

    log "composed"
end
