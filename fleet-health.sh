#!/usr/bin/env bash
#report of fleet health

hostname="SkytechNebula"
whoami="Gabriel Ibitoye"

echo "===== fleet-health report ====="
echo "Host:    $hostname"
echo "User:    $whoami"
echo "Version: $(uname -r)"
echo "Uptime:  $(uptime -p)"
echo "CPU's:   $(nproc)"
echo "OS:      $(lsb_release -ds)"
echo "Checked: $(date)"
echo "==============================="
