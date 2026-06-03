import json, sys
for line in sys.stdin: print(json.dumps({"index":{"_index":"hhi-governance"}})); print(line.strip())
