from typing import Mapping


def BIT(n: int) -> int:
    return 1 << (n - 1)
    
ITEM_AFF_FLAGS = {
    "AFF_NONE":                 0,
    "AFF_BLIND":                BIT(1),
    "AFF_INVISIBLE":            BIT(2),
    "AFF_FARSEE":               BIT(3),
    "AFF_DETECT_INVISIBLE":     BIT(4),
    "AFF_HASTE":                BIT(5),
    "AFF_SENSE_LIFE":           BIT(6),
    "AFF_MINOR_GLOBE":          BIT(7),
    "AFF_STONE_SKIN":           BIT(8),
    "AFF_UD_VISION":            BIT(9),
    "AFF_ARMOR":                BIT(10),
    "AFF_WRAITHFORM":           BIT(11),
    "AFF_WATERBREATH":          BIT(12),
    "AFF_KNOCKED_OUT":          BIT(13),
    "AFF_PROTECT_EVIL":         BIT(14),
    "AFF_BOUND":                BIT(15),
    "AFF_SLOW_POISON":          BIT(16),
    "AFF_PROTECT_GOOD":         BIT(17),
    "AFF_SLEEP":                BIT(18),
    "AFF_SKILL_AWARE":          BIT(19),
    "AFF_SNEAK":                BIT(20),
    "AFF_HIDE":                 BIT(21),
    "AFF_FEAR":                 BIT(22),
    "AFF_CHARM":                BIT(23),
    "AFF_MEDITATE":             BIT(24),
    "AFF_BARKSKIN":             BIT(25),
    "AFF_INFRAVISION":          BIT(26),
    "AFF_LEVITATE":             BIT(27),
    "AFF_FLY":                  BIT(28),
    "AFF_AWARE":                BIT(29),
    "AFF_PROT_FIRE":            BIT(30),
    "AFF_CAMPING":              BIT(31),
    "AFF_BIOFEEDBACK":          BIT(32),
    "AFF_INFERNAL_FURY":        BIT(33),
    "AFF_FREEDOM_OF_MVMNT":     BIT(34),
    "AFF_SANCTUM_DRACONIS":     BIT(35)
}

ITEM_AFF2_FLAGS = {
    "AFF2_FIRESHIELD":          BIT(1),
    "AFF2_ULTRAVISION":         BIT(2),
    "AFF2_DETECT_EVIL":         BIT(3),
    "AFF2_DETECT_GOOD":         BIT(4),
    "AFF2_DETECT_MAGIC":        BIT(5),
    "AFF2_MAJOR_PHYSICAL":      BIT(6),
    "AFF2_PROT_COLD":           BIT(7),
    "AFF2_PROT_LIGHTNING":      BIT(8),
    "AFF2_MINOR_PARALYSIS":     BIT(9),
    "AFF2_MAJOR_PARALYSIS":     BIT(10),
    "AFF2_SLOW":                BIT(11),
    "AFF2_GLOBE":               BIT(12),
    "AFF2_PROT_GAS":            BIT(13),
    "AFF2_PROT_ACID":           BIT(14),
    "AFF2_POISONED":            BIT(15),
    "AFF2_SOULSHIELD":          BIT(16),
    "AFF2_SILENCED":            BIT(17),
    "AFF2_MINOR_INVIS":         BIT(18),
    "AFF2_VAMPIRIC_TOUCH":      BIT(19),
    "AFF2_STUNNED":             BIT(20),
    "AFF2_EARTH_AURA":          BIT(21),
    "AFF2_WATER_AURA":          BIT(22),
    "AFF2_FIRE_AURA":           BIT(23),
    "AFF2_AIR_AURA":            BIT(24),
    "AFF2_HOLDING_BREATH":      BIT(25),
    "AFF2_MEMORIZING":          BIT(26),
    "AFF2_IS_DROWNING":         BIT(27),
    "AFF2_PASSDOOR":            BIT(28),
    "AFF2_FLURRY":              BIT(29),
    "AFF2_CASTING":             BIT(30),
    "AFF2_SCRIBING":            BIT(31),
    "AFF2_HUNTER":              BIT(32)
}

