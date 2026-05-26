import re
import json
import time
import urllib.parse
import urllib.request

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
        return r.read().decode('utf-8', errors='ignore')


def extract_og_image(html):
    m = re.search(r'<meta property="og:image" content="([^"]+)"', html)
    return m.group(1) if m else None


def build_wiki_title(name):
    return name.strip().replace(' ', '_')


def normalize_name_for_search(name):
    return re.sub(r'\s*\b(var\.|spp\.|sp\.)\b.*$', '', name, flags=re.I).strip()


def try_wiki_title(title):
    url = 'https://en.wikipedia.org/wiki/' + urllib.parse.quote(title)
    html = fetch_url(url)
    image = extract_og_image(html)
    return image, url


def search_wiki(query):
    search_url = 'https://en.wikipedia.org/w/index.php?search=' + urllib.parse.quote(query) + '&title=Special%3ASearch&go=Go'
    html = fetch_url(search_url)
    image = extract_og_image(html)
    return image, search_url


results = []
for pid, common, sci in entries:
    candidates = [sci, common]
    normalized = normalize_name_for_search(sci)
    if normalized and normalized != sci:
        candidates.append(normalized)
    normalized_common = normalize_name_for_search(common)
    if normalized_common and normalized_common != common:
        candidates.append(normalized_common)

    thumb = None
    source = None
    tried = []

    for candidate in candidates:
        title = build_wiki_title(candidate)
        tried.append(title)
        try:
            thumb, source = try_wiki_title(title)
            if thumb:
                break
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print('429 limit reached, sleeping 30 seconds...')
                time.sleep(30)
                try:
                    thumb, source = try_wiki_title(title)
                    if thumb:
                        break
                except Exception as e2:
                    print('retry failed', pid, title, e2)
            else:
                print('HTTP error', pid, title, e)
        except Exception as e:
            print('error', pid, title, e)
        time.sleep(2)

    if not thumb:
        for query in [sci, common, normalized_common, normalized]:
            if not query or query in candidates:
                continue
            tried.append(query)
            try:
                thumb, source = search_wiki(query)
                if thumb:
                    break
            except urllib.error.HTTPError as e:
                if e.code == 429:
                    print('429 limit reached during search, sleeping 30 seconds...')
                    time.sleep(30)
                else:
                    print('HTTP error search', pid, query, e)
            except Exception as e:
                print('error search', pid, query, e)
            time.sleep(2)

    if not thumb:
        print('no image found for', pid, common, sci, 'tried:', tried[:5])
    else:
        print(pid, common, sci, '->', thumb)

    results.append({'id': int(pid), 'common_name': common, 'scientific_name': sci, 'image': thumb or '', 'source': source or '', 'tried': tried})
    with open('wiki_html_images.json', 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)

print('saved wiki_html_images.json')
