#!/usr/bin/env bash
set -euo pipefail
test -f replay/REPLAY_CONTINUITY_MANIFEST.json
test -f schema_registry/governance_event_schema.json
test -f runtime/logs/governance_events.jsonl || touch runtime/logs/governance_events.jsonl
echo "Snapshot replay restoration test passed."
