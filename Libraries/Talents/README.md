# Talents

This is using custom [Cleave Library](../../../Libraries/Cleave/README.md) to not ignore armor on cleave targets.

## Files

- [`talents_server.lua`](talents_server.lua) = Server-side functions
- [`talents_client.lua`](talents_client.lua) = Client-side functions

**__WARNING__**: `talents_client.lua` is not complete.

Add this to your `addon_unit.lua`
```lua
if IsClient() then -- Load clientside utility lib
	require("libraries/talents_client")
else
	require("libraries/talents_server")
end
```
## Functions

### Has Talent
```lua
C_DOTA_BaseNPC:HasTalent(string talentName)
```
```lua
CDOTA_BaseNPC:HasTalent(string talentName)
```

### Get Talent Special Value For
```lua
C_DOTABaseAbility:GetTalentSpecialValueFor(string value)
```
```lua
CDOTABaseAbility:GetTalentSpecialValueFor(string value)
CDOTA_Modifier_Lua:GetTalentSpecialValueFor(string value)
```

### Find Talent Value
```lua
C_DOTA_BaseNPC:FindTalentValue(string talentName, string value)
```
```lua
CDOTA_BaseNPC:FindTalentValue(string talentName, string value)
```
