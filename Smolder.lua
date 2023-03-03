local Smolder = {};
local healthCheck = false;

local function CastFlameBreath(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 23341, true)
end

local function CastCharredEarth(eventId, delay, calls, creature)
local targetCount = creature:GetAITargetsCount()
local randomTarget = math.random(1, targetCount)
local target = creature:GetAITargets()
creature:CastSpell(target[randomTarget], 100148, true)
end

local function CastPyroblast(eventId, delay, calls, creature)
local targets = {}
for i = 1, 3 do
local targetCount = creature:GetAITargetsCount()
local randomTarget = math.random(1, targetCount)
local target = creature:GetAITargets()
table.insert(targets, target[randomTarget])
end
for k, v in pairs(targets) do
creature:CastSpell(v, 27132, true)
end
end

local function CastSummonElemental(eventId, delay, calls, creature)
creature:SendUnitYell("Minions of fire, rise and serve your master!", 0)
creature:PlayDirectSound(20422)
creature:CastSpell(creature, 364728, true)
end

local function CastTailSweep(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 52144, true)
end

local function CastScorch(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 42858, true)
end

local function CastBellowingRoar(eventId, delay, calls, creature)
creature:SendUnitYell("Feel the power of my roar!", 0)
creature:PlayDirectSound(20421)
creature:CastSpell(creature, 22686, true)
end

local function OnEnterCombat(event, creature, target)
creature:SendUnitYell("Feel the heat of my flame and know your end is near!", 0)
creature:PlayDirectSound(20419)
creature:RegisterEvent(CastScorch, 6000, 0)
creature:RegisterEvent(CastFlameBreath, 13000, 0)
creature:RegisterEvent(CastCharredEarth, 12000, 0)
creature:RegisterEvent(CastPyroblast, 10000, 0)
creature:RegisterEvent(CastSummonElemental, 60000, 0)
creature:RegisterEvent(CastTailSweep, 8000, 0)
creature:RegisterEvent(CastBellowingRoar, 33000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:SendUnitYell("My fire...extinguished...", 0)
creature:PlayDirectSound(20420)
creature:RemoveEvents()
end

local function OnDamageTaken(event, creature, attacker, damage)
if (creature:HealthBelowPct(15) and not healthCheck) then
creature:SendUnitYell("My power is waning, but I will fight until my last flame burnsout!", 0)
creature:PlayDirectSound(20423)
healthCheck = true
end
end

RegisterCreatureEvent(83001, 1, OnEnterCombat)
RegisterCreatureEvent(83001, 2, OnLeaveCombat)
RegisterCreatureEvent(83001, 4, OnDied)
RegisterCreatureEvent(83001, 9, OnDamageTaken)



