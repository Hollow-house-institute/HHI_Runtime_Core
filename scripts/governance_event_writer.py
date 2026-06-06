#!/usr/bin/env python3
import json, uuid, hashlib, datetime, pathlib

runtime_log = pathlib.Path.home() / "HHI_Runtime_Core/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl"

event = {
    "event_id": str(uuid.uuid4()),
    "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
    "actor": "system",
    "system": "HHI_Runtime_Core",
    "session_id": "runtime_bootstrap",
    "trace_id": str(uuid.uuid4()),
    "decision_boundary": "RUNTIME_INITIALIZATION",
    "behavioral_drift_score": 0,
    "escalation_level": "NONE",
    "intervention_status": "NONE",
    "stop_authority": "ACTIVE",
    "action": "runtime_start",
    "outcome": "success",
    "runtime_source": "HHI_Runtime_Core"
}

event["evidence_hash"] = hashlib.sha256(
    json.dumps(event, sort_keys=True).encode()
).hexdigest()

with open(runtime_log, "a") as f:
    f.write(json.dumps(event) + "\n")

print("governance event appended")
