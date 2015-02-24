['php5-intl', 'php5-redis', 'php5-apcu', 'php5-cli'].each do |package_name|
    package package_name do
      action :install
    end
end
