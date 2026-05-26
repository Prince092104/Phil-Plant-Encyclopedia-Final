import json
with open('wiki_html_images.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
success = [d for d in data if d['image']]
miss = [d for d in data if not d['image']]
print('total', len(data), 'success', len(success), 'missing', len(miss))
print('missing ids', [d['id'] for d in miss][:50])
for d in miss[:10]:
    print(d)
