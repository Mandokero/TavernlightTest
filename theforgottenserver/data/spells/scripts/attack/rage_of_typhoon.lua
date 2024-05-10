local combat = Combat() -- Used the rage_of_the_skies code as reference

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
-- Added this for Q5. Custom Spell area. Frankly online documentation on how these spells work is very sparse and obtuse.
local area = {
    {0, 0, 0, 1, 0, 0, 0}, {0, 0, 1, 0, 1, 0, 0}, {0, 1, 0, 1, 0, 1, 0},
    {1, 0, 1, 2, 1, 0, 1}, {0, 1, 0, 1, 0, 1, 0}, {0, 0, 1, 0, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0}
}

combat:setArea(createCombatArea(area))

function onGetFormulaValues(player, level, magicLevel)
    local min = (level / 5) + (magicLevel * 4) + 75
    local max = (level / 5) + (magicLevel * 10) + 150
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant) return combat:execute(creature, variant) end
