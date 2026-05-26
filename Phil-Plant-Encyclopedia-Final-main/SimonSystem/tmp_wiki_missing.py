import re
import urllib.request
import urllib.parse

USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'

candidates = [
    ('Lygodium circinnatum', ['Lygodium_circinnatum', 'Lygodium', 'Lygodium circinnatum']),
    ('Shorea spp.', ['Shorea', 'Shorea_spp.', 'Lauan']),
    ('Rhizophora spp.', ['Rhizophora', 'Rhizophora_mangle', 'Bakauan']),
    ('Ficus balete', ['Ficus_balete', 'Balete', 'Ficus_alba', 'Ficus']),
    ('Microcos panicula', ['Microcos_panicula', 'Microcos', 'Hagonoy']),
    ('Sandoricum koetjape var.', ['Sandoricum_koetjape', 'Santol']),
    ('Crotalaria spp.', ['Crotalaria', 'Crotalaria_spectabilis', 'Kalingag']),
    ('Cocos nucifera var. sylvestris', ['Cocos_nucifera', 'Cocos_nucifera_var._sylvestris', 'Coconut_(wild)']),
    ('Ricinus communis var. medicinalis', ['Ricinus_communis', 'Ricinus_communis_var._medicinalis', 'Tuba-tuba_(medicinal)']),
    ('Psidium guajava var. bayabas', ['Psidium_guajava', 'Bayabas', 'Psidium_guajava_var._bayabas']),
]

def fetch(url):
    req = urllib.request.Request(url, headers={'User-Agent': USER_AGENT})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read().decode('utf-8', errors='ignore')


def og_image(html):
    m = re.search(r'<meta property="og:image" content="([^"]+)"', html)
    return m.group(1) if m else None

for name, titles in candidates:
    print('---', name)
    for title in titles:
        url = 'https://en.wikipedia.org/wiki/' + urllib.parse.quote(title)
        try:
            html = fetch(url)
            img = og_image(html)
            print(title, '->', img)
        except Exception as e:
            print(title, 'ERR', e)
    # search if needed
    search_url = 'https://en.wikipedia.org/w/index.php?search=' + urllib.parse.quote(name) + '&title=Special%3ASearch&go=Go'
    try:
        html = fetch(search_url)
        img = og_image(html)
        print('search', search_url, '->', img)
    except Exception as e:
        print('search ERR', e)
