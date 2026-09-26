#!/usr/bin/env bash
#report of fleet health

host=$(hostname)
usernm=$(whoami)
kernel=$(uname -r)
activetm=$(uptime -p)
cores=$(nproc)
os=$(lsb_release -ds)
checked=$(date '+%F %T')

echo "===== fleet-health report ====="
echo "Host:    $host"
echo "User:    $usernm"
echo "Kernel:  $kernel"
echo "Uptime:  $activetm"
echo "CPUs:    $cores"
echo "OS:      $os"
echo "Checked: $checked"
echo "==============================="

