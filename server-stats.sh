#!/bin/bash

echo "===== Server Performance Stats ====="

# Tổng CPU usage
echo -e "\n--- CPU Usage ---"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

# Tổng Memory usage
echo -e "\n--- Memory Usage ---"
free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3*100/$2 }'

# Tổng Disk usage
echo -e "\n--- Disk Usage ---"
df -h --total | grep 'total' | awk '{print "Used: " $3 " / Total: " $2 " (" $5 " used)"}'

# Top 5 processes by CPU
echo -e "\n--- Top 5 Processes by CPU ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory
echo -e "\n--- Top 5 Processes by Memory ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Stretch goal: OS version, uptime, load average
echo -e "\n--- System Info ---"
echo "OS Version: $(lsb_release -d | awk -F'\t' '{print $2}')"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"

echo "===================================="

