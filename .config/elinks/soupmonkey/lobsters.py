#!/usr/bin/env python3
def lobsters_padding(e, soup):
    e['border'] = 1
    e['frame'] = 'void'
    e['rules'] = 'cols'
    for x in e.select('ol li.comments_subtree'):
        level = int(x.img['width']) / 40
        for y in range(int(level)):
            td = soup.new_tag('td')
            x.parent.insert(1, td)
        x.decompose()

def lobsters_votelink(e, soup):
    for x in e.select('.upvoter'):
        x.replacewith(soup.new_string('▲'))
    if e.parent.select('.default'):
        e.parent.insert(0, e)

def lobsters_header(e, soup):
    e['border'] = 1
    e['frame'] = 'box'

# LUL

modify = {
    'lobste.rs' : [
        # remove logo
        # ('img[src="y18.gif"]', lambda e, soup:
        #     e.parent.parent.decompose()),
        # nicer header
        ('#inside', lobsters_header),
        # indentation of comments
        # ('li.comments_subtree ol.comments', lobsters_padding),
        # vote arrows
        ('.upvoter', lobsters_votelink),
    ],
}
