#!/data/data/com.termux/files/usr/bin/bash

cd ~/HHI_Runtime_Core || exit 1

echo "[1/5] stop authority check"
bash scripts/runtime_guard.sh || exit 1

echo "[2/5] governance event append"
python3 scripts/governance_event_writer.py || exit 1

echo "[3/5] replay validation"
python3 scripts/replay_validator.py || exit 1

echo "[4/5] assurance generation"
python3 assurance/continuous_assurance.py || exit 1

echo "[5/5] runtime startup"
bash scripts/start_runtime.sh || exit 1

echo "HHI_Runtime_Core bootstrap complete"
