#!/data/data/com.termux/files/usr/bin/bash

STOP_FILE=~/HHI_Runtime_Core/governance/STOP_AUTHORITY
LOG=~/HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl

if [ -f "$STOP_FILE" ]; then
  echo "{\"timestamp\":\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\",\"event\":\"STOP_AUTHORITY_TRIGGERED\",\"runtime\":\"HHI_Runtime_Core\"}" >> "$LOG"
  echo "STOP AUTHORITY ACTIVE"
  exit 1
fi

echo "runtime cleared"
