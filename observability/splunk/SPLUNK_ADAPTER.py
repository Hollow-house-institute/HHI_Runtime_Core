import json, sys
for line in sys.stdin: print(json.dumps({"sourcetype":"hhi:governance","event":json.loads(line)}))
