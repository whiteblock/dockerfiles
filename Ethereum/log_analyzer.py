# -*- coding: utf-8 -*-

import sys
import re
import json

block_reached_canonical_chain = re.compile("block reached canonical chain")
mined_potential_block = re.compile("mined potential block")
successfully_sealed_new_block = re.compile("Successfully sealed new block")
commit_new_mining_work = re.compile("Commit new mining work")

def match_elapsed_vals(line):
    elapsedMatch = re.compile("elapsed=(\d+\.\d+)(\S+)").search(line)
    elapsed = elapsedMatch.group(1)
    elapsed_unit = elapsedMatch.group(2)
    return {
        'elapsed': float(elapsed),
        'elapsed_unit': elapsed_unit,
    }
def match_hash_vals(hash_key_name, line):
    hash = re.compile("{}=([0-9a-z]+)…([0-9a-z]+)".format(hash_key_name)).search(line)
    hash_start = hash.group(1)
    hash_end = hash.group(2)
    return {
        '{}_start'.format(hash_key_name): hash_start,
        '{}_end'.format(hash_key_name): hash_end
    }

for line in sys.stdin:
    if block_reached_canonical_chain.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        hash_vals = match_hash_vals('hash', line)
        if number and hash_vals:
            rval = {
                'event_type': 'block_reached_canonical_chain',
                'number': int(number)
            }
            rval.update(hash_vals)
            print json.dumps(rval)
        else:
            raise Exception('failure parsing block_reached_canonical_chain')  
    elif mined_potential_block.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        hash_vals = match_hash_vals('hash', line)
        if number and hash_vals:
            rval = {
                'event_type': 'mined_potential_block',
                'number': int(number)
            }
            rval.update(hash_vals)
            print json.dumps(rval)
        else:
            raise Exception('failure parsing mined_potential_block')
    elif successfully_sealed_new_block.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        sealhash_vals = match_hash_vals('sealhash', line)
        hash_vals = match_hash_vals('hash', line)
        elapsed_vals = match_elapsed_vals(line)  
        if number and hash_vals and sealhash_vals and elapsed_vals:
            rval = {
                'event_type': 'successfully_sealed_new_block',
                'number': int(number)
            }
            rval.update(elapsed_vals)
            rval.update(hash_vals)
            rval.update(sealhash_vals)
            print json.dumps(rval)
        else:
            raise Exception('failure parsing successfully_sealed_new_block')
    elif commit_new_mining_work.search(line):
        number = re.compile("number=(\d+)").search(line).group(1)
        uncles = re.compile("uncles=(\d+)").search(line).group(1)
        txs = re.compile("txs=(\d+)").search(line).group(1)
        gas = re.compile("gas=(\d+)").search(line).group(1)
        fees = re.compile("fees=(\d+)").search(line).group(1)
        sealhash_vals = match_hash_vals('sealhash', line)
        elapsed_vals = match_elapsed_vals(line)  
        if number and uncles and txs and gas and fees and sealhash_vals and elapsed_vals:
            rval = {
                'event_type': 'commit_new_ming_work',
                'number': int(number),
                'uncles': int(uncles),
                'txs': int(txs),
                'gas': int(gas),
                'fees': int(fees)
            }
            rval.update(elapsed_vals)
            rval.update(sealhash_vals)
            print json.dumps(rval)
        else:
            raise Exception('failure parsing successfully_sealed_new_block')        
