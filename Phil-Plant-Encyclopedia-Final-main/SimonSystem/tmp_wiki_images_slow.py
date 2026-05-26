import re
import json
import urllib.parse
import urllib.request
import time

USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'

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
    req = urllib.request.Request(url, headers={'User-Agent': USER_AGENT})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read().decode('utf-8')


def query_pageimage(title):
    url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=' + urllib.parse.quote(title) + '&prop=pageimages&piprop=thumbnail&pithumbsize=960'
    body = fetch_url(url)
    return json.loads(body)


def query_search(query):
    url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=' + urllib.parse.quote(query) + '&srlimit=3'
    body = fetch_url(url)
    return json.loads(body)


def get_thumb_from_pageinfo(info):
    page = next(iter(info.get('query', {}).get('pages', {}).values()), {})
    return page.get('thumbnail', {}).get('source'), page.get('missing') is not None


results = []
for pid, common, sci in entries:
    thumb = None
    missing = False
    tried = []

    for title in [sci, common]:
        title_quoted = title.replace(' ', '_')
        tried.append(title_quoted)
        try:
            info = query_pageimage(title_quoted)
            thumb, missing = get_thumb_from_pageinfo(info)
            if thumb:
                break
            if missing:
                continue
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print('429 limit reached, sleeping 30 seconds...')
                time.sleep(30)
                try:
                    info = query_pageimage(title_quoted)
                    thumb, missing = get_thumb_from_pageinfo(info)
                    if thumb:
                        break
                except Exception as e2:
                    print('retry failed', pid, title_quoted, e2)
            else:
                print('HTTP error', pid, title_quoted, e)
        except Exception as e:
            print('error', pid, title_quoted, e)
        time.sleep(1.5)

    if not thumb:
        try:
            search_info = query_search(sci)
            titles = [item['title'] for item in search_info.get('query', {}).get('search', [])[:3]]
            for title in titles:
                tried.append(title)
                try:
                    info = query_pageimage(title)
                    thumb, _ = get_thumb_from_pageinfo(info)
                    if thumb:
                        break
                except urllib.error.HTTPError as e:
                    if e.code == 429:
                        print('429 limit reached during search, sleeping 30 seconds...')
                        time.sleep(30)
                        continue
                    print('HTTP error search', pid, title, e)
                except Exception as e:
                    print('error search', pid, title, e)
                time.sleep(1.5)
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print('429 limit reached on search query, sleeping 30 seconds...')
                time.sleep(30)
            else:
                print('HTTP error search query', pid, sci, e)
        except Exception as e:
            print('error search query', pid, sci, e)

    results.append((pid, common, sci, thumb or ''))
    print(pid, common, sci, '->', thumb, 'tried:', tried[:5])
    time.sleep(2)

with open('wiki_thumbnails.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, indent=2, ensure_ascii=False)

print('saved wiki_thumbnails.json')
