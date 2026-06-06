#!/data/data/com.termux/files/usr/bin/bash

TS=$(date -u +"%Y%m%dT%H%M%SZ")
OUT=~/HHI_Runtime_Core/exports/bundles/HHI_GOVERNANCE_BUNDLE_$TS.tar.gz

tar --exclude='__pycache__' \
    --exclude='*.pyc' \
    --exclude='runtime/snapshots/*' \
    -czf "$OUT" \
    ~/HHI_Runtime_Core/runtime \
    ~/HHI_Runtime_Core/governance \
    ~/HHI_Runtime_Core/assurance \
    ~/HHI_Runtime_Core/api

sha256sum "$OUT" >> ~/HHI_Runtime_Core/runtime/checksums/EXPORT_SHA256SUMS

echo "governance bundle exported: $OUT"
