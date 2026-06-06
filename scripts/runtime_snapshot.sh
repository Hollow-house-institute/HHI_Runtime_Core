#!/data/data/com.termux/files/usr/bin/bash

TS=$(date -u +"%Y%m%dT%H%M%SZ")
SNAP=~/HHI_Runtime_Core/runtime/snapshots/runtime_snapshot_$TS.tar.gz

tar --exclude='__pycache__' \
    --exclude='*.pyc' \
    --exclude='exports/bundles/*' \
    -czf "$SNAP" \
    ~/HHI_Runtime_Core/runtime \
    ~/HHI_Runtime_Core/governance \
    ~/HHI_Runtime_Core/assurance

sha256sum "$SNAP" >> ~/HHI_Runtime_Core/runtime/checksums/SNAPSHOT_SHA256SUMS

echo "{\"timestamp\":\"$TS\",\"snapshot\":\"$(basename "$SNAP")\",\"status\":\"created\"}" >> ~/HHI_Runtime_Core/runtime/continuity/CONTINUITY_CHAIN.jsonl

echo "snapshot complete: $SNAP"
