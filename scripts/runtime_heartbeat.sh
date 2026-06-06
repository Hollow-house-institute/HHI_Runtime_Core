#!/data/data/com.termux/files/usr/bin/bash
while true; do
  echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ") HHI_Runtime_Core ACTIVE" >> ~/HHI_Runtime_Core/runtime/logs/RUNTIME_HEARTBEAT.log
  sleep 60
done
