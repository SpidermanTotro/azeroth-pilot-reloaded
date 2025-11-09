#!/usr/bin/env python3
"""
Safe fixer for bracketed numeric keys in route files.
Replaces patterns like: { [12345] }  -> { 12345 }
Only updates braces that contain exclusively bracketed numbers separated by commas.
Backs up original files to <file>.bak before writing.
"""
import json, re, sys
from pathlib import Path

jsonf = Path('reports/route_validation.json')
if not jsonf.exists():
    print('Missing', jsonf)
    sys.exit(1)

data = json.loads(jsonf.read_text())
results = data.get('results', [])
pattern = re.compile(r"\{\s*(?:\[\s*\d+\s*\]\s*(?:,\s*\[\s*\d+\s*\]\s*)*)\}", re.S)
numextract = re.compile(r"\[\s*(\d+)\s*\]")

summary = {'checked':0,'updated':0,'skipped':0,'errors':[]}
for r in results:
    if 'bracketed_numeric_keys' not in r.get('issues', []):
        continue
    path = r.get('path')
    if not path:
        summary['skipped'] += 1
        continue
    p = Path(path)
    if not p.exists():
        summary['errors'].append(f'missing file: {path}')
        continue
    txt = p.read_text(encoding='utf-8')
    new_txt = txt
    changed = False
    def replace_fn(m):
        inner = m.group(0)
        nums = numextract.findall(inner)
        if not nums:
            return inner
        # build replacement
        return '{ ' + ', '.join(nums) + ' }'
    new_txt = pattern.sub(replace_fn, txt)
    summary['checked'] += 1
    if new_txt != txt:
        bak = p.with_suffix(p.suffix + '.bak')
        try:
            p.rename(bak)
        except Exception:
            # fallback to copy
            bak.write_text(txt, encoding='utf-8')
        p.write_text(new_txt, encoding='utf-8')
        summary['updated'] += 1
        print(f'Updated: {path} (backup: {bak})')
    else:
        summary['skipped'] += 1

print('\nSummary:')
print(summary)

# return non-zero if no files updated
if summary['updated']==0:
    sys.exit(2)
else:
    sys.exit(0)