ITEM_AFF3_FLAGS = {
    "AFF3_TENSORS_DISC":        BIT(1),
    "AFF3_TRACKING":            BIT(2),
    "AFF3_SINGING":             BIT(3),
    "AFF3_ECTOPLASMIC_FORM":    BIT(4),
    "AFF3_ABSORBING":           BIT(5),
    "AFF3_PROT_ANIMAL":         BIT(6),
    "AFF3_SPIRIT_WARD":         BIT(7),
    "AFF3_GR_SPIRIT_WARD":      BIT(8),
    "AFF3_NON_DETECTION":       BIT(9),
    "AFF3_SILVER":              BIT(10),
    "AFF3_PLUSONE":             BIT(11),
    "AFF3_PLUSTWO":             BIT(12),
    "AFF3_PLUSTHREE":           BIT(13),
    "AFF3_PLUSFOUR":            BIT(14),
    "AFF3_PLUSFIVE":            BIT(15),
    "AFF3_ENLARGE":             BIT(16),
    "AFF3_REDUCE":              BIT(17),
    "AFF3_COVER":               BIT(18),
    "AFF3_FOUR_ARMS":           BIT(19),
    "AFF3_INERTIAL_BARRIER":    BIT(20),
    "AFF3_LIGHTNINGSHIELD":     BIT(21),
    "AFF3_COLDSHIELD":          BIT(22),
    "AFF3_CANNIBALIZE":         BIT(23),
    "AFF3_SWIMMING":            BIT(24),
    "AFF3_TOWER_IRON_WILL":     BIT(25),
    "AFF3_UNDERWATER":          BIT(26),
    "AFF3_BLUR":                BIT(27),
    "AFF3_ENHANCE_HEALING":     BIT(28),
    "AFF3_ELEMENTAL_FORM":      BIT(29),
    "AFF3_PASS_WITHOUT_TRACE":  BIT(30),
    "AFF3_PALADIN_AURA":        BIT(31),
    "AFF3_FAMINE":              BIT(32),
    "AFF3_VIVERNAE_CONCORDIA":  BIT(33)
}


ITEM_AFF4_FLAGS = {
    "AFF4_LOOTER":                  BIT(1),
    "AFF4_CARRY_PLAGUE":            BIT(2),
    "AFF4_SACKING":                 BIT(3),
    "AFF4_SENSE_FOLLOWER":          BIT(4),
    "AFF4_STORNOGS_SPHERES":        BIT(5),
    "AFF4_STORNOGS_GREATER_SPHERES":BIT(6),
    "AFF4_VAMPIRE_FORM":            BIT(7),
    "AFF4_NO_UNMORPH":              BIT(8),
    "AFF4_HOLY_SACRIFICE":          BIT(9),
    "AFF4_BATTLE_ECSTASY":          BIT(10),
    "AFF4_DAZZLER":                 BIT(11),
    "AFF4_PHANTASMAL_FORM":         BIT(12),
    "AFF4_NOFEAR":                  BIT(13),
    "AFF4_REGENERATION":            BIT(14),
    "AFF4_DEAF":                    BIT(15),
    "AFF4_BATTLETIDE":              BIT(16),
    "AFF4_EPIC_INCREASE":           BIT(17),
    "AFF4_MAGE_FLAME":              BIT(18),
    "AFF4_GLOBE_OF_DARKNESS":       BIT(19),
    "AFF4_DEFLECT":                 BIT(20),
    "AFF4_HAWKVISION":              BIT(21),
    "AFF4_MULTI_CLASS":             BIT(22),
    "AFF4_SANCTUARY":               BIT(23),
    "AFF4_HELLFIRE":                BIT(24),
    "AFF4_SENSE_HOLINESS":          BIT(25),
    "AFF4_PROT_LIVING":             BIT(26),
    "AFF4_DETECT_ILLUSION":         BIT(27),
    "AFF4_ICE_AURA":                BIT(28),
    "AFF4_REV_POLARITY":            BIT(29),
    "AFF4_NEG_SHIELD":              BIT(30),
    "AFF4_TUPOR":                   BIT(31),
    "AFF4_WILDMAGIC":               BIT(32)
}


