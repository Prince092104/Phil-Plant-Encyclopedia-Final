import re
import urllib.request

USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'

titles = ['Jasminum_sambac', 'Pinus_kesiya', 'Hibiscus_rosa-sinensis', 'Vanda_sanderiana', 'Cananga_odorata']
for title in titles:
    url = f'https://en.wikipedia.org/wiki/{title}'
    req = urllib.request.Request(url, headers={'User-Agent': USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            html = r.read().decode('utf-8', errors='ignore')
        m = re.search(r'<meta property="og:image" content="([^"]+)"', html)
        print(title, '->', m.group(1) if m else 'NONE')
    except Exception as e:
        print(title, 'ERR', e)
