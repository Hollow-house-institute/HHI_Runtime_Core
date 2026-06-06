#!/usr/bin/env python3
import json
from pathlib import Path

log_path = Path.home() / "HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl"

valid = 0
invalid = 0

for line in log_path.open():
    try:
        event = json.loads(line)
        required = [
            "event_id",
            "timestamp",
            "actor",
            "decision_boundary",
            "stop_authority",
            "action",
            "outcome",
            "evidence_hash"
        ]
        if all(k in event for k in required):
            valid += 1
        else:
            invalid += 1
    except Exception:
        invalid += 1

print(json.dumps({
    "runtime_source": "HHI_Runtime_Core",
    "valid_events": valid,
    "invalid_events": invalid,
    "replay_validation": "PASS" if invalid == 0 else "FAIL"
}, indent=2))
