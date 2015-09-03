normal[:apache][:prefork][:maxrequestworkers] = `free | awk '/^Mem:/{print $2}'`.to_i / 81920
normal[:apache][:prefork][:serverlimit] = normal[:apache][:prefork][:maxrequestworkers]
normal[:apache][:log_level] = 'notice'
normal[:apache][:log_filter] = [{'User-Agent' => 'ELB-HealthChecker'}, {'User-Agent' => 'Amazon Route 53 Health Check Service'}]
