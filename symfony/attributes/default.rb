default[:symfony][:packages] = ['php5-intl', 'php5-redis', 'php5-apcu', 'php5-cli']
default[:symfony][:ini][:memorylimit] = '128MB'
default[:symfony][:ini][:timezone] = 'UTC'
default[:symfony][:console] = 'app/console'
default[:symfony][:writable] = ['app/cache']
