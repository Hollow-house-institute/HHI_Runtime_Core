#!/data/data/com.termux/files/usr/bin/bash

echo "=== HHI_Runtime_Core Status ==="
echo

echo "[runtime state]"
cat ~/HHI_Runtime_Core/runtime/runtime_state.json
echo

echo "[heartbeat]"
tail -5 ~/HHI_Runtime_Core/runtime/logs/RUNTIME_HEARTBEAT.log 2>/dev/null
echo

echo "[telemetry count]"
wc -l ~/HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl
echo

echo "[assurance]"
cat ~/HHI_Runtime_Core/assurance/reports/latest_assurance.json 2>/dev/null
