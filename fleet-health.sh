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


if [ "$rootdsk" -ge "$crit" ]; then
  diskalrt=CRIT
  code=2
elif [ "$rootdsk" -ge "$warn" ]; then
  diskalrt=WARN
  code=1
else
  diskalrt=OK
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
echo "==============================="

exit "$code"
