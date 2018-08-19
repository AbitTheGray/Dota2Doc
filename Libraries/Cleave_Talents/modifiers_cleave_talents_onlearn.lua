modifier_cleave_talents_onlearn = class( {} )

LinkLuaModifier( "modifier_cleave_talents", "modifiers/modifier_cleave_talents.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function modifier_cleave_talents_onlearn:IsHidden()
  return true
end

function modifier_cleave_talents_onlearn:IsPurgable()
  return false
end

function modifier_cleave_talents_onlearn:IsPermanent()
  return true
end

--------------------------------------------------------------------------------

if IsServer() then
  GameEvents:OnPlayerLearnedAbility(function(keys)
    local player = EntIndexToHScript(keys.player)
    local abilityname = keys.abilityname
    local pID = keys.PlayerID
    if not pID then
      return
    end
    local hero = PlayerResource:GetSelectedHeroEntity( pID )
    -- string.match(input, regex)
    if hero and string.match(abilityname, "special_bonus_cleave_[0-9]*") then
      local ability = hero:FindAbilityByName(abilityname)
      if ability ~= nil then
        local modifier = hero:AddNewModifier(hero, ability, "modifier_cleave_talents", {});
      end
    end
  end)
end
