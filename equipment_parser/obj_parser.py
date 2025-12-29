from typing import Mapping
from bitvectors import *
from flags import *


def read_tilde_block(lines):
    buf = []
    for line in lines:
        line = line.rstrip("\n")
        if line.endswith("~"):
            buf.append(line[:-1])
            break
        buf.append(line)
    return "\n".join(buf)


def read_ints_line(lines):
    return list(map(int, next(lines).split()))


def parse_obj_file(path):
    objects = {}

    pending_line = None  # one-line lookahead buffer

    with open(path, "r", encoding="utf-8") as f:
        lines = iter(f)

        while True:
            # ---- fetch next line, honoring pushback ----
            if pending_line is not None:
                raw = pending_line
                pending_line = None
            else:
                raw = next(lines, None)

            if raw is None:
                break

            line = raw.strip()

            if not line.startswith("#"):
                continue

            if line.startswith("$"):
                break

            # ---- object header ----
            vnum = int(line[1:])

            namelist   = read_tilde_block(lines)
            short_desc = read_tilde_block(lines)
            long_desc  = read_tilde_block(lines)
            _ = read_tilde_block(lines)  # action desc / unused

            # ---- stats line 1 ----
            stats1 = read_ints_line(lines)

            defaults = [0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0]
            stats1 = (stats1 + defaults)[:11]

            (
                item_type, matl_type, size, space,
                craftsmanship, dmg_resist,
                extra1_flags, wear_flags,
                extra2_flags, anti1_flags, anti2_flags
            ) = stats1

            # ---- stats line 2 ----
            stats2 = read_ints_line(lines)
            stats2 = (stats2 + [0] * 8)[:8]
            item_vals = stats2

            # ---- stats line 3 ----
            stats3 = read_ints_line(lines)
            stats3 = (stats3 + [0] * 7)[:7]

            weight, worth, condition, aff1, aff2, aff3, aff4 = stats3

            # ---- optional E / A sections ----
            extra_desc = []
            affects = []

            while True:
                #peek = next(lines).strip()
                try:
                    peek = next(lines).strip()
                except StopIteration:
                    break                

                if peek == "E":
                    keyword = read_tilde_block(lines)
                    if "_id_name_" in keyword:
                        continue
                    desc = read_tilde_block(lines)
                    extra_desc.append((keyword, desc))

                elif peek == "A":
                    loc, mod = read_ints_line(lines)
                    loc = modifiers_lookup[loc]
                    affects.append((loc, mod))

                else:
                    # push back one line for the outer loop
                    pending_line = peek + "\n"
                    break

            # ---- store object ----
            objects[vnum] = {
                "vnum": vnum,
                "name_list": namelist,
                "short_description": short_desc,
                "long_description": long_desc,
                "item_type": item_type_lookup[item_type],
                "material": material_type_lookup[matl_type],
                "size": item_size_lookup[size],
                "space": space,
                "craftsmanship": craftmanship_lookup[craftsmanship],
                "damage_resist": dmg_resist,
                "wear_flags": decode_wear_flags(wear_flags),
                "extra1_flags": decode_extra_flags(extra1_flags),
                "extra2_flags": decode_extra2_flags(extra2_flags),
                "anti1_flags": decode_class_anti_flags(anti1_flags),
                "anti2_flags": decode_race_anti_flags(anti2_flags),
                "values": item_vals,
                "weight": weight,
                "worth": worth,
                "condition": condition,
                "aff1": decode_aff1_flags(aff1),
                "aff2": decode_aff2_flags(aff2),
                "aff3": decode_aff3_flags(aff3),
                "aff4": decode_aff4_flags(aff4),
                "affects": affects,
                "extra_descriptions": extra_desc,
            }

    return objects