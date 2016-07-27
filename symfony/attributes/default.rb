default[:symfony][:packages] = ['php5-intl', 'php5-redis', 'php5-apcu', 'php5-cli']
default[:symfony][:ini]['memory_limit'] = '128M'
default[:symfony][:ini]['date.timezone'] = 'UTC'
default[:symfony][:console] = 'app/console'
default[:symfony][:writable] = ['app/cache']
default[:symfony][:composer_dev] = true
default[:symfony][:composer_optimize_autoloader] = true
