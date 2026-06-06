#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/HHI_Runtime_Core"
TS=$(date -u +"%Y%m%dT%H%M%SZ")
SRC="$ROOT/runtime/telemetry/append_only/GOVERNANCE_LOG.jsonl"

cp "$SRC" "$ROOT/exports/ndjson/governance_events_$TS.ndjson"

cat > "$ROOT/exports/opentelemetry/otel_mapping_$TS.json" <<MAP
{
  "runtime_source": "HHI_Runtime_Core",
  "transport": "opentelemetry",
  "mapped_attributes": {
    "event_id": "hhi.event_id",
    "decision_boundary": "hhi.decision_boundary",
    "behavioral_drift_score": "hhi.behavioral_drift_score",
    "escalation_level": "hhi.escalation_level",
    "intervention_status": "hhi.intervention_status",
    "stop_authority": "hhi.stop_authority",
    "runtime_source": "service.name"
  }
}
MAP

cat > "$ROOT/exports/siem/siem_ingest_mapping_$TS.json" <<MAP
{
  "runtime_source": "HHI_Runtime_Core",
  "transport": "siem",
  "targets": ["splunk", "elastic"],
  "format": "ndjson",
  "event_type": "hhi_governance_event",
  "checksum_required": true,
  "replay_capable": true
}
MAP

sha256sum "$ROOT"/exports/ndjson/governance_events_$TS.ndjson \
          "$ROOT"/exports/opentelemetry/otel_mapping_$TS.json \
          "$ROOT"/exports/siem/siem_ingest_mapping_$TS.json \
          >> "$ROOT/runtime/checksums/OPERATIONAL_ECOSYSTEM_EXPORT_SHA256SUMS"

echo "external operational ecosystem exports created: $TS"
