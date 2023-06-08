#!/usr/bin/env python3

# elements to show:
# Turn into table
# Details-content--hidden-not-important js-navigation-container js-active-navigation-container d-md-block
# ?

modify = {
    'github.com' : [
        ("header", lambda e, soup:
           e.extract()),
        (".Layout-sidebar", lambda e, soup:
           e.extract()),
        (".UnderlineNav-actions", lambda e, soup:
           e.extract()),
        (".js-flash-alert", lambda e, soup:
           e.extract()),
        (".file-navigation", lambda e, soup:
           e.extract()),
        ("footer", lambda e, soup:
           e.extract()),
    ],
}
