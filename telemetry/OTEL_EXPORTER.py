import json, sys
for line in sys.stdin: print(json.dumps({"resource":"hhi_governance_runtime","body":json.loads(line)}))
