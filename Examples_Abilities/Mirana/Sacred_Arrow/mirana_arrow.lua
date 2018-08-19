mirana_arrow = class( AbilityBaseClass )

--------------------------------------------------------------------------------

if IsServer() then

  -- There are so many values passed (in arrow_data) to make sure we have values from time the arrow was sent and not on hit (may get level-up in meantime)
  function mirana_arrow:SendArrow(caster, position, direction, arrow_data)
    local info =
    {
      Ability = self,
      EffectName = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf",
      vSpawnOrigin = caster:GetAbsOrigin() + (caster:GetForwardVector() * arrow_data.arrow_start_distance),
      fDistance = arrow_data.arrow_range,
      fStartRadius = arrow_data.arrow_width,
      fEndRadius = arrow_data.arrow_width,
      Source = caster,
      bHasFrontalCone = false,
      bReplaceExisting = false,
      iUnitTargetTeam = self:GetAbilityTargetTeam(),
      iUnitTargetType = self:GetAbilityTargetType(),
      iUnitTargetFlags = self:GetAbilityTargetFlags(),
      bDeleteOnHit = true,
      vVelocity = direction * arrow_data.arrow_speed,
      bProvidesVision = true,
      iVisionRadius = arrow_data.arrow_vision,
      iVisionTeamNumber = caster:GetTeamNumber(),
      ExtraData = {
        arrow_min_stun = arrow_data.arrow_min_stun,
        arrow_max_stun = arrow_data.arrow_max_stun,
        arrow_max_stunrange = arrow_data.arrow_max_stunrange,
        arrow_bonus_damage = arrow_data.arrow_bonus_damage,
        arrow_base_damage = arrow_data.arrow_base_damage,
        arrow_damage_type = arrow_data.arrow_damage_type,
        arrow_vision = arrow_data.arrow_vision,
        arrow_vision_duration = arrow_data.arrow_vision_duration
      },
    }
    self.arrow_start_position = position
    return ProjectileManager:CreateLinearProjectile(info)
  end

  function mirana_arrow:OnProjectileHit_ExtraData(target, location, data)
    local caster = self:GetCaster()

    -- Target must exist and not be immune (to magic or in general)
    if target == nil or target:IsInvulnerable() then
      return false
    end

    -- Check if target is already affected by "STUNNED" from this ability (and caster) to prevent being hit by multiple arrows
    local stunned_modifier = target:FindModifierByNameAndCaster("modifier_stunned", caster)
    if stunned_modifier ~= nil then
      return false
    end

    if not target:IsMagicImmune() then
      if target:IsCreep() and (not target:IsConsideredHero()) and (not target:IsAncient()) then
        target:ForceKill( false )
      end

      -- Traveled distance limited to arrow_max_stunrange
      local arrow_traveled_distance = math.min( ( self.arrow_start_position - target:GetAbsOrigin() ):Length(), data.arrow_max_stunrange )
      -- Multiplier from 0.0 to 1.0 for Arrow's stun duration (and damage based on distance)
      local dist_mult = arrow_traveled_distance / data.arrow_max_stunrange

      -- Damage arrow_base_damage with damage based on traveled distance
      local damage = data.arrow_bonus_damage * dist_mult + data.arrow_base_damage
      -- Damage
      local damageTable = {
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = data.arrow_damage_type,
        --damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
        ability = self, --Optional.
      }
      ApplyDamage(damageTable)

      -- Stun duration from arrow_min_stun to arrow_max_stun based on stun_mult
      local stun_duration = (data.arrow_max_stun - data.arrow_min_stun) * dist_mult + data.arrow_min_stun
      -- Stun
      target:AddNewModifier(caster, self, "modifier_stunned", {
        duration=stun_duration
      })
    end

    -- Add vision
    AddFOWViewer(caster:GetTeamNumber(), target:GetAbsOrigin(), data.arrow_vision, data.arrow_vision_duration, false)

    return true
  end

  function mirana_arrow:OnSpellStart()
    local caster = self:GetCaster()
    local position = caster:GetAbsOrigin()
    local direction = self:GetForwardVector()

    local arrow_data = {
      arrow_start_distance = self:GetSpecialValueFor( "arrow_start_distance" ), -- Arrow start distance from caster
      arrow_speed = self:GetSpecialValueFor( "arrow_speed" ), -- Arrow travel speed
      arrow_width = self:GetSpecialValueFor( "arrow_width" ), -- Arrow width
      arrow_range = self:GetSpecialValueFor( "arrow_range" ), -- Maximum arrow range
      arrow_min_stun = self:GetSpecialValueFor( "arrow_min_stun" ), -- Minimum stun duration
      arrow_max_stun = self:GetSpecialValueFor( "arrow_max_stun" ), -- Maximum stun duration
      arrow_max_stunrange = self:GetSpecialValueFor( "arrow_max_stunrange" ), -- Range for maximum stun
      arrow_bonus_damage = self:GetSpecialValueFor( "arrow_bonus_damage" ), -- Maximum bonus damage
      arrow_base_damage = self:GetAbilityDamage(), -- Base damage
      arrow_damage_type = self:GetAbilityDamageType(),
      arrow_vision = self:GetSpecialValueFor( "arrow_vision" ), -- Arrow vision radius
      arrow_vision_duration = self:GetSpecialValueFor( "arrow_vision_duration" ) -- VIsion duration after hit
    }

    -- Send arrow
    self:SendArrow(caster, position, direction, arrow_data)

    -- Send multishot arrows
    if caster:HasTalent("special_bonus_unique_mirana_2") then
      local arrow_multishot_angle = self:GetSpecialValueFor( "arrow_multishot_angle" )
      local talent_arrow_count = caster:FindTalentValue("special_bonus_unique_mirana_2")

      -- Send amount of additional arrows specified by the talent
      for i = 1, talent_arrow_count do
        -- Angle multiplier to switch sides between right and left
        local angle_mult = 1;
        if i % 2 == 1 then
          angle_mult = -1
        end

        -- Arrows with indices 0,1 have same angle (also applies for 2,3 or 4,5...)
        local angle = ( math.floor(i / 2) + 1 ) * arrow_multishot_angle * angle_mult

        -- Rotate forward vector
        local direction_multishot = RotatePosition(Vector(0,0,0), QAngle(0, angle, 0), direction):Normalized()

        -- Send arrow
        self:SendArrow(caster, position, direction_multishot, arrow_data)

      end
    end

  end

end

--------------------------------------------------------------------------------

function mirana_arrow:GetCooldown( level )
  local caster = self:GetCaster()

  local talent_cooldown_reduction = caster:FindTalentValue("special_bonus_unique_mirana_3")
  return self.BaseClass.GetCooldown( self, level ) - talent_cooldown_reduction
end
