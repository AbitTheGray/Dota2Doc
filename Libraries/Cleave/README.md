# Custom Cleave Library

This library was made for Cleave to not ignore armor (or how it will be customized).

## Files

- [`cleave_library.lua`](cleave_library.lua) = Main library logic

Add this to your `addon_unit.lua`
```lua
-- Library for not-pure cleave (server-side only)
if IsServer() then
  require("libraries/cleave_library")
end
```

## Functions

### OnAttackLanded
```lua
CDOTABaseAbility:PerformCleaveOnAttack(event, cleaveInfo, damageMult, soundName, hitSoundName, particleNameCleave, particleNameHit)
```
- `event` = table of event data, `OnAttackLanded` ([b]Required[/b])
- `cleaveInfo` = table of cleave settings (Optional = `150, 330, 625`)
  - `cleaveInfo.startRadius` = float (Optional = `150`)
  - `cleaveInfo.endRadius` = float (Optional = `330`)
  - `cleaveInfo.length` = float (Optional = `625`)
- `damage` = float, damage multiplier to the cleave (Optional = `1.0`)
- `soundName` = string, sound played as effect of the cleave
- `hitSoundName` = string, sound played on every enemy hit by cleave
- `particleNameCleave` = string, particle to show for the cleave
- `particleNameHit` = string, particle to show on enemies hit by cleave

Does not work
- for illusions (still play sound and show particle when provided)
- on (or to) allies, towers, barracks, buildings and wards
- with BREAK effect ( unit:PassivesDisabled() )
- if event == nil or event.target == nil or event.target ~= self:GetParent()
- on Monkey King's Boundless Strike

Note:
- Phantom Assassin always cleaves from target (for her dagger to perform Cleave from target)

### On Unit
```lua
CDOTA_BaseNPC:PerformCleave(
  originalTarget,
  cleaveInfo,
  damage, damageType, damageFlags,
  targetTeam, targetUnit, targetFlags)
```
- `originalTarget` = handle to entity / unit ([b]Required[/b])
- `cleaveInfo` = table of cleave settings (Optional = `150, 330, 625`)
  - `cleaveInfo.startRadius` = float (Optional = `150`)
  - `cleaveInfo.endRadius` = float (Optional = `330`)
  - `cleaveInfo.length` = float (Optional = `625`)
- `damage` = int, damage of the cleave (Optional = `0`)
- `damageType` = `DAMAGE_TYPE_*`, type of damage (Optional = `PHYSICAL`)
- `damageFlags` = `DOTA_DAMAGE_FLAG_*`, modifications of damage (Optional = `MAGIC_IMMUNE_ENEMIES | NO_SPELL_AMPLIFICATION | NO_SPELL_LIFESTEAL`)
- `targetTeam` = `DOTA_UNIT_TARGET_TEAM_*`, modifications of damage (Optional = `ENEMY`)
- `targetUnit` = `DOTA_UNIT_TARGET_*` (Optional = `BASIC | HERO`)
- `targetFlags` = `DOTA_UNIT_TARGET_FLAG_*` (Optional = `NONE`)
[b]`ability` is `nil`.[/b] Usage of `CDOTABaseAbility:PerformCleave(...)` is recommended.

### On Ability
```lua
CDOTABaseAbility:PerformCleave(
  originalTarget,
  cleaveInfo,
  damage, damageType, damageFlags,
  targetTeam, targetUnit, targetFlags)
```
- `originalTarget` = handle to entity / unit ([b]Required[/b])
- `cleaveInfo` = table of cleave settings (Optional = `150, 330, 625`)
  - `cleaveInfo.startRadius` = float (Optional = `150`)
  - `cleaveInfo.endRadius` = float (Optional = `330`)
  - `cleaveInfo.length` = float (Optional = `625`)
- `damage` = int, damage of the cleave (Optional = `0`)
- `damageType` = `DAMAGE_TYPE_*`, type of damage (Optional = `PHYSICAL`)
- `damageFlags` = `DOTA_DAMAGE_FLAG_*`, modifications of damage (Optional = `NO_SPELL_AMPLIFICATION | NO_SPELL_LIFESTEAL`)
- `targetTeam` = `DOTA_UNIT_TARGET_TEAM_*`, modifications of damage (Optional = `NO_SPELL_AMPLIFICATION | NO_SPELL_LIFESTEAL`)
- `targetUnit` = `DOTA_UNIT_TARGET_*` (Optional = `BASIC | HERO`)
- `targetFlags` = `DOTA_UNIT_TARGET_FLAG_*` (Optional = `NONE`)

