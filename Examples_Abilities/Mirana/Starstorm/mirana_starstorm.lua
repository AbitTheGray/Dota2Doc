mirana_arrow_oaa = class( AbilityBaseClass )

LinkLuaModifier( "modifier_mirana_starstorm", "abilities/mirana/mirana_starstorm.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mirana_starstorm_scepter", "abilities/mirana/mirana_starstorm.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

if IsServer() then

  function mirana_arrow_oaa:TriggerOn(target, is_secondary_target)
    local caster = self:GetCaster()

    if is_secondary_target == nil then
      is_secondary_target = false
    end

    caster:AddNewModifier(caster, self, "modifier_mirana_starstorm", {
      is_secondary_target = true,
      damage = self:GetAbilityDamage()
    })
    --TODO Starstorm chooses a new target for the second meteor if the set target dies before or because of the first meteor's impact.
  end

  function mirana_arrow_oaa:TriggerSpell(radius_full, secondary_count, radius_secondary)
    local caster = self:GetCaster()
    local position = caster:GetAbsOrigin()

    -- Parameter not provided check
    if secondary_count == nil then
      secondary_count = 0
    end
    if radius_secondary == nil then
      radius_secondary = radius_full
    end

    local units = FindUnitsInRadius(caster:GetTeamNumber(),
      position,
      nil,
      radius_full,
      self:GetAbility():GetAbilityTargetTeam(),
      self:GetAbility():GetAbilityTargetType(),
      self:GetAbility():GetAbilityTargetFlags(),
      FIND_CLOSEST,
      false)
    if #units == 0 then
      return -- No units found
    end
    for i,unit in pairs(units) do
      if unit < secondary_count and (position - unit.GetAbsOrigin()):Length2D() <= radius_secondary then
        TriggerOn(unit, true) -- Secondary target
      else
        TriggerOn(unit, false) -- Non-secondary target
      end
    end
  end

  function mirana_arrow_oaa:OnSpellStart()
    local caster = self:GetCaster()
    local position = caster:GetAbsOrigin()

    local radius_full = self:GetSpecialValueFor("radius_primary")
    local radius_secondary = self:GetSpecialValueFor("radius_secondary")
    local secondary_count = self:GetSpecialValueFor("secondary_count")

    TriggerSpell(radius_full, secondary_count, radius_secondary)
  end

end

--------------------------------------------------------------------------------

function mirana_arrow_oaa:GetCooldown( level )
  local caster = self:GetCaster()

  return self.BaseClass.GetCooldown( self, level ) - caster:FindTalentValue("talent_mirana_starstorm_cooldown_reduction")
end


function mirana_arrow_oaa:OnInventoryContentsChanged()
  local caster = self:GetCaster()

  if caster:HasScepter() then
    if not caster:HasModifier("modifier_mirana_starstorm_scepter") then
      caster:AddNewModifier(caster, self, "modifier_mirana_starstorm_scepter", nil)
    end
  else -- not caster:HasScepter()
    if caster:HasModifier("modifier_mirana_starstorm_scepter") then
      caster:RemoveModifierByName("modifier_mirana_starstorm_scepter")
    end
  end
end

--------------------------------------------------------------------------------

modifier_mirana_starstorm = class( ModifierBaseClass )

function modifier_mirana_starstorm:IsHidden()
  return false
end

function modifier_mirana_starstorm:IsPurgable()
  return false
end

function modifier_mirana_starstorm:IsPurgeException()
  return false
end

function modifier_mirana_starstorm:DestroyOnExpire()
  return true
end

function modifier_mirana_starstorm:IsDebuff()
  return true
end

function modifier_mirana_starstorm:GetAttributes()
  return MODIFIER_ATTRIBUTE_NONE
end

function modifier_mirana_starstorm:OnCreated(keys)
  --self:StartIntervalThink(0.1)
  --TODO
end

function modifier_mirana_starstorm:OnRefresh(keys)
  --TODO
end

function modifier_mirana_starstorm:OnDestroy()
  --TODO
end

function modifier_mirana_starstorm:OnIntervalThink()
  --TODO
end

--------------------------------------------------------------------------------

modifier_mirana_starstorm_scepter = class( ModifierBaseClass )

function modifier_mirana_starstorm_scepter:IsHidden()
  return false
end

function modifier_mirana_starstorm_scepter:IsPurgable()
  return false
end

function modifier_mirana_starstorm_scepter:IsPurgeException()
  return false
end

function modifier_mirana_starstorm_scepter:IsDebuff()
  return false --To prevent Status Resistance to be triggered
end

function modifier_mirana_starstorm_scepter:GetAttributes()
  return MODIFIER_ATTRIBUTE_NONE
end

function modifier_mirana_starstorm_scepter:Setup(keys)
  self.think_interval = self:GetAbility():GetSpecialValueFor("tick_scepter")
  self.think_time = 0
  self.think_cooldown = self:GetAbility():GetSpecialValueFor("interval_scepter")
  self:StartIntervalThink(self.think_interval)
  self:SetDuration(self.think_cooldown, true)
end

function modifier_mirana_starstorm_scepter:OnCreated(keys)
  self:Setup(keys)
end

function modifier_mirana_starstorm_scepter:OnRefresh(keys)
  self:Setup(keys)
end

function modifier_mirana_starstorm_scepter:OnIntervalThink()
  if self.think_time < self.think_cooldown then
    return -- Still on cooldown
  end

  local parent = self:GetParent()
  local position = parent:GetAbsOrigin()

  local units = FindUnitsInRadius(parent:GetTeamNumber(),
    position,
    nil,
    self:GetSpecialValueFor("radius_scepter"),
    self:GetAbility():GetAbilityTargetTeam(),
    self:GetAbility():GetAbilityTargetType(),
    self:GetAbility():GetAbilityTargetFlags(),
    FIND_CLOSEST,
    false)

  if #units == 0 then
    return -- No units around
  end

  local found_any = false
  for i,unit in pairs(units) do
    if self:CanEntityBeSeenByMyTeam(unit) then
      found_any = true
      break
    end
  end
  if not found_any then
    return -- Cannot be seen by any entity around
  end

  self.think_time = 0 -- Reset cooldown
  for i,unit in pairs(units) do
    self:GetAbility():TriggerOn(units[i]) -- Trigger on all targets
  end

end
