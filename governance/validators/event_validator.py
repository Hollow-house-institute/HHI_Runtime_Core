#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path.home() / "HHI_Runtime_Core"

schema_file = ROOT / "governance/schema_versions/GOVERNANCE_EVENT_SCHEMA_v1.0.json"
telemetry_file = ROOT / "runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl"

schema = json.load(open(schema_file))
required = schema["required_fields"]

valid = 0
invalid = 0

for line in open(telemetry_file):
    try:
        event = json.loads(line)
        if all(field in event for field in required):
            valid += 1
        else:
            invalid += 1
    except Exception:
        invalid += 1

print(json.dumps({
    "schema_version": schema["schema_version"],
    "valid_events": valid,
    "invalid_events": invalid,
    "validation_status": "PASS" if invalid == 0 else "FAIL"
}, indent=2))
