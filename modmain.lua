PrefabFiles = {
	"nightmareplayer",
    "shadowcreature",
    "nightmarecreature",
    "nightmarefuel",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/nightmareplayer.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/nightmareplayer.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/nightmareplayer.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nightmareplayer.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/nightmareplayer_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/nightmareplayer_silho.xml" ),

    Asset( "IMAGE", "bigportraits/nightmareplayer.tex" ),
    Asset( "ATLAS", "bigportraits/nightmareplayer.xml" ),
	
	Asset( "IMAGE", "images/map_icons/nightmareplayer.tex" ),
	Asset( "ATLAS", "images/map_icons/nightmareplayer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_nightmareplayer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_nightmareplayer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_nightmareplayer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_nightmareplayer.xml" ),

}

AddMinimapAtlas("images/map_icons/nightmareplayer.xml")

local require = GLOBAL.require

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.nightmareplayer = "The Nightmare"
GLOBAL.STRINGS.CHARACTER_NAMES.nightmareplayer = "Nightmare"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.nightmareplayer = "*Is a Demon\n*Can Tame the Creatures of Insanity\n*Prefers the Dark"
GLOBAL.STRINGS.CHARACTER_QUOTES.nightmareplayer = "\"Insanity is a Minor Inconvenience\""
GLOBAL.STRINGS.CHARACTER_SURVIVABILITY.nightmareplayer = "Slim"

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.NIGHTMAREPLAYER = require "speech_nightmareplayer"


AddModCharacter("nightmareplayer", "MALE")

--configuration_options = {}

