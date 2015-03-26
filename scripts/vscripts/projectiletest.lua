function GetDistanceBetweenTwoVec2D(a, b)
    local xx = (a.x-b.x)
    local yy = (a.y-b.y)
    return math.sqrt(xx*xx + yy*yy)
end

function GetRadBetweenTwoVec2D(a,b)
	local y = b.y - a.y
	local x = b.x - a.x
	return math.atan2(y,x)
end

function PrintTable(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end
function shemejiba(keys)
	print("1")
local caster = keys.caster
local vecCaster = caster:GetOrigin() 
PrintTable(keys)
local point = keys.target_points[1]
local targetPoint = point
local pointRad = GetRadBetweenTwoVec2D(vecCaster,targetPoint)
local pointRad1 = pointRad + math.pi * (keys.DamageRad/180)
local pointRad2 = pointRad - math.pi * (keys.DamageRad/180)
local forwardVec = Vector( math.cos(pointRad)*2000,math.sin(pointRad)*2000,0)
local knifeTable = {
	Ability = keys.ability,
	fDistance = keys.DamageRadius,--这里改距离
	fStartRadius = 120,
	fEndRadius = 120,
	Source = caster,
	bHasFrontalCone = false,
	bRepalceExisting = false,
	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_NONE,
	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
	fExpireTime = GameRules:GetGameTime()+10,
	bDeleteOnHit = true,
	vVelocity = forwardVec,
	bProvidesVision =true,
	iVisionRadius = 400,
	iVisionTeamNumber = caster: GetTeamNumber(),
	vSpawnOrigin = vecCaster,
	EffectName = "particles/gyro_base_attack.vpcf"
}

local projectfile = ProjectileManager:CreateLinearProjectile(knifeTable)
print("1",keys.ability)

end

function laser_boost(keys)
    local caster = keys.caster
  
     local forward = caster:GetForwardVector()*99999+caster:GetOrigin()
    local particleID = ParticleManager:CreateParticle("particles/chen_cast_4.vpcf",PATTACH_EYES_FOLLOW,caster)
    ParticleManager:SetParticleControl(particleID,0,caster:GetOrigin()+Vector(0,0,64))
    ParticleManager:SetParticleControl(particleID,1,forward)
    local caster = keys.caster
    local vecCaster = caster:GetOrigin() 
    PrintTable(keys)
    local point = forward
    local targetPoint = point
    local pointRad = GetRadBetweenTwoVec2D(vecCaster,targetPoint)
    local pointRad1 = pointRad + math.pi * (keys.DamageRad/180)
    local pointRad2 = pointRad - math.pi * (keys.DamageRad/180)
    local forwardVec = Vector( math.cos(pointRad)*20000,math.sin(pointRad)*20000,0)
    local knifeTable = {
    Ability = keys.ability,
    fDistance = keys.DamageRadius,--这里改距离
    fStartRadius = 200,
    fEndRadius = 200,
    Source = caster,
    bHasFrontalCone = false,
    bRepalceExisting = false,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
    fExpireTime = GameRules:GetGameTime()+10,
    bDeleteOnHit = true,
    vVelocity = forwardVec,
    bProvidesVision =true,
    iVisionRadius = 400,
    iVisionTeamNumber = caster: GetTeamNumber(),
    vSpawnOrigin = vecCaster,
    EffectName = ""
    }

    local projectfile = ProjectileManager:CreateLinearProjectile(knifeTable)
   --[[Returns:void
    Set the orientation of the entity to have this forward ''forwardVec''
    ]]
end














--[[
"pom_Elune_Arrow"
	{
		"BaseClass"				"ability_datadriven"
		"AbilityBehavior"		"DOTA_ABILITY_BEHAVIOR_POINT"
		"AbilityUnitDamageType"	"DAMAGE_TYPE_MAGICAL"
		//"AbilityTextureName"	"lina_dragon_slave"

		"AbilityCastPoint"      "0"
		//"AbilityCastAnimation"	"ACT_DOTA_CAST_ABILITY_1"

		"AbilityCooldown"       "0"

		"precache" //缓存特效
        {
            "particle"       "particles/gyro_base_attack.vpcf"
        }

		"OnSpellStart"
		{
			"RunScript"
			{
				"ScriptFile"		"scripts/vscripts/projectiletest.lua"
				"Function"			"shemejiba"
				"DamageRad"			"2000"
				"DamageRadius"		"2000"
				"Target"			"POINT"
			}
		}

		//在RunScript中通过Lua施放了线性投射物，这里可以响应命中目标
		"OnProjectileHitUnit"  
        {
        	"DeleteOnHit"        "1"  //命中之后不删除投射物
        	"Damage"//这里改成Script
        	{
        		"Damage"		"999999"
        		"Target"		"TARGET"
        		"Type"			"DAMAGE_TYPE_PURE"
        	}
        }
        "AbilitySpecial"
		{
			"01"  //距离
			{
				"var_type"		"FIELD_INTEGER"
				"distance"		"1500"
			}
		}

	}
]]