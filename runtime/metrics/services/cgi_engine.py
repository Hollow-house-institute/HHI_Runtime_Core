import json
from pathlib import Path

CONFIG = Path(__file__).parent.parent / "config" / "canonical_metric_stack.json"

cfg = json.loads(CONFIG.read_text())

def compute_cgi(
    structure,
    rhythm,
    signal,
    drift,
    assurance,
    control
):
    w = cfg["weights"]

    drift_adjusted = 1.0 - drift

    score = (
        structure * w["structure"] +
        rhythm * w["rhythm"] +
        signal * w["signal"] +
        drift_adjusted * w["drift"] +
        assurance * w["assurance"] +
        control * w["control"]
    )

    return round(score, 4)

if __name__ == "__main__":
    print(
        compute_cgi(
            0.85,
            0.80,
            0.90,
            0.10,
            0.88,
            0.84
        )
    )
