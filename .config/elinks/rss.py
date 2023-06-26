#!/usr/bin/env python3
import elinks

my_feeds = (
    # "https://lwn.net/headlines/rss",
    # "https://gluer.org/blog/atom.xml",
    "https://lobste.rs/rss",
    # "https://nitter.net/hermitcraft_/rss",
)

# FIXME: Look for nntp support? Fix the seen articles mechanism
class feedreader:

    """RSS/ATOM feed reader."""

    def __init__(self, feeds=my_feeds):
        """Constructor."""
        if elinks.home is None:
            raise elinks.error("Cannot identify unread entries without "
                               "a ~/.config/elinks configuration directory.")
        self._results = {}
        self._entries = {}
        self._feeds = feeds
        for feed in feeds:
            elinks.load(feed, self._callback)

    def _callback(self, header, body):
        """Read a feed, identify unseen entries, and open them in new tabs."""
        import dbm
        import feedparser
        import os

        if not body:
            return
        seen = dbm.open(os.path.join(elinks.home, "rss_seen.db"), "c")
        feed = feedparser.parse(body)
        new = 0
        errors = 0
        prev_seen = 0
        for entry in feed.entries:
            try:
                if entry.link not in seen.keys() or seen[entry.link] != "seen":
                    self._entries[entry.link] = entry.title
                    seen[entry.link] = "" # Does this add to seen?
                    new += 1
                else:
                    # If seen before?
                    prev_seen += 1
            except:
                errors += 1

        seen.close()
        self.menu(feed.channel.title, new, errors, prev_seen)

    def menu(self, title, new, errors, prev_seen):
        """Record and report feed statistics."""
        self._results[title] = (new, errors, prev_seen)
        if len(self._results) == len(self._feeds):
            feeds = self._results.keys()
            # FIXME:
            # feeds.sort()
            width = max([len(title) for title in feeds])
            fmt = "%*s   New: %2d   Errors: %2d  Seen: %2d\n"
            content = ""
            content = []
            for title in feeds:
                new, errors, prev_seen = self._results[title]
                content += [(fmt % (-width, title, new, errors, prev_seen), self.menuopener(""))]

            content += [("-----------------------", self.menuopener(""))]

            for link in self._entries:
                content += [(self._entries[link], self.menuopener(link))]

            elinks.menu(content, elinks.MENU_LINK)

    class menuopener:
        def __init__(self, link):
            self.link = link

        def __call__(self) -> None:
            import dbm
            import os
            # FIXME:
            with dbm.open(os.path.join(elinks.home, "rss_seen.db"), "w") as db:
                if self.link not in db.keys() or db[self.link] != "seen":
                    db[self.link] = "seen"
            db.close()
            if self.link == "":
                return
            return elinks.open(self.link, new_tab=True)

        def _seen(self):
            import dbm
            import os
            with dbm.open(os.path.join(elinks.home, "rss_seen.db"), "c") as db:
                if self.link not in db.keys() or db[self.link] != "seen":
                    db[self.link] = "seen"
            db.close()
