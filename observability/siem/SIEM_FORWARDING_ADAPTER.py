import json, sys
for line in sys.stdin:
    event=json.loads(line)
    print(json.dumps({"source":"HHI","event":event}))
