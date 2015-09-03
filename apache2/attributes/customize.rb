normal[:apache][:prefork][:maxrequestworkers] = `free | awk '/^Mem:/{print $2}'`.to_i / 81920
normal[:apache][:prefork][:serverlimit] = normal[:apache][:prefork][:maxrequestworkers]
