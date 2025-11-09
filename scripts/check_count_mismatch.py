#!/usr/bin/env python3
"""
Compare reported_count vs actual parsed IDs in reports/route_parity.csv
Write reports/route_count_mismatches.json and .md
"""
import csv, json
from pathlib import Path
csvf = Path('reports/route_parity.csv')
mdout = Path('reports/route_count_mismatches.md')
jsonout = Path('reports/route_count_mismatches.json')
if not csvf.exists():
    print('Missing', csvf)
    raise SystemExit(1)
rows=[]
with csvf.open(newline='') as f:
    reader=csv.reader(f)
    for r in reader:
        if not r: continue
        expansion = r[0].strip()
        route_file = r[1].strip() if len(r)>1 else ''
        try:
            reported = int(r[3]) if len(r)>3 and r[3] else 0
        except:
            reported = 0
        ids = [x.strip() for x in r[4:] if x.strip()]
        actual = len(ids)
        rows.append({'expansion':expansion,'route_file':route_file,'reported':reported,'actual':actual,'ids':ids})

mismatches = [r for r in rows if r['reported'] != r['actual']]
# write json
jsonout.write_text(json.dumps({'mismatches':mismatches,'total_rows':len(rows),'mismatch_count':len(mismatches)},indent=2))
# write md
with mdout.open('w') as f:
    f.write('# Route count mismatches\n\n')
    f.write(f'Total files checked: {len(rows)}\n')
    f.write(f'Total mismatches: {len(mismatches)}\n\n')
    if mismatches:
        f.write('| Route file | Expansion | Reported | Actual | Diff |\n')
        f.write('|---|---|---:|---:|---:|\n')
        for r in sorted(mismatches, key=lambda x: abs(x['reported']-x['actual']), reverse=True):
            diff = r['reported'] - r['actual']
            f.write(f"| {r['route_file']} | {r['expansion']} | {r['reported']} | {r['actual']} | {diff:+d} |\n")
    else:
        f.write('No mismatches found.\n')

print('Wrote', jsonout, mdout)
