local MakePlayerCharacter = require("prefabs/player_common")

local assets =
{
        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/nightmareplayer.zip" ),
		Asset( "ANIM", "anim/ghost_nightmareplayer_build.zip" ),
}

-- Your character's stats
TUNING.NIGHTMAREPLAYER_HEALTH = 170
TUNING.NIGHTMAREPLAYER_HUNGER = 120
TUNING.NIGHTMAREPLAYER_SANITY = 200
TUNING.NIGHTMAREPLAYER_MAX_PETS = 4

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.NIGHTMAREPLAYER = {
	"nightmarefuel",
    "nightmarefuel",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.NIGHTMAREPLAYER
end
local prefabs = FlattenTree(start_inv, true)

-- When loading or spawning the character
local function OnLoad(inst)
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v.components.sanityaura ~= nil then
            v:RemoveComponent("sanityaura")  
            v:RemoveTag("shadow")
            v:RemoveTag("nightmarecreature")
        end
    end
end

local function common_postinit(inst)
    inst:AddTag("playermonster")
    inst:AddTag("monster")
    inst:AddTag("shadowtamer")

    if TheNet:GetServerGameMode() == "quagmire" then
        inst:AddTag("fastpicker")
        inst:AddTag("quagmire_farmhand")
        inst:AddTag("quagmire_shopper")
    end
end

local function master_postinit(inst)
    -- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    inst:AddComponent("petleash")
    inst.components.petleash:SetMaxPets(TUNING.NIGHTMAREPLAYER_MAX_PETS)

    -- choose which sounds this character will play
    inst.soundsname = "wormwood"

    inst.components.health:SetMaxHealth(TUNING.NIGHTMAREPLAYER_HEALTH)
    inst.components.hunger:SetMax(TUNING.NIGHTMAREPLAYER_HUNGER)
    inst.components.sanity:SetMax(TUNING.NIGHTMAREPLAYER_SANITY)

    -- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

    inst.OnLoad = OnLoad

    --Sanity Swap
    inst.components.sanity.custom_rate_fn = function(inst)
        local dapperness = 0
        local lightval = inst.LightWatcher:GetLightValue()
        
        local day = TheWorld.state.isday and not TheWorld:HasTag("cave")
        local night = TheWorld.state.isnight and not TheWorld:HasTag("cave") 
        if day then
            dapperness = TUNING.SANITY_NIGHT_DARK * 0.2
        elseif night then
            dapperness = TUNING.SANITY_HIGH_LIGHT * 0.5
        else 
            dapperness = TUNING.SANITY_LOW_LIGHT
        end

        if lightval < TUNING.SANITY_LOW_LIGHT then
            dapperness = TUNING.SANITY_NIGHT_DARK * -1.5
        end

    return dapperness
    end

end

return MakePlayerCharacter("nightmareplayer", prefabs, assets, common_postinit, master_postinit)