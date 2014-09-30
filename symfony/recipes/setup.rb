['php5-intl', 'php5-imagick', 'nodejs', 'npm', 'nodejs-legacy', 'php5-redis', 'php5-apcu', 'imagemagick'].each do |package_name|
    package package_name do
      action :install
    end
end
