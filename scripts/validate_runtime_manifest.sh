#!/data/data/com.termux/files/usr/bin/bash

cd ~/HHI_Runtime_Core/runtime/manifests || exit 1

sha256sum -c runtime_manifest_v1.sha256
