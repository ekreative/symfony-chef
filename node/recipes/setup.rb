execute "Setup node packages" do
    command "curl -sL #{node[:node][:source]} | bash -"
end

node[:node][:packages].each do |package_name|
    package package_name do
        action :install
    end
end
