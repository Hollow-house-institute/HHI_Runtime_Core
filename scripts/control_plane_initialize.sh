#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/HHI_Runtime_Core"
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "{\"timestamp\":\"$TS\",\"event\":\"governance_control_plane_initialized\",\"classification\":\"orchestration_transition\",\"runtime\":\"HHI_Runtime_Core\"}" >> "$ROOT/runtime/continuity/ARCHITECTURAL_MILESTONES.jsonl"

echo "{\"timestamp\":\"$TS\",\"event\":\"runtime_federation_layer_initialized\",\"classification\":\"distributed_governance_transition\",\"runtime\":\"HHI_Runtime_Core\"}" >> "$ROOT/runtime/continuity/ARCHITECTURAL_MILESTONES.jsonl"

sha256sum "$ROOT/runtime/continuity/ARCHITECTURAL_MILESTONES.jsonl" >> "$ROOT/runtime/checksums/CONTINUITY_SHA256SUMS"

cat > "$ROOT/control_plane/fleet/runtime_registry.json" <<REG
{
  "registered_runtimes": [
    {
      "runtime_id": "HHI_Runtime_Core",
      "status": "ACTIVE",
      "telemetry": "CONNECTED",
      "replay": "CONNECTED",
      "assurance": "CONNECTED",
      "transport": [
        "ndjson",
        "opentelemetry",
        "siem"
      ]
    }
  ]
}
REG

echo "governance control plane initialized"
