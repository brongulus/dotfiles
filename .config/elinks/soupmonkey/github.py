#!/usr/bin/env python3


def border(e, soup):
    e.wrap(soup.new_tag("table"))
    e.parent["border"] = 1
    e.parent["frame"] = "box"
    for x in e.select("div.Box-row"):
        x.wrap(soup.new_tag("td"))
        x.parent["border"] = 1
        x.parent["frame"] = "box"
        x.parent.wrap(soup.new_tag("tr"))

    # General Cleanup
    for elem in soup.find_all("svg"):
        elem.decompose()

    for x in soup.find_all():
        if len(x.get_text(strip=True)) == 0:
            x.extract()


modify = {
    "github.com": [
        ("header", lambda e, soup: e.extract()),
        (".Layout-sidebar", lambda e, soup: e.extract()),
        (".SelectMenu", lambda e, soup: e.extract()),
        (".UnderlineNav-actions", lambda e, soup: e.extract()),
        (".js-flash-alert", lambda e, soup: e.extract()),
        (".file-navigation", lambda e, soup: e.extract()),
        ("footer", lambda e, soup: e.extract()),
        (".js-details-container", border),
    ],
}
