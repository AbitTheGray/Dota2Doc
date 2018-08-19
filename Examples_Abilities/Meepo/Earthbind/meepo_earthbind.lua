meepo_earthbind = class( AbilityBaseClass )

LinkLuaModifier( "modifier_meepo_earthbind", "abilities/meepo/meepo_earthbind.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

if IsServer() then

  function meepo_earthbind:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorPosition()

    local direction = (target - caster:GetAbsOrigin()):Normalized()

    local info =
    {
      Ability = self,
      EffectName = "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf",
      vSpawnOrigin = caster:GetAbsOrigin(),
      fDistance = (target - caster:GetAbsOrigin()):Length2D(),
      fStartRadius = 0,
      fEndRadius = 0,
      Source = caster,
      bHasFrontalCone = false,
      bReplaceExisting = false,
      iUnitTargetTeam = self:GetAbilityTargetTeam(),
      iUnitTargetType = self:GetAbilityTargetType(),
      iUnitTargetFlags = self:GetAbilityTargetFlags(),
      bDeleteOnHit = true,
      vVelocity = direction * self:GetSpecialValueFor("speed"),
      bProvidesVision = false
    }

    return ProjectileManager:CreateLinearProjectile(info)
  end

--------------------------------------------------------------------------------

  function meepo_earthbind:OnProjectileHit(target, location, data)
    -- Cannot hit any unit to reach maximum distance (or map border)
    if target ~= nil then
      return false
    end

    local caster = self:GetCaster()

    local units = FindUnitsInRadius(caster:GetTeamNumber(),
      position,
      nil,
      self:GetSpecialValueFor("radius"),
      self:GetAbilityTargetTeam(),
      self:GetAbilityTargetType(),
      self:GetAbilityTargetFlags(),
      FIND_CLOSEST,
      false)
    if #units == 0 then
      return
    end

    -- Catch units in net
    local duration = self:GetSpecialValueFor("duration")
    for i=0,#units-1 do
      local unit = units[i]
      -- Do not damage spell-immune units
      if unit ~= nil and ( not unit:IsSpellImmune() ) then
        -- Apply new modifier
        unit:AddNewModifier(caster, self, "modifier_meepo_earthbind", {
          duration = duration
        })
      end
    end

    return true
  end

end

--------------------------------------------------------------------------------

modifier_meepo_earthbind = class( ModifierBaseClass )

function modifier_meepo_earthbind:IsHidden()
  return false
end

function modifier_meepo_earthbind:IsPurgable()
  return true
end

function modifier_meepo_earthbind:DestroyOnExpire()
  return true
end

function modifier_meepo_earthbind:IsDebuff()
  return true
end

function modifier_meepo_earthbind:GetAttributes()
  return MODIFIER_ATTRIBUTE_NONE
end

function modifier_spellbender_redirect_source:GetPriority()
  return MODIFIER_PRIORITY_HIGH -- Prevent most ivisibilities
end

function modifier_lina_light_strike_array_lua:CheckState()
	return {
	   [MODIFIER_STATE_ROOTED] = true,
     [MODIFIER_STATE_INVISIBLE] = false
	}
end
