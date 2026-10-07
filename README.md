# fleet-health

A Bash health-check script for Linux servers. It reports system info, checks disk, memory, and CPU load against warning and critical limits, and exits with a status code that monitoring tools can act on.

Built as a hands-on project to practice Linux and Bash for Site Reliability Engineering work.

## What it checks

| Check  | How it's measured                                   | WARN at | CRIT at |
|--------|-----------------------------------------------------|---------|---------|
| Disk   | Percent used on `/` (`df`)                          | 80%     | 90%     |
| Memory | Percent used, based on *available* memory (`free`)  | 80%     | 90%     |
| Load   | 1-minute load average as a percent of CPU cores     | 80%     | 90%     |

It also reports hostname, user, kernel, uptime, CPU count, OS, and a timestamp.

## Usage

```bash
git clone git@github.com:O-gabriel-ibitoye/fleet-health.git
cd fleet-health
./fleet-health.sh
echo $?    # show the exit code
```

Requirements: Bash, plus standard Linux tools (`df`, `free`, `awk`, `nproc`, `lsb_release`).

## Exit codes

| Code | Meaning |
|------|---------|
| 0    | OK: all checks passed |
| 1    | WARN: at least one check is over its warning limit |
| 2    | CRIT: at least one check is over its critical limit |

The script always reports the **worst** result across all checks. If even one check is CRIT, the script exits 2. Monitoring tools and schedulers read this number to decide whether to alert, so they don't need to parse the text output.

## Example output

```
===== fleet-health report =====
Host:    SkytechNebula
User:    gabe4020
Kernel:  5.15.167.4-microsoft-standard-WSL2
Uptime:  up 4 days, 10 hours, 57 minutes
CPUs:    16
OS:      Ubuntu 22.04.5 LTS
Checked: 2026-10-07 03:08:52
Disk /:  1% used [OK]
Memory:  8% used [OK]
Load:    0% of CPUs [OK]
===============================
```

## Roadmap

- [x] System info report
- [x] Disk check with OK / WARN / CRIT exit codes
- [x] Memory and load checks, worst-status exit code
- [ ] Top processes by memory and CPU
- [ ] Refactor into functions; systemd service checks
- [ ] Log scanning and error summaries
- [ ] Network checks (DNS, HTTP, ports)
- [ ] Command-line flags, config file, `lib/` layout, `set -euo pipefail`
- [ ] Logging and scheduling with cron / systemd timer
- [ ] Deploy and run on AWS EC2; runbook; v1.0 release
