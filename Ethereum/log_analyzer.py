# -*- coding: utf-8 -*-

import sys
import re
import json

block_reached_canonical_chain = re.compile("block reached canonical chain")
mined_potential_block = re.compile("mined potential block")
successfully_sealed_new_block = re.compile("Successfully sealed new block")



def match_elapsed_vals(line):
    elapsedMatch = re.compile("elapsed=(\d+\.\d+)(\S+)").search(line)
    elapsed = elapsedMatch.group(1)
    elapsed_unit = elapsedMatch.group(2)

    return {
        'elapsed': float(elapsed),
        'elapsed_unit': elapsed_unit,
    }


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
    elif mined_potential_block.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        hash = re.compile("hash=([0-9a-z]+)…([0-9a-z]+)").search(line)
        hash_start = hash.group(1)
        hash_end = hash.group(2)
        if number and hash:
            print json.dumps({
                'event_type': 'mined_potential_block',
                'number': int(number),
                'hash_start': hash_start,
                'hash_end': hash_end,
            })
    elif successfully_sealed_new_block.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        sealhash = re.compile("sealhash=([0-9a-z]+)…([0-9a-z]+)").search(line)
        sealhash_start = sealhash.group(1)
        sealhash_end = sealhash.group(2)
        hash = re.compile("hash=([0-9a-z]+)…([0-9a-z]+)").search(line)
        hash_start = hash.group(1)
        hash_end = hash.group(2)

        elapsed_vals = match_elapsed_vals(line)  
        if number and sealhash and elapsed_vals:
            rval = {
                'event_type': 'successfully_sealed_new_block',
                'number': int(number),
                'sealhash_start': sealhash_start,
                'sealhash_end': sealhash_end,
                'hash_start': hash_start,
                'hash_end': hash_end
            }
            rval.update(elapsed_vals)
            print json.dumps(rval)
        else:
            raise Exception('failure parsing successfully_sealed_new_block')
