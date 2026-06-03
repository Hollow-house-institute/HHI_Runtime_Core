import json
import hashlib
from pathlib import Path
import sys

# ----------------------------
# ROOT RESOLUTION (TERMUX SAFE)
# ----------------------------

def find_project_root():
    """
    Walk upward from current directory until we find a 'data' folder.
    This makes execution independent of where Termux starts.
    """
    current = Path.cwd()

    for _ in range(10):  # safety bound
        if (current / "data").exists():
            return current
        if current.parent == current:
            break
        current = current.parent

    return None


def locate_events(root):
    """
    Try multiple canonical locations.
    """
    candidates = [
        root / "data" / "events.json",
        root / "hhi_audit_runtime" / "data" / "events.json",
        Path.cwd() / "data" / "events.json",
    ]

    for c in candidates:
        if c.exists():
            return c

    return None


# ----------------------------
# CORE ENGINE
# ----------------------------

def hash_state(state):
    raw = json.dumps(state, sort_keys=True).encode()
    return hashlib.sha256(raw).hexdigest()


def apply_event(state, event):
    etype = event.get("type")
    payload = event.get("payload", {})

    state.setdefault("events", []).append(event.get("event_id"))

    if etype == "system_initialization":
        state["identity"] = payload

    elif etype == "infrastructure_activation":
        state.setdefault("governance", {})
        state["governance"]["system"] = payload.get("system")

    elif etype == "runtime_validation":
        state.setdefault("audit", {})
        state["audit"]["validation"] = payload

    elif etype == "audit_stabilization":
        state.setdefault("audit", {})
        state["audit"]["stabilization"] = payload

    elif etype == "memory_state_operation":
        state.setdefault("memory", {})
        state["memory"]["last_action"] = payload

    return state


# ----------------------------
# MAIN EXECUTION
# ----------------------------

def main():
    root = find_project_root()

    if not root:
        print("\n[ERROR] Project root not found.")
        print("Expected a folder containing /data directory.")
        sys.exit(1)

    events_file = locate_events(root)

    if not events_file:
        print("\n[ERROR] events.json not found.")
        print("Searched in:")
        print(" - data/events.json")
        print(" - hhi_audit_runtime/data/events.json")
        sys.exit(1)

    print(f"[OK] Root: {root}")
    print(f"[OK] Loading: {events_file}")

    with open(events_file, "r") as f:
        events = json.load(f)

    state = {}

    for e in events:
        state = apply_event(state, e)

    checksum = hash_state(state)

    print("\nFINAL STATE:")
    print(json.dumps(state, indent=2))

    print("\nCHECKSUM:")
    print(checksum)


if __name__ == "__main__":
    main()
