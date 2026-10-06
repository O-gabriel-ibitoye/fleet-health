#!/usr/bin/env bash
#report of fleet health

host=$(hostname)
usernm=$(whoami)
kernel=$(uname -r)
activetm=$(uptime -p)
cores=$(nproc)
os=$(lsb_release -ds)
checked=$(date '+%F %T')
warn=80
crit=90
rootdsk=$(df -P / | awk 'NR==2 {print $5}' | tr -d "%")
total=$(free -m | awk 'NR==2 {print $2}')
available=$(free -m | awk 'NR==2 {print $7}')
mem_used=$(( (total - available) * 100 / total ))


if [ "$rootdsk" -ge "$crit" ]; then
  diskalrt=CRIT
  disk_code=2
elif [ "$rootdsk" -ge "$warn" ]; then
  diskalrt=WARN
  disk_code=1
else
  diskalrt=OK
  disk_code=0
fi



if [ "$mem_used" -ge "$crit" ]; then
  memalrt=CRIT
  mem_code=2
elif [ "$mem_used" -ge "$warn" ]; then
  memalrt=WARN
  mem_code=1
else
  memalrt=OK
  mem_code=0
fi 


if [ "$disk_code" -gt "$mem_code" ]; then
  code=$disk_code
elif [ "$mem_code" -gt "$disk_code" ]; then
  code=$mem_code
elif [ "$mem_code" -eq "$disk_code" ]; then
  code=$mem_code
else
  code=0
fi


echo "===== fleet-health report ====="
echo "Host:    $host"
echo "User:    $usernm"
echo "Kernel:  $kernel"
echo "Uptime:  $activetm"
echo "CPUs:    $cores"
echo "OS:      $os"
echo "Checked: $checked"
echo "Disk /:  $rootdsk% used [$diskalrt]"
echo "Memory:  $mem_used% used [$memalrt]"
echo "==============================="

exit "$code"
