# -*- coding: utf-8 -*-

import sys
import re
import json

block_reached_canonical_chain = re.compile("block reached canonical chain")

for line in sys.stdin:
    if block_reached_canonical_chain.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        hash = re.compile("hash=([0-9a-z]+)…([0-9a-z]+)").search(line)
        hash_start = hash.group(1)
        hash_end = hash.group(2)
        if number and hash:
            print json.dumps({
                'event_type': 'block_reached_canonical_chain',
                'number': int(number),
                'hash_start': hash_start,
                'hash_end': hash_end,

            })
        