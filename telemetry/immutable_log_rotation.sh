#!/usr/bin/env bash
set -euo pipefail
mkdir -p runtime/logs/archive
ts=$(date -u +%Y%m%dT%H%M%SZ)
[ -f runtime/logs/governance_events.jsonl ] && cp runtime/logs/governance_events.jsonl "runtime/logs/archive/governance_events_$ts.jsonl"
find runtime/logs/archive -type f -name "*.jsonl" -exec sha256sum {} \; > runtime/logs/archive/ARCHIVE_SHA256SUMS
