#!/usr/bin/env bash

windows=$(
    i3-msg -t get_tree | python3 -c '
import json, sys

def walk(node):
    if node.get("window") is not None:
        print(f"{node['"'"'id'"'"']}\t{node.get('"'"'name'"'"') or '"'"'Unnamed'"'"'}")
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        walk(child)

walk(json.load(sys.stdin))
'
)

[ -n "$windows" ] || exit 0

selected=$(printf '%s\n' "$windows" | dmenu -i -l 6 -nb '#121212' -nf '#cdcab1' -sb '#242424' -fn 'monospace:10' -p "Window")
[ -n "$selected" ] || exit 0

id=${selected%%	*}
i3-msg "[con_id=$id] focus"
