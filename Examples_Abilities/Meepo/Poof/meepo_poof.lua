meepo_poof = class( AbilityBaseClass )
--------------------------------------------------------------------------------

if IsServer() then

  function meepo_poof:DamageInArea(position, radius, damage, damage_type)
    if position == nil then
      return
    end
    if radius == nil then
      radius = self:GetSpecialValueFor("radius")
    end
    if damage == nil then
      damage = self:GetSpecialValueFor("poof_damage")
    end
    if damage_type == nil then
      damage_type = self:GetAbilityDamageType()
    end

    local caster = self:GetCaster()

    local units = FindUnitsInRadius(caster:GetTeamNumber(),
      position,
      nil,
      radius,
      self:GetAbility():GetAbilityTargetTeam(),
      self:GetAbility():GetAbilityTargetType(),
      self:GetAbility():GetAbilityTargetFlags(),
      FIND_CLOSEST,
      false)
    if #units == 0 then
      return
    end

    -- Damage found units
    for i=0,#units-1 do
      -- Do not damage spell-immune units
      if units[i] ~= nil and ( not units[i]:IsSpellImmune() ) then
        -- Damage
        local damageTable = {
          victim = units[i],
          attacker = caster,
          damage = damage,
          damage_type = damage_type,
          --damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
          ability = self, --Optional.
        }
        ApplyDamage(damageTable)
      end
    end

  end

  function meepo_poof:IsValidPoofTarget(unit)
    local caster = self:GetCaster()

    if (not unit:IsHero()) or unit:GetTeamNumber() ~= caster:GetTeamNumber() then
      return
    end

    --TODO talent_meepo_poof_allied_heroes
    --TODO talent_meepo_poof_allied_creeps
    --TODO talent_meepo_poof_allied_buildings

    if unit:GetUnitName() == caster:GetUnitName() and unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
      return true
    end
  end

  function meepo_poof:GetEndPosition()
    local caster = self:GetCaster()

    -- Check cursor target
    local target = caster:GetCursorTarget()
    if target ~= nil and self:IsValidPoofTarget(target) then
      return target:GetAbsOrigin()
    end

    -- Check nearby units
    local units = FindUnitsInRadius(caster:GetTeamNumber(),
      caster:GetCursorPosition(),
      nil,
      FIND_UNITS_EVERYWHERE,
      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
      --TODO talent_meepo_poof_allied_creeps
      --TODO talent_meepo_poof_allied_buildings
      DOTA_UNIT_TARGET_HERO,
      DOTA_UNIT_TARGET_FLAG_NONE,
      FIND_CLOSEST,
      false)
    for i,unit in pairs(units) do
      if units ~= nil and self:IsValidPoofTarget(unit) then
        return unit:GetAbsOrigin()
      end
    end

    return caster:GetAbsOrigin();
  end

  function meepo_poof:OnSpellStart()
    local caster = self:GetCaster()
    local position_start = caster:GetAbsOrigin()
    local position_end = caster:GetCursorPosition()

    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("poof_damage")
    local damage_type = self:GetAbilityDamageType()

    -- Damage on start position
    self:DamageInArea(position_start, radius, damage, damage_type)

    -- Teleport
    caster:SetAbsPosition(position_end)

    -- Damage on end position
    self:DamageInArea(position_end, radius, damage, damage_type)
  end

end
