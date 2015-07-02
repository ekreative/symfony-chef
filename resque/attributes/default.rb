default[:resque][:packages] = ['supervisor']
default[:resque][:workers] = 2
default[:resque][:resque_bin] = 'bin/resque'
default[:resque][:scheduler] = true
default[:resque][:resque_scheduler_bin] = 'bin/resque-scheduler'