ITEM_AFF5_FLAGS = {
    "AFF5_DAZZLEE":             BIT(1),
    "AFF5_MENTAL_ANGUISH":      BIT(2),
    "AFF5_MEMORY_BLOCK":        BIT(3),
    "AFF5_VINES":               BIT(4),
    "AFF5_ETHEREAL_ALLIANCE":   BIT(5),
    "AFF5_BLOOD_SCENT":         BIT(6),
    "AFF5_FLESH_ARMOR":         BIT(7),
    "AFF5_WET":                 BIT(8),
    "AFF5_HOLY_DHARMA":         BIT(9),
    "AFF5_ENH_HIDE":            BIT(10),
    "AFF5_LISTEN":              BIT(11),
    "AFF5_PROT_UNDEAD":         BIT(12),
    "AFF5_IMPRISON":            BIT(13),
    "AFF5_TITAN_FORM":          BIT(14),
    "AFF5_DELIRIUM":            BIT(15),
    "AFF5_SHADE_MOVEMENT":      BIT(16),
    "AFF5_NOBLIND":             BIT(17),
    "AFF5_MAGICAL_GLOW":        BIT(18),
    "AFF5_REFRESHING_GLOW":     BIT(19),
    "AFF5_MINE":                BIT(20),
    "AFF5_STANCE_OFFENSIVE":    BIT(21),
    "AFF5_STANCE_DEFENSIVE":    BIT(22),
    "AFF5_OBSCURING_MIST":      BIT(23),
    "AFF5_NOT_OFFENSIVE":       BIT(24),
    "AFF5_DECAYING_FLESH":      BIT(25),
    "AFF5_DREADNAUGHT":         BIT(26),
    "AFF5_FOREST_SIGHT":        BIT(27),
    "AFF5_THORNSKIN":           BIT(28),
    "AFF5_FOLLOWING":           BIT(29),
    "AFF5_ORDERING":            BIT(30),
    "AFF5_STONED":              BIT(31),
    "AFF5_JUDICIUM_FIDEI":      BIT(32)
}


ITEM_EXTRA_FLAGS = {
    "ITEM_GLOW":            BIT(1),
    "ITEM_NOSHOW":          BIT(2),
    "ITEM_BURIED":          BIT(3),
    "ITEM_NOSELL":          BIT(4),
    "ITEM_CAN_THROW2":      BIT(5),
    "ITEM_INVISIBLE":       BIT(6),
    "ITEM_NOREPAIR":        BIT(7),
    "ITEM_NODROP":          BIT(8),
    "ITEM_RETURNING":       BIT(9),
    "ITEM_ALLOWED_RACES":   BIT(10),
    "ITEM_ALLOWED_CLASSES": BIT(11),
    "ITEM_PROCLIB":         BIT(12),
    "ITEM_SECRET":          BIT(13),
    "ITEM_FLOAT":           BIT(14),
    "ITEM_NORESET":         BIT(15),
    "ITEM_NOLOCATE":        BIT(16),
    "ITEM_NOIDENTIFY":      BIT(17),
    "ITEM_NOSUMMON":        BIT(18),
    "ITEM_LIT":             BIT(19),
    "ITEM_TRANSIENT":       BIT(20),
    "ITEM_NOSLEEP":         BIT(21),
    "ITEM_NOCHARM":         BIT(22),
    "ITEM_TWOHANDS":        BIT(23),
    "ITEM_NORENT":          BIT(24),
    "ITEM_CAN_THROW1":      BIT(25),
    "ITEM_HUM":             BIT(26),
    "ITEM_LEVITATES":       BIT(27),
    "ITEM_IGNORE":          BIT(28),
    "ITEM_ARTIFACT":        BIT(29),
    "ITEM_WHOLE_BODY":      BIT(30),
    "ITEM_WHOLE_HEAD":      BIT(31),
    "ITEM_ENCRUSTED":       BIT(32),
}

