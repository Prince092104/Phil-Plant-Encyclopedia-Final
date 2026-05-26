import re
import json
import urllib.parse
import urllib.request
import time

path = 'database.sql'
with open(path, 'r', encoding='utf-8') as f:
    data = f.read()

m = re.search(r"INSERT INTO plants \(id, common_name, scientific_name, description, habitat, uses, conservation\)\nVALUES\n(.*?)\n\nINSERT INTO plant_municipalities", data, re.S)
if not m:
    raise SystemExit('plants block not found')
block = m.group(1)
entries = re.findall(r"\((\d+),\s*'([^']+)',\s*'([^']+)',", block)
print('found', len(entries))

def fetch_url(url):
    req = urllib.request.Request(url, headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'
    })
    with urllib.request.urlopen(req, timeout=20) as r:
        return r.read().decode('utf-8')

for pid, common, sci in entries:
    name = sci.replace(' ', '_')
    url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=' + urllib.parse.quote(name) + '&prop=pageimages&piprop=thumbnail&pithumbsize=800'
    thumb = None
    missing = None
    try:
        info = json.loads(fetch_url(url))
        page = next(iter(info.get('query', {}).get('pages', {}).values()), {})
        thumb = page.get('thumbnail', {}).get('source')
        missing = page.get('missing')
    except Exception as e:
        print('ERR primary', pid, sci, e)
        thumb = None
        missing = None
    if not thumb and missing is not None:
        name = common.replace(' ', '_')
        url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=' + urllib.parse.quote(name) + '&prop=pageimages&piprop=thumbnail&pithumbsize=800'
        try:
            info = json.loads(fetch_url(url))
            page = next(iter(info.get('query', {}).get('pages', {}).values()), {})
            thumb = page.get('thumbnail', {}).get('source')
        except Exception as e:
            print('ERR fallback', pid, common, e)
            thumb = None
    if not thumb:
        search_url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=' + urllib.parse.quote(sci)
        try:
            search = json.loads(fetch_url(search_url))
            titles = [item['title'] for item in search.get('query', {}).get('search', [])[:3]]
            for title in titles:
                url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=' + urllib.parse.quote(title) + '&prop=pageimages&piprop=thumbnail&pithumbsize=800'
                try:
                    info = json.loads(fetch_url(url))
                    page = next(iter(info.get('query', {}).get('pages', {}).values()), {})
                    thumb = page.get('thumbnail', {}).get('source')
                    if thumb:
                        break
                except Exception:
                    continue
        except Exception as e:
            print('ERR search', pid, sci, e)
    print(pid, common, sci, '->', thumb)
    time.sleep(0.2)
