import soupmonkey
import elinks
import os
from rss import feedreader
# pip install feedparser

# TODO: Clean GH, reddit, actually get rid of navbar of most websites

@soupmonkey.inject

def pre_format_html_hook(url, html):
    return html

def goto_url_hook(url):
    if "twitter.com" in url:
        url = url.replace("twitter.com", "nitter.net", 1)

    if "www.reddit.com" in url:
        url = url.replace("www.reddit.com", "old.reddit.com", 1)
    elif "reddit.com" in url:
        url = url.replace("reddit.com", "old.reddit.com", 1)

    return url

elinks.bind_key("!", feedreader)
elinks.bind_key("Ctrl-S", feedreader.menuopener._seen, "menu") # FIXME