ITEM_EXTRA2_FLAGS = {
    "ITEM2_SILVER":        BIT(1),   # Item harm AFF_SILVER
    "ITEM2_BLESS":         BIT(2),
    "ITEM2_SLAY_GOOD":     BIT(3),
    "ITEM2_SLAY_EVIL":     BIT(4),
    "ITEM2_SLAY_UNDEAD":   BIT(5),
    "ITEM2_SLAY_LIVING":   BIT(6),
    "ITEM2_MAGIC":         BIT(7),
    "ITEM2_LINKABLE":      BIT(8),   # Makes an item linkable by a player
    "ITEM2_NOPROC":        BIT(9),
    "ITEM2_NOTIMER":       BIT(10),
    "ITEM2_NOLOOT":        BIT(11),
    "ITEM2_CRUMBLELOOT":   BIT(12),
    "ITEM2_STOREITEM":     BIT(13),  # Item bought from a shop
    "ITEM2_SOULBIND":      BIT(14),  # Item is soulbound
    "ITEM2_CRAFTED":       BIT(15),
    "ITEM2_QUESTITEM":     BIT(16),
    "ITEM2_TRANSPARENT":   BIT(17),  # Item shows contents when looked at
}


ITEM_WEAR_FLAGS = {
    "ITEM_NONE":            0,
    "ITEM_TAKE":            BIT(1),
    "ITEM_WEAR_FINGER":     BIT(2),
    "ITEM_WEAR_NECK":       BIT(3),
    "ITEM_WEAR_BODY":       BIT(4),
    "ITEM_WEAR_HEAD":       BIT(5),
    "ITEM_WEAR_LEGS":       BIT(6),
    "ITEM_WEAR_FEET":       BIT(7),
    "ITEM_WEAR_HANDS":      BIT(8),
    "ITEM_WEAR_ARMS":       BIT(9),
    "ITEM_WEAR_SHIELD":     BIT(10),
    "ITEM_WEAR_ABOUT":      BIT(11),
    "ITEM_WEAR_WAIST":      BIT(12),
    "ITEM_WEAR_WRIST":      BIT(13),
    "ITEM_WIELD":           BIT(14),
    "ITEM_HOLD":            BIT(15),
    "ITEM_THROW":           BIT(16),
    "ITEM_LIGHT_SOURCE":    BIT(17),
    "ITEM_WEAR_EYES":       BIT(18),
    "ITEM_WEAR_FACE":       BIT(19),
    "ITEM_WEAR_EARRING":    BIT(20),
    "ITEM_WEAR_QUIVER":     BIT(21),
    "ITEM_GUILD_INSIGNIA":  BIT(22),
    "ITEM_WEAR_BACK":       BIT(23),
    "ITEM_ATTACH_BELT":     BIT(24),
    "ITEM_HORSE_BODY":      BIT(25),
    "ITEM_WEAR_TAIL":       BIT(26),
    "ITEM_WEAR_NOSE":       BIT(27),
    "ITEM_WEAR_HORN":       BIT(28),
    "ITEM_WEAR_IOUN":       BIT(29),
    "ITEM_SPIDER_BODY":     BIT(30),
}


