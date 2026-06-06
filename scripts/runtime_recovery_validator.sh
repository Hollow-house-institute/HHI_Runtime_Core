#!/data/data/com.termux/files/usr/bin/bash

echo "=== Runtime Recovery Validation ==="

pgrep -f runtime_api.py >/dev/null \
  && echo "[PASS] runtime api active" \
  || echo "[FAIL] runtime api inactive"

test -f ~/HHI_Runtime_Core/runtime/logs/RUNTIME_HEARTBEAT.log \
  && echo "[PASS] heartbeat log exists" \
  || echo "[FAIL] heartbeat log missing"

test -f ~/HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl \
  && echo "[PASS] telemetry continuity active" \
  || echo "[FAIL] telemetry continuity missing"

tail -5 ~/HHI_Runtime_Core/runtime/recovery/RECOVERY_CHAIN.jsonl
