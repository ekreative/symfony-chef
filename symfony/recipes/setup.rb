['php5-intl', 'php5-imagick', 'php5-intl', 'nodejs', 'npm', 'nodejs-legacy', 'php5-redis'].each do |package_name|
    package package_name do
      action :install
    end
end
