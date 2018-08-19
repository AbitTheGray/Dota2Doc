# Custom Cleave Library

This is extension of [Cleave Library](../Cleave/README.md) for talents.

Is not bugged with Aghanim's Scepter providing both talents.

## Files

- [`modifiers_cleave_talents.lua`](modifiers_cleave_talents.lua) = Talent to apply while the talent is active
- [`modifiers_cleave_talents_onlearn.lua`](modifiers_cleave_talents_onlearn.lua) = Global listener for talent level-up
- [`cleave_talents.txt`](cleave_talents.txt) = Vanilla Cleave Talents

Add this to your `gamemode.lua` into function `GameMode:OnGameInProgress()`
```lua
  -- Custom Cleave talents
  LinkLuaModifier( "modifier_cleave_talents_onlearn", "modifiers/modifier_cleave_talents_onlearn.lua", LUA_MODIFIER_MOTION_NONE )
  CreateModifierThinker( nil, nil, "modifier_cleave_talents_onlearn", {}, Vector( 0, 0, 0 ), DOTA_TEAM_NEUTRALS, false )
```

## Talents

Name of talent must match regex pattern `special_bonus_cleave_[0-9]*` and contain `value` or `cleave_damage` (in `"AbilitySpecial"`) to specify percentage of damage going into the cleave.

You can also specify `cleave_starting_width`, `cleave_ending_width` and `cleave_distance`.
