#!/data/data/com.termux/files/usr/bin/bash

LOG=~/HHI_Runtime_Core/runtime/observability/WATCHDOG.log
ALERT=~/HHI_Runtime_Core/runtime/alerts/ALERTS.jsonl

TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "[$TS] watchdog cycle start" >> "$LOG"

pgrep -f runtime_api.py >/dev/null
API_STATUS=$?

test -s ~/HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl
TELEMETRY_STATUS=$?

test -s ~/HHI_Runtime_Core/assurance/reports/latest_assurance.json
ASSURANCE_STATUS=$?

if [ $API_STATUS -ne 0 ]; then
  echo "{\"timestamp\":\"$TS\",\"severity\":\"HIGH\",\"event\":\"runtime_api_down\"}" >> "$ALERT"
fi

if [ $TELEMETRY_STATUS -ne 0 ]; then
  echo "{\"timestamp\":\"$TS\",\"severity\":\"CRITICAL\",\"event\":\"telemetry_missing\"}" >> "$ALERT"
fi

if [ $ASSURANCE_STATUS -ne 0 ]; then
  echo "{\"timestamp\":\"$TS\",\"severity\":\"MEDIUM\",\"event\":\"assurance_missing\"}" >> "$ALERT"
fi

echo "[$TS] watchdog cycle complete" >> "$LOG"
