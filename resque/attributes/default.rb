default[:resque][:packages] = ['supervisor']
default[:resque][:resque_bin] = 'bin/resque'
default[:resque][:resque_scheduler_bin] = 'bin/resque-scheduler'
default[:resque][:workers] = 1
default[:resque][:queue] = 'default'
default[:resque][:host] = 'localhost'
default[:resque][:port] = 'localhost'
