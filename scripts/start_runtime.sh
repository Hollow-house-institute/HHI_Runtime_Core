#!/data/data/com.termux/files/usr/bin/bash

cd ~/HHI_Runtime_Core || exit 1

nohup python3 api/runtime_api.py > runtime/logs/runtime_api.log 2>&1 &
nohup bash scripts/runtime_heartbeat.sh > /dev/null 2>&1 &
nohup bash scripts/start_watchdog.sh > /dev/null 2>&1 &

echo "HHI_Runtime_Core started"
