meepo_geostrike = class( AbilityBaseClass )

LinkLuaModifier( "modifier_meepo_geostrike", "abilities/meepo/meepo_geostrike.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_meepo_geostrike_hit", "abilities/meepo/meepo_geostrike_hit.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

modifier_meepo_geostrike = class( ModifierBaseClass )

function modifier_meepo_geostrike:IsHidden()
  return true
end

function modifier_meepo_geostrike:IsPurgable()
  return false
end

function modifier_meepo_geostrike:IsPurgeException()
  return false
end

function modifier_meepo_geostrike:IsDebuff()
  return false
end

function modifier_meepo_geostrike:IsPermanent()
  return true
end

function modifier_meepo_geostrike:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_ATTACK_LANDED,
  }
end

function modifier_meepo_geostrike:OnAttackLanded(event)
  local parent = self:GetParent()
  if event.attacker ~= parent or not event.process_procs then
    return
  end
  if parent:PassivesDisabled() then
    return
  end
  local target = keys.target
  local ability = self:GetAbility()

  target:AddNewModifier(parent, ability, "modifier_meepo_geostrike_hit", {
    duration = ability:GetSpecialValueFor("duration"),
    slow = ability:GetSpecialValueFor("slow"),
    damage = ability:GetAbilityDamage()
  })
end

--------------------------------------------------------------------------------

modifier_meepo_geostrike_hit = class( ModifierBaseClass )

function modifier_meepo_geostrike_hit:IsHidden()
  return false
end

function modifier_meepo_geostrike_hit:IsPurgable()
  return false
end

function modifier_meepo_geostrike_hit:IsPurgeException()
  return false
end

function modifier_meepo_geostrike_hit:IsDebuff()
  return true
end
function modifier_meepo_geostrike_hit.GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_meepo_geostrike_hit:Setup(keys)
  self.think_interval = self:GetAbility():GetSpecialValueFor("check_interval")
  self:StartIntervalThink(self.think_interval)

  self:SetDuration(self:GetAbility():GetSpecialValueFor("duration")) -- Prevent status resistance
end

function modifier_meepo_geostrike_hit:OnCreated(keys)
  self:Setup(keys)
end

function modifier_meepo_geostrike_hit:OnRefresh(keys)
  self:Setup(keys)
end

function modifier_meepo_geostrike_hit:OnIntervalThink()
  -- Damage
  local damageTable = {
    victim = self:GetParent(),
    attacker = self:GetAbility():GetCaster(),
    damage = self.damage,
    damage_type = self:GetAbility():GetAbilityDamageType(),
    --damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
    ability = self:GetAbility(), --Optional.
  }
  ApplyDamage(damageTable)
end

function modifier_meepo_geostrike_hit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_meepo_geostrike_hit:GetModifierMoveSpeedBonus_Percentage()
  return self.slow * (1-self:GetParent():GetStatusResistance())
end