CLASS_NAMES = [
    "ALL",
    "Warrior",
    "Ranger",
    "Psionicist",
    "Paladin",
    "AntiPaladin",
    "Cleric",
    "Monk",
    "Druid",
    "Shaman",
    "Sorcerer",
    "Necromancer",
    "Conjurer",
    "Rogue",
    "Assassin",
    "Mercenary",
    "Bard",
    "Thief",
    "Warlock",
    "MindFlayer",
    "Alchemist",
    "Berserker",
    "Reaver",
    "Illusionist",
    "Blighter",
    "Dreadlord",
    "Ethermancer",
    "Avenger",
    "Theurgist",
    "Summoner",
    "Dragoon",
]


RACE_NAMES = [
    "HUMAN",
    "BARBARIAN",
    "DROW",
    "GREY",
    "MOUNTAIN",
    "DUERGAR",
    "HALFLING",
    "GNOME",
    "OGRE",
    "TROLL",
    "HALFELF",
    "ILLITHID",
    "ORC",
    "THRIKREEN",
    "CENTAUR",
    "GITHYANKI",
    "MINOTAUR",
    "SHADE",
    "REVENANT",
    "GOBLIN",
    "LICH",
    "PVAMPIRE",
    "PDKNIGHT",
    "PSBEAST",
    "SGIANT",
    "WIGHT",
    "PHANTOM",
    "HARPY",
    "OROG",
    "GITHZERAI",
    "DRIDER",
    "KOBOLD",
    "PILLITHID",
    "KUOTOA",
    "WOODELF",
    "FIRBOLG",
    "TIEFLING",
]

TOTEM_SPHERES = [
    "TOTEM_LESS_ANIM",      #1     // Lesser Animal
    "TOTEM_GR_ANIM",        #2     // Greater Animal
    "TOTEM_LESS_ELEM",      #4     // Lesser Elemental
    "TOTEM_GR_ELEM",        #8     // Greater Elemental
    "TOTEM_LESS_SPIR",      #16    // Lesser Spirit
    "TOTEM_GR_SPIR"         #32    // Greater Spirit
]

TOTEM_SPHERE_FLAGS = {
    f"{cls.upper()}": BIT(i + 1)
    for i, cls in enumerate(TOTEM_SPHERES)
}

ITEM_CLASS_ANTI_FLAGS = {
    f"{cls.upper()}": BIT(i + 1)
    for i, cls in enumerate(CLASS_NAMES)
}


ITEM_ANTI2_FLAGS = {
    f"{race}": BIT(i + 1)
    for i, race in enumerate(RACE_NAMES)
}


def decode_flags(
    mask: int,
    flags: Mapping[str, int],
    *,
    skip_zero: bool = False,
) -> list[str]:
    return [
        name
        for name, bit in flags.items()
        if (not skip_zero or bit != 0) and (mask & bit)
    ]

def decode_totem_sphere_flags(mask: int) -> list[str]:
    return decode_flags(mask, TOTEM_SPHERE_FLAGS, skip_zero=True)


def decode_wear_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_WEAR_FLAGS, skip_zero=True)


def decode_class_anti_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_CLASS_ANTI_FLAGS)


def decode_race_anti_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_ANTI2_FLAGS)


def decode_extra_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_EXTRA_FLAGS)


def decode_extra2_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_EXTRA2_FLAGS)


def decode_aff1_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_AFF_FLAGS, skip_zero=True)

def decode_aff2_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_AFF2_FLAGS, skip_zero=True)


def decode_aff3_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_AFF3_FLAGS, skip_zero=True)


def decode_aff4_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_AFF4_FLAGS, skip_zero=True)
                        

def decode_aff5_flags(mask: int) -> list[str]:
    return decode_flags(mask, ITEM_AFF5_FLAGS, skip_zero=True)

def has_wear_flag(mask: int, flag_name: str) -> bool:
    return bool(mask & ITEM_WEAR_FLAGS[flag_name])

def set_wear_flag(mask: int, flag_name: str) -> int:
    return mask | ITEM_WEAR_FLAGS[flag_name]

def remove_wear_flag(mask: int, flag_name: str) -> int:
    return mask & ~ITEM_WEAR_FLAGS[flag_name]