['php5-redis', 'supervisor', 'php5-cli'].each do |package_name|
    package package_name do
      action :install
    end
end
