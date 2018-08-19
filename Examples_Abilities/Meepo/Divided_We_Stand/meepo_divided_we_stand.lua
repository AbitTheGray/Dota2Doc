meepo_divided_we_stand = class( AbilityBaseClass )

LinkLuaModifier( "modifier_meepo_clone", "abilities/meepo/meepo_divided_we_stand.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_meepo_clone_master", "abilities/meepo/meepo_divided_we_stand.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

modifier_meepo_clone = class( ModifierBaseClass )

function modifier_meepo_clone:IsHidden()
  return true
end

function modifier_meepo_clone:IsPurgable()
  return false
end

function modifier_meepo_clone:IsPurgeException()
  return false
end

function modifier_meepo_clone:IsDebuff()
  return false
end

function modifier_meepo_clone:DeclareFunctions()
  return
  {
    MODIFIER_EVENT_ON_ORDER,
    MODIFIER_EVENT_ON_DEATH,
    --MODIFIER_EVENT_ON_RESPAWN,
    MODIFIER_EVENT_ON_TAKEDAMAGE
  }
end

--------------------------------------------------------------------------------

modifier_meepo_clone_master = class( ModifierBaseClass )

function modifier_meepo_clone_master:IsHidden()
  return false
end

function modifier_meepo_clone_master:IsPurgable()
  return false
end

function modifier_meepo_clone_master:IsPurgeException()
  return false
end

function modifier_meepo_clone_master:IsDebuff()
  return false
end

function modifier_meepo_clone_master:OnCreated(keys)

end

function modifier_meepo_clone_master:OnRefresh(keys)

end

function modifier_meepo_clone_master:DeclareFunctions()
  return
  {
    MODIFIER_EVENT_ON_ORDER,
    MODIFIER_EVENT_ON_DEATH,
    MODIFIER_EVENT_ON_RESPAWN,
    MODIFIER_EVENT_ON_TAKEDAMAGE
  }
end

--------------------------------------------------------------------------------

function meepo_divided_we_stand:constructor()
    self.isScepterUpgraded = false
end

function meepo_divided_we_stand:OnUpgrade()
  local caster = self:GetCaster()
  local mainMeepo = nil

  -- Is this main Meepo?
  if caster:HasModifier("modifier_meepo_clone_master") then
    mainMeepo = caster
  end
  -- Is this a clone?
  if caster:HasModifier("modifier_meepo_clone") then
    mainMeepo = caster.mainMeepo
  end

  -- No/invalid main Meepo
  if mainMeepo == nil then
    return false
  end

  if mainMeepo.clones == nil then
    mainMeepo.clones = {}
  end

  -- Create new Meepo at nearest clear space
  local newMeepo = CreateUnitByName(GetUnitName(caster), mainMeepo:GetAbsOrigin(), true, mainMeepo, mainMeepo:GetPlayerOwner(), mainMeepo:GetTeamNumber())
  newMeepo:SetControllableByPlayer(mainMeepo:GetPlayerOwnerID(), false)
  newMeepo:SetOwner(caster.GetOwner())
  newMeepo:SetCanSellItems(false)
  newMeepo:SetUnitCanRespawn(false)
  --newMeepo:AddNewModifier(mainMeepo,self,"modifier_phased",{["duration"]=0.1})

  -- Add to Meepo clones list
  mainMeepo.clones[#mainMeepo.clones] = newMeepo

  --TODO Add Meepo clone buff

  -- Replace clone functions
  newMeepo.IsClone = function() return true end
  newMeepo.GetCloneSource = function() return mainMeepo end

  -- Copy level and ability points
  while newMeepo:GetLevel() < mainMeepo:GetLevel() do
    newMeepo:HeroLevelUp(false) -- Level up without effects
  end
  newMeepo:AddExperience(mainMeepo:GetCurrentXP(), -1, false, true) -- Set XP
  newMeepo:SetAbilityPoints(mainMeepo:GetAbilityPoints())

  -- Remove possible abilities of the clone
  for i=0,newMeepo:GetAbilityCount()-1 do
    local ability = newMeepo:GetAbilityByIndex(i)
    if ability then
      newMeepo:RemoveAbility(ability:GetAbilityName())
    end
  end

  -- Copy abilities
  for i=0,mainMeepo:GetAbilityCount()-1 do
    local ability = mainMeepo:GetAbilityByIndex(i)
    if ability then
      local newAbility = newMeepo:AddAbility(ability:GetAbilityName())
      newAbility:SetLevel(ability:GetLevel())
    end
  end


end


function meepo_divided_we_stand:OnInventoryContentsChanged()
  local caster = self:GetCaster()

  if caster:IsIllusion() or caster:HasMOdifier("modifier_meepo_clone") then
    return
  end

  if not self.isScepterUpgraded and caster:HasScepter() then
    for i=0,5,1 do
      local item = self.GetCaster().GetItemInSlot(i)
      if item and
      (
        item.GetAbilityName() == "item_ultimate_scepter"
        or
        item.GetAbilityName() == "item_ultimate_scepter_1"
        or
        item.GetAbilityName() == "item_ultimate_scepter_2"
        or
        item.GetAbilityName() == "item_ultimate_scepter_3"
        or
        item.GetAbilityName() == "item_ultimate_scepter_4"
        or
        item.GetAbilityName() == "item_ultimate_scepter_5"
      ) then

        if self:OnUpgrade() then
          item:SetDroppable(false)
          item:SetSellable(false)
          item:SetCanBeUsedOutOfInventory(false)

          self.isScepterUpgraded=true
        end
        return
      end
    end
  end
end
