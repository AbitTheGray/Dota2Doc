modifier_cleave_talents = class( {} )

--------------------------------------------------------------------------------

function modifier_cleave_talents:IsHidden()
  return true
end

function modifier_cleave_talents:IsPurgable()
  return false
end

function modifier_cleave_talents:IsPermanent()
  return true
end

--------------------------------------------------------------------------------

function modifier_cleave_talents:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_ATTACK_LANDED
  }
end

if IsServer() then
  function modifier_cleave_talents:OnAttackLanded( event )
    local parent = self:GetParent()
    if event.attacker == nil or event.attacker ~= parent then
      return
    end

    local ability = self:GetAbility()
    if ability == nil then
      return
    end

    local cleaveInfo = {
      startRadius = ability:GetSpecialValueFor("cleave_starting_width"),
      endRadius = ability:GetSpecialValueFor("cleave_ending_width"),
      length = ability:GetSpecialValueFor("cleave_distance")
    }
    if ( not cleaveInfo.startRadius ) or cleaveInfo.startRadius <= 0 then
      cleaveInfo.startRadius = nil -- Use default
    end
    if ( not cleaveInfo.endRadius ) or cleaveInfo.endRadius <= 0 then
      cleaveInfo.endRadius = nil -- Use default
    end
    if ( not cleaveInfo.length) or cleaveInfo.length <= 0 then
      cleaveInfo.length = nil -- Use default
    end

    local cleaveDmgPct = ability:GetSpecialValueFor("value")
    if cleaveDmgPct == nil then
      cleaveDmgPct = ability:GetSpecialValueFor("cleave_damage")
    end

    ability:PerformCleaveOnAttack(
      event,
      cleaveInfo,
      cleaveDmgPct / 100.0,
      nil, -- Sound on attack
      nil, -- Sound on target
      nil, -- Wave particle
      nil -- Hit particle
    )
  end
end

function modifier_cleave_talents:OnInventoryContentsChanged()
  local ability = self:GetAbility()
  if ability == nil or ability:GetLevel() == 0 then
    self:GetParent():RemoveModifierByName("modifier_cleave_talents")
    return
  end
end
