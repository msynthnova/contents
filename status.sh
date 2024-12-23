#!/bin/bash

while true; do
    # Get CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    # Get RAM usage
    ram_usage=$(free -m | awk '/^Mem:/{printf "%.2f/%d MB", $3, $2}')
    
    # Get date and time
    date_time=$(date +"%Y-%m-%d %H:%M:%S")

    # Output the status
    echo "CPU: $cpu_usage% | RAM: $ram_usage | $date_time"

    sleep 1
done