### Global
```lua
PerformCleave(
  attacker, ability, originalTarget,
  teamNumber, position, direction,
  cleaveInfo,
  damage, damageType, damageFlags,
  targetTeam, targetUnit, targetFlags)
```
- `attacker` = handle to unit ([b]Required[/b])
- `ability` = handle to ability (Optional)
- `originalTarget` = handle to unit, to not cleave-damage original target and show effect on it (Optional)
- `teamNumber` = int (Optional = `attacker:GetTeamNumber()`)
- `position` = Vector, start position of the cleave (Optional = `attacker:GetAbsOrigin()`)
- `direction` = Vector, cleave direction (Optional = `attacker:GetForwardVector()`)
- `cleaveInfo` = table of cleave settings (Optional = `150, 330, 625`)
  - `cleaveInfo.startRadius` = float (Optional = `150`)
  - `cleaveInfo.endRadius` = float (Optional = `330`)
  - `cleaveInfo.length` = float (Optional = `625`)
- `damage` = int, damage of the cleave (Optional = `0`)
- `damageType` = `DAMAGE_TYPE_*`, type of damage (Optional = `PHYSICAL`)
- `damageFlags` = `DOTA_DAMAGE_FLAG_*`, modifications of damage (Optional = `NO_SPELL_AMPLIFICATION | NO_SPELL_LIFESTEAL`)
- `targetTeam` = `DOTA_UNIT_TARGET_TEAM_*`, modifications of damage (Optional = `NO_SPELL_AMPLIFICATION | NO_SPELL_LIFESTEAL`)
- `targetUnit` = `DOTA_UNIT_TARGET_*` (Optional = `BASIC | HERO`)
- `targetFlags` = `DOTA_UNIT_TARGET_FLAG_*` (Optional = `NONE`)

### Find Units In Cone
Got from [fcalife](https://github.com/fcalife) on [OAA Issule #2289](https://github.com/OpenAngelArena/oaa/issues/2289)

```lua
table FindUnitsInCone(teamNumber, vDirection, vPosition, startRadius, endRadius, flLength, hCacheUnit, targetTeam, targetUnit, targetFlags, findOrder, bCache)
```
- `teamNumber` = int
- `vDirection` = Vector, scan direction
- `vPosition` = Vector, world absolute position
- `startRadius` = float
- `endRadius` = float
- `flLength` = float
- `hCacheUnit` = cache unit ???
- `targetTeam` = `DOTA_UNIT_TARGET_TEAM_*`
- `targetUnit` = `DOTA_UNIT_TARGET_*`
- `targetFlags` = `DOTA_UNIT_TARGET_FLAG_*`
- `findOrder` = `FIND_*`
- `bCache` = bool


## Notes

### Cleave Info

```lua
cleaveInfo = {
  startRadius = 150,
  endRadius = 330,
  length = 625
}
```

### Damage Flags

#### Dota 2
- Ignore Armor
- No Spell Amplification
- No Spell Lifesteal
```lua
bit.bor(DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL)
```

#### Dota 2 with no Blademail damage
- Ignore Armor
- No Spell Amplification
- No Spell Lifesteal
- No Damage Return (marked as reflection itself)
```lua
bit.bor(DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL, DOTA_DAMAGE_FLAG_REFLECTION)
```

#### Default
- No Spell Amplification
- No Spell Lifesteal
```lua
bit.bor(DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL)
```

#### Default with no Blademail damage
- No Spell Amplification
- No Spell Lifesteal
- No Damage Return (marked as reflection itself)
```lua
bit.bor(DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL, DOTA_DAMAGE_FLAG_REFLECTION)
```

### Damage Type

```
DAMAGE_TYPE_PURE
DAMAGE_TYPE_PHYSICAL
DAMAGE_TYPE_MAGICAL
```
