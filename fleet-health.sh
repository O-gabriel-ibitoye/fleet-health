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
load_pct=$(awk -v c="$cores" '{printf "%d", $1 * 100 / c}' /proc/loadavg)


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



if [ "$load_pct" -ge "$crit" ]; then
  loadhealth=CRIT
  load_code=2
elif [ "$load_pct" -ge "$warn" ]; then
  loadhealth=WARN
  load_code=1
else
  loadhealth=OK
  load_code=0
fi


code=$disk_code
if [ "$mem_code" -gt "$code" ]; then
  code=$mem_code
fi
if [ "$load_code" -gt "$code" ]; then
  code=$load_code
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
echo "Load:    $load_pct% of CPUs [$loadhealth]"
echo "==============================="

exit "$code"
