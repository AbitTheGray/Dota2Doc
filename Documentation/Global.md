# Global

## Add FOW Viewer
Add temporary vision for a given team through fog of war at specified position.
```lua
void AddFOWViewer(int teamNumber, Vector origin, float radius, float duration, bool obstructedVision)
```

## Angle Diff
Returns the number of degrees difference between two yaw angles.
```lua
float AngleDiff(float ang1, float ang2)
```

## Append To Log File
Appends a string to a log file on the server.
```lua
void AppendToLogFile(string string_1, string string_2)
```
TODO arguments?

## Axis Angle To Quaternion
Constructs a quaternion representing a rotation by angle around the specified vector axis.
```lua
Quaternion AxisAngleToQuaternion(Vector axis, float angle)
```

## Calc Closest Point On Entity OBB
Compute the closest point on the OBB of an entity.
```lua
Vector CalcClosestPointOnEntityOBB(handle entity, Vector sourcePoint)
```

## Calc Distance Between Entity OBB
Compute the distance between two entity OBB. A negative return value indicates an input error. A return value of zero indicates that the OBBs are overlapping.
```lua
float CalcDistanceBetweenEntityOBB(handle ent1, handle ent2)
```

## Calc Distance To Line Segment 2D
Compute the distance from a point to a line segment.
```lua
float CalcDistanceToLineSegment2D(Vector vector_1, Vector vector_2, Vector vector_3)
```
TODO order?

## Cancel Entity IO Events
Create all I/O events for a particular entity
```lua
void CancelEntityIOEvents(ehandle ehandle_1)
```
TODO ehandle?

## Clear Team Custom Healthbar Color
```lua
void ClearTeamCustomHealthbarColor(int teamNumber)
```

## Create Effect
```lua
bool CreateEffect(handle table)
bool CreateEffect({
  entity = handle_to_entity,
  effect = ""
})
```
TODO verify types in the table

## Create Hero For Player
Creates a DOTA hero by its `dota_npc_units.txt` name and sets it as the given player's controlled hero.
```lua
handle CreateHeroForPlayer(string unitName, handle player)
```

## Create HTTP Request Script VM
Create an HTTP request.
Recently renamed from CreateHTTPRequest.
```lua
handle CreateHTTPRequestScriptVM(string string_1, string string_2)
```
TODO url and content?

## Create Item
Creates an item with classname item_name that owner can use.
```lua
handle CreateItem(string item_name, handle owner, handle owner)
```
TODO 2 owners?

## Create Item On Position For Launch
Create a physical item at a given location, can start in air (but doesn't clear a space).
```lua
handle CreateItemOnPositionForLaunch(Vector Vector_1, handle handle_2)
```
TODO

## Create Item On Position Sync
Create a physical item at a given location.
```lua
handle CreateItemOnPositionSync(Vector Vector_1, handle handle_2)
```
TODO

## Create Modifier Thinker
Create a modifier not associated with an NPC.
```lua
handle CreateModifierThinker(handle caster, handle ability, string modifierName, handle paramTable, Vector origin, int teamNumber, bool phantomBlocker)
```
TODO phantomBlocker

## Create Temp Tree
Create a temporary tree.
```lua
void CreateTempTree(Vector location, float duration)
```

## Create Trigger
CreateTrigger( vecMin, vecMax )
Creates and returns an AABB trigger.
```lua
handle CreateTrigger(Vector Vector_1, Vector Vector_2, Vector Vector_3)
```
TODO

## Create Trigger Radius Approximate
Creates and returns an AABB trigger thats bigger than the radius provided.
```lua
handle CreateTriggerRadiusApproximate(Vector origin, float radius)
```

## Create Unit By Name
Creates a DOTA unit by its `dota_npc_units.txt` name.
```lua
handle CreateUnitByName(string unitName, Vector location, bool findClearSpace, handle npcOwner, handle unitOwner, int teamNumber)
```

## Create Unit By Name Async
Creates a DOTA unit by its `dota_npc_units.txt` name.
```lua
int CreateUnitByNameAsync(string unitName, Vector location, bool findClearSpace, handle npcOwner, handle unitOwner, int teamNumber, handle callback)
```
TODO callback

## Create Unit From Table
Creates a new data-driven entity with the given table.
```lua
handle CreateUnitFromTable(handle handle_1, Vector Vector_2)
```

## Cvar Get Float
Gets the value of the given cvar, as a float.
```lua
float cvar_getf(string cvarName)
```

## Cvar Set Float
Sets the value of the given cvar, as a float.
```lua
bool cvar_setf(string cvarName, float value)
```

## Debug Break
Breaks in the debugger.
```lua
void DebugBreak()
```

## Debug Draw Box
Draw a debug overlay box.
```lua
void DebugDrawBox(Vector origin, Vector min, Vector max, int colorRed, int colorGreen, int colorBlue, int colorAlpha, float duration)
```

## Debug Draw Box Direction
Draw a debug forward box.
```lua
void DebugDrawBoxDirection(Vector origin, Vector min, Vector max, Vector forward, Vector colorRgb, float colorAlpha, float duration)
```

## Debug Draw Circle
Draw a debug circle.
```lua
void DebugDrawCircle(Vector origin, Vector colorRgb, float colorAlpha, float radianAngle, bool doZTest, float duration)
```

## Debug Draw Clear
Try to clear all the debug overlay info.
```lua
void DebugDrawClear()
```

## Debug Draw Line
Draw a debug overlay line.
```lua
void DebugDrawLine(Vector origin, Vector target, int colorRed, int colorGreen, int colorBlue, bool doZTest, float duration)
```

## Debug Draw Line vCol
Draw a debug line using color vec.
```lua
void DebugDrawLine_vCol(Vector start, Vector end, Vector colorRgb, bool doZTest, float duration)
```
(start, end, vRgb, a, ztest, duration)
TODO missing colorAlpha

## Debug Draw Screen Text Line
Draw text with a line offset.
```lua
void DebugDrawScreenTextLine(float positionX, float positionY, int lineOffset, string text, int colorRed, int colorGreen, int colorBlue, int colorAlpha, float duration)
```

## Debug Draw Sphere
Draw a debug sphere.
```lua
void DebugDrawSphere(Vector origin, Vector colorRgb, float colorAlpha, float angleRadian, bool doZTest, float duration)
```

## Debug Draw Text
Draw text in 3d.
```lua
void DebugDrawText(Vector origin, string test, bool viewCheck, float duration)
```
TODO viewCheck?

## Debug Screen Text Pretty
Draw pretty debug text.
```lua
void DebugScreenTextPretty(float positionX, float positionY, int lineOffset, string text, int colorRed, int colorGreen, int colorBlue, int colorAlpha, float duration, string font, int fontSize, bool bold)
```
TODO list fonts

## Do Cleave Attack

```lua
int DoCleaveAttack(handle attacker, handle target, handle ability, float damage, float startRadius, string effectName)
```
TODO on what applies effectName

## Do Ent Fire
Generate an entity i/o event.
```lua
void DoEntFire(string target, string action, string value, float delay, handle activator, handle caller)
```
TODO target is string?
TODO list actions

## Do Ent Fire By Instance Handle
Generate an entity i/o event.
```lua
void DoEntFireByInstanceHandle(handle target, string action, string value, float delay, handle activator, handle caller)
```

## Do Include Script
Execute a script (internal).
```lua
bool DoIncludeScript(string string_1, handle handle_2)
```

## Do Script Assert
Asserts the passed in value. Prints out a message and brings up the assert dialog.
```lua
void DoScriptAssert(bool bool_1, string string_2)
```

## Do Unique String
Generate a string guaranteed to be unique across the life of the script VM, with an optional root string.
Useful for adding data to table's when not sure what keys are already in use in that table.
```lua
string DoUniqueString(string optionalPrefixString)
```

## Emit Announcer Sound
Emit an announcer sound for all players.
```lua
void EmitAnnouncerSound(string soundName)
```

## Emit Announcer Sound For Player
Emit an announcer sound for a player.
```lua
void EmitAnnouncerSoundForPlayer(string soundName, int playerId)
```

## Emit Announcer Sound For Team
Emit an announcer sound for a team.
```lua
void EmitAnnouncerSoundForTeam(string soundName, int teamNumber)
```

## Emit Announcer Sound For Team On Location
Emit an announcer sound for a team at a specific location.
```lua
void EmitAnnouncerSoundForTeamOnLocation(string soundName, int teamNumber, Vector origin)
```

## Emit Global Sound
Play named sound for all players.
```lua
void EmitGlobalSound(string soundName)
```

## Emit Sound On
Play named sound on Entity.
```lua
void EmitSoundOn(string soundName, handle entity)
```

## Emit Sound On Client
Play named sound only on the client for the passed in player.
```lua
void EmitSoundOnClient(string soundName, handle playerId)
```

## Emit Sound On Location For Allies
Emit a sound on a location from a unit, only for players allied with that unit.
```lua
void EmitSoundOnLocationForAllies(Vector origin, string soundName, handle caster)
```

## Emit Sound On Location With Caster
Emit a sound on a location from a unit.
```lua
void EmitSoundOnLocationWithCaster(Vector origin, string soundName, handle caster)
```

## Ent Index To HScript
Turn an entity index integer to an HScript representing that entity's script instance.
```lua
handle EntIndexToHScript(int entityIndex)
```
TODO HScript?

## Execute Order From Table
Issue an order from a script table.
```lua
void ExecuteOrderFromTable(handle table)
void ExecuteOrderFromTable({
 		UnitIndex = yourNPC:entindex(),
 		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
 		 TargetIndex = entToAttack:entindex(), --Optional.  Only used when targeting units
 		AbilityIndex = 0, --Optional.  Only used when casting abilities
 		Position = nil, --Optional.  Only used when targeting the ground
 		Queue = 0 --Optional.  Used for queueing up abilities
 	})
```
TODO more generic

## Exponential Decay
Smooth curve decreasing slower as it approaches zero.
```lua
float ExponentialDecay(float float_1, float float_2, float float_3)
```
TODO order?
TODO graph

## File To String
Reads a string from a file to send to script.
```lua
string FileToString(string fileName)
```
TODO fileName relative path start

## Find Clear Space For Unit
Place a unit somewhere not already occupied.
```lua
bool FindClearSpaceForUnit(handle unit, Vector origin, bool bool_3)
```
TOO bool_3?

## Find Units In Radius
Finds the units in a given radius with the given flags.
```lua
table FindUnitsInRadius(int teamNumber, Vector position, handle cacheUnit, float radius, int teamFilter, int typeFilter, int flagFilter, int order, bool canGrowCache)
```
TODO cacheUnit?

## Find Units In Line
Finds the units in a given line with the given flags.
```lua
table FindUnitsInLine(int teamNumber, Vector startPosition, Vector endPosition, handle cacheUnit, float width, int teamFilter, int typeFilter, int flagFilter)
```
TODO cacheUnit?

## Fire Entity IO Input Name Only
Fire Entity's Action Input w/no data.
```lua
void FireEntityIOInputNameOnly(ehandle entity, string actionName)
```

## Fire Entity IO Input String
Fire Entity's Action Input with passed String - you own the memory.
```lua
void FireEntityIOInputString(ehandle entity, string actionName, string value)
```

## Fire Entity IO Input Vec
Fire Entity's Action Input with passed Vector.
```lua
void FireEntityIOInputVec(ehandle entity, string actionName, Vector value)
```

## Fire Game Event
Fire a pre-defined event, which can be found either in `custom_events.txt` or in dota's `resource/*.res`
```lua
void FireGameEvent(string eventName, handle parameterTable)
```

## Fire Game Event Local
Fire a game event without broadcasting to the client.
```lua
void FireGameEventLocal(string eventName, handle parameterTable)
```

## Frame Time
Get the time spent on the server in the last frame.
```lua
float FrameTime()
```

## Get Entity Index For Tree Id
Get the enity index for a tree id specified as the entindex_target of a DOTA_UNIT_ORDER_CAST_TARGET_TREE.
```lua
<unknown> GetEntityIndexForTreeId(unsigned unsigned_1)
```
TODO

## Get Frame Count
Returns the engines current frame count.
```lua
int GetFrameCount()
```

## Get Frosty Boost Amount

```lua
float GetFrostyBoostAmount(int int_1, int int_2)
```

## Get Frosty Points For Round

```lua
int GetFrostyPointsForRound(int int_1, int int_2, int roundNumber)
```

## Get Gold Frosty Boost Amount

```lua
float GetGoldFrostyBoostAmount(int int_1, int int_2)
```

## Get Gold Frosty Points For Round

```lua
int GetGoldFrostyPointsForRound(int int_1, int int_2, int roundNumber)
```

## Get Ground Height

```lua
float GetGroundHeight(Vector Vector_1, handle handle_2)
```

## Get Ground Position
Returns the supplied position moved to the ground. Second parameter is an NPC for measuring movement collision hull offset.
```lua
Vector GetGroundPosition(Vector Vector_1, handle handle_2)
```

## Get Item Cost
Get the cost of an item by name.
```lua
int GetItemCost(string string_1)
```

## Get Listen Server Host
Get the local player on a listen server.
```lua
handle GetListenServerHost()
```

## Get Map Name
Get the name of the map.
```lua
string GetMapName()
```

## Get Max Output Delay
Get the longest delay for all events attached to an output.
```lua
float GetMaxOutputDelay(ehandle ehandle_1, string string_2)
```

## Get Phys Angular Velocity
Get Angular Velocity for VPHYS or normal object.
```lua
Vector GetPhysAngularVelocity(handle handle_1)
```

## Get Phys Velocity
Get Velocity for VPHYS or normal object.
```lua
Vector GetPhysVelocity(handle handle_1)
```

## Get System Date
Get the current real world date
```lua
string GetSystemDate()
```

## Get System Time
Get the current real world time
```lua
string GetSystemTime()
```

## Get Team Hero Kills

```lua
int GetTeamHeroKills(int teamNumber)
```

## Get Team Name
Returns the team name.
```lua
string GetTeamName(int teamNumber)
```

## Get Tree Id For Entity Index
Given and entity index of a tree, get the tree id for use with unit orders.
```lua
int GetTreeIdForEntityIndex(int int_1)
```

## Get World Max X
Gets the world's maximum X position.
```lua
float GetWorldMaxX()
```

## Get World Max Y
Gets the world's maximum Y position.
```lua
float GetWorldMaxY()
```

## Get World Min X
Gets the world's minimum X position.
```lua
float GetWorldMinX()
```

## Get World Min Y
Gets the world's minimum Y position.
```lua
float GetWorldMinY()
```

## Init Log File
If the given file doesn't exist, creates it with the given contents.
Does nothing if it exists.
```lua
void InitLogFile(string string_1, string string_2)
```

## Is Client
Returns true if this is lua running from the `client.dll`.
```lua
bool IsClient()
```

## Is Dedicated Server
Returns true if this server is a dedicated server.
```lua
bool IsDedicatedServer()
```

## Is Marked For Deletion
Returns true if the entity is valid and marked for deletion.
```lua
bool IsMarkedForDeletion(handle entity)
```

## Is Server
Returns true if this is lua running from the `server.dll`.
```lua
bool IsServer()
```

## Is Valid Entity
Checks to see if the given hScript is a valid entity.
```lua
bool IsValidEntity(handle entity)
```

## Is In Tools Mode
Returns true if this is lua running from the dota2 workshop tools.
```lua
bool IsInToolsMode()
```

## Limit Pathing Search Depth
Set the limit on the pathfinding search space.
```lua
void LimitPathingSearchDepth(float float_1)
```

## Link Lua Modifier
Link a lua-defined modifier with the associated class.
If the modifier is located within the root vscript folder, then the second argument (`filePath`) may be omitted.
```lua
void LinkLuaModifier(string modifierName, string filePath, int motionControllerType)
void LinkLuaModifier(string modifierName, int motionControllerType) -- Only when the file is in root vscript folder
```

## Listen To Game Event
Register as a listener for a game event from script.
```lua
int ListenToGameEvent(string EventName, handle functionNameToCall, handle context)
```

## Load Key Values
Creates a table from the specified keyvalues text file.
```lua
table LoadKeyValues(string filePath)
```

## Load Key Values From String
Creates a table from the specified keyvalues string.
```lua
table LoadKeyValuesFromString(string content)
```

## Make String Token
Checks to see if the given hScript is a valid entity.
```lua
int MakeStringToken(string string_1)
```

## Minimap Event
Start a minimap event.
```lua
void MinimapEvent(int teamNumber, handle entity, int positionX, int positionY, int eventType, int eventDuration)
```
TODO what kind of events?

## Msg
Print a message
```lua
void Msg(string text)
```

## Pause Game
Pause or unpause the game.
```lua
void PauseGame(bool bool_1)
```
TODO bool_1 indicating whenever to pause or unpause?

## Player Instance From Index
Get a script instance of a player by index.
```lua
handle PlayerInstanceFromIndex(int int_1)
```

## Precache Entity From Table
Precache an entity from KeyValues in table.
```lua
void PrecacheEntityFromTable(string string_1, handle handle_2, handle handle_3)
```

## Precache Entity List From Table
Precache a list of entity KeyValues table's.
```lua
void PrecacheEntityListFromTable(handle handle_1, handle handle_2)
```

## Precache Item By Name Async
Asynchronously precaches a DOTA item by its `dota_npc_items.txt` name, provides a callback when it's finished.
```lua
void PrecacheItemByNameAsync(string string_1, handle handle_2)
```

## Precache Item By Name Sync
Precaches a DOTA item by its `dota_npc_items.txt` name.
```lua
void PrecacheItemByNameSync(string string_1, handle handle_2)
```

## Precache Model
Manually precache a single model.
```lua
void PrecacheModel(string modelName, handle context)
```

## Precache Resource
Manually precache a single resource.
```lua
void PrecacheResource(string precacheMode, string resource, handle context)
```

## Precache Unit By Name Async
Asynchronously precaches a DOTA unit by its `dota_npc_units.txt` name, provides a callback when it's finished.
```lua
void PrecacheUnitByNameAsync(string string_1, handle handle_2, int int_3)
```

## Precache Unit By Name Sync
Precaches a DOTA unit by its `dota_npc_units.txt` name
```lua
void PrecacheUnitByNameSync(string string_1, handle handle_2, int int_3)
```

## Print Linked Console Message
Print a console message with a linked console command.
```lua
void PrintLinkedConsoleMessage(string string_1, string string_2)
```

## Random Float
Get a random float within a range including both limits.
```lua
float RandomFloat(float min, float max)
```

## Random Int
Get a random integer (number) within a range including both limits.
Do not use `math.random()`
```lua
int RandomInt(int min, int max)
```
```lua
math.random() == RandomInt(0, 1)
math.random(upper) == RandomInt(1, upper)
math.random(lower, upper) == RandomInt(lower, upper)
```

## Random Vector
Get a random 2D vector.
```lua
Vector RandomVector(float maxLength)
```

## Register Spawn Group Filter Proxy
Create a C proxy for a script-based spawn group filter.
```lua
void RegisterSpawnGroupFilterProxy(string string_1)
```

## Reload MOTD
Reloads the MotD file
```lua
void ReloadMOTD()
```

## Remove Spawn Group Filter Proxy
Remove the C proxy for a script-based spawn group filter.
```lua
void RemoveSpawnGroupFilterProxy(string string_1)
```

## Resolve NPC Positions
Check and fix units that have been assigned a position inside collision radius of other NPCs.
```lua
void ResolveNPCPositions(Vector Vector_1, float float_2)
```

## Roll Percentage
Rolls a number from 1 to 100 and returns true if the roll is less than or equal to the number specified.
```lua
bool RollPercentage(int limit)
```
```lua
function RollPercentage(limit)
  return RandomInt(1, 100) < limit
end
```

## Rotate Orientation
Rotate a QAngle by another QAngle.
```lua
QAngle RotateOrientation(QAngle QAngle_1, QAngle QAngle_2)
```

## Rotate Position
Rotate a Vector around a point.
```lua
Vector RotatePosition(Vector origin, QAngle rotation, Vector relativePosition)
```

## Rotate Quaternion By Axis Angle
Rotates a quaternion by the specified angle around the specified vector axis.
```lua
Quaternion RotateQuaternionByAxisAngle(Quaternion Quaternion_1, Vector Vector_2, float float_3)
```

## Rotation Delta
Find the delta between two QAngles.
```lua
QAngle RotationDelta(QAngle QAngle_1, QAngle QAngle_2)
```

## Rotation Delta As Angular Velocity
Converts delta QAngle to an angular velocity Vector.
```lua
Vector RotationDeltaAsAngularVelocity(QAngle QAngle_1, QAngle QAngle_2)
```

## rr Add Decision Rule
Add a rule to the decision database.
```lua
bool rr_AddDecisionRule(handle handle_1)
```

## rr Commit AI Response
Commit the result of QueryBestResponse back to the given entity to play.
```lua
bool rr_CommitAIResponse(handle entity, handle AiResponse)
```

## rr Get Response Targets
Retrieve a table of all available expresser targets, in the form ``{ name : handle, name: handle }``.
```lua
handle rr_GetResponseTargets()
```

## rr Query Best Response
Static : tests 'query' against entity's response system and returns the best response found (or nil if none found).
```lua
bool rr_QueryBestResponse(handle entity, handle query, handle result)
```

## Say
Have Entity say string, and teamOnly or not.
```lua
void Say(handle entity, string message, bool teamOnly)
```

## Screen Shake
Start a screenshake with the following parameters.
```lua
void ScreenShake(Vector center, float amplitude, float frequency, float duration, float radius, int command, bool airSHake)
command = SHAKE_START = 0
command = SHAKE_STOP = 1
```

## Send Frostivus Time Elapsed To GC

```lua
void SendFrostivusTimeElapsedToGC()
```

## Send Frosty Points Message To GC

```lua
void SendFrostyPointsMessageToGC(handle handle_1)
```

## Send Overhead Event Message
`targetPlayer` and `sourcePlayer` can be nil - `messageType` is one of `OVERHEAD_ALERT_*`
```lua
void SendOverheadEventMessage(handle targetPlayer, int messageType, handle targetEntity, int value, handle sourcePlayer)
```

## Send To Console
Send a string to the console as a client command.
```lua
void SendToConsole(string command)
```

## Send To Server Console
Send a string to the console as a server command.
```lua
void SendToServerConsole(string command)
```

## Set Opvar Float All
Sets an opvar value for all players.
```lua
void SetOpvarFloatAll(string stackName, string operatorName, string opvarName, float opvarValue)
```

## Set Opvar Float Player
Sets an opvar value for a single player.
```lua
void SetOpvarFloatPlayer(string stackName, string operatorName, string opvarName, float opvarValue, handle entity)
```

## Set Phys Angular Velocity
Set angular velocity for VPHYS or normal object, from a vector of the axis of rotation multiplied by the degrees of rotation per second.
```lua
void SetPhysAngularVelocity(handle handle_1, Vector axis)
```

## Set Quest Name
Set the current quest name.
```lua
void SetQuestName(string string_1)
```
TODO quest names

## Set Quest Phase
Set the current quest phase.
```lua
void SetQuestPhase(int int_1)
```

## Set Rendering Enabled
Set rendering on/off for an ehandle.
```lua
void SetRenderingEnabled(ehandle ehandle_1, bool enabled)
```

## Set Team Custom Healthbar Color

```lua
void SetTeamCustomHealthbarColor(int teamNumber, int colorRed, int colorGreen, int colorBlue)
```

## ShowC ustom Header Message
Displays a header message from player.
```lua
void ShowCustomHeaderMessage(string message, int player, int value, float time)
```

## Show Generic Popup
Shows a generic popup to all users.
```lua
void ShowGenericPopup(string title, string content, string unknown, string unknown, int containerType)
```
TODO unknown

## Show Generic Popup To Player
Show a generic popup dialog to a specific player.
```lua
void ShowGenericPopupToPlayer(handle handle_1, string string_2, string string_3, string string_4, string string_5, int int_6)
```

## Show Message
Print a hud message on all clients.
```lua
void ShowMessage(string string_1)
```

## Spawn Entity From Table Synchronous
Synchronously spawns a single entity from a table.
```lua
handle SpawnEntityFromTableSynchronous(string string_1, handle handle_2)
```

## Spawn Entity Group From Table
Hierarchically spawn an entity group from a set of spawn tables.
```lua
bool SpawnEntityGroupFromTable(handle groupSpawnTables, bool bAsync, handle hCallback)
```

## Spawn Entity List From Table Asynchronous
Asynchronously spawn an entity group from a list of spawn table's.
A callback will be triggered when the spawning is complete.
```lua
int SpawnEntityListFromTableAsynchronous(handle table, handle callback)

```
TODO table content?
## Spawn Entity List From Table Synchronous
Synchronously spawn an entity group from a list of spawn table's.
```lua
handle SpawnEntityListFromTableSynchronous(handle table)
```
TODO table content?

## Spline Quaternions
Very basic interpolation of v0 to v1 over t on [0,1]
```lua
Quaternion SplineQuaternions(Quaternion v0, Quaternion v1, float t)
```

## Spline Vectors
Very basic interpolation of v0 to v1 over t on [0,1]
```lua
Vector SplineVectors(Vector v0, Vector v1, float t)
```

## Start Sound Event
Start a sound event.
```lua
void StartSoundEvent(string soundName, handle handle_2)
```

## Start Sound Event From Position
Start a sound event from position.
```lua
void StartSoundEventFromPosition(string soundName, Vector Vector_2)
```

## Start Sound Event From Position Reliable
Start a sound event from position with reliable delivery.
```lua
void StartSoundEventFromPositionReliable(string soundName, Vector Vector_2)
```

## Start Sound Event From Position Unreliable
Start a sound event from position with optional delivery.
```lua
void StartSoundEventFromPositionUnreliable(string soundName, Vector Vector_2)
```

## Start Sound Event Reliable
Start a sound event with reliable delivery.
```lua
void StartSoundEventReliable(string soundName, handle handle_2)
```

## Start Sound Event Unreliable
Start a sound event with optional delivery.
```lua
void StartSoundEventUnreliable(string soundName, handle handle_2)
```

## Stop Effect

```lua
void StopEffect(handle entity, string effectName)
```

## Stop Listening To All Game Events
Stop listening to all game events within a specific context.
```lua
void StopListeningToAllGameEvents(handle handle_1)
```

## Stop Listening To Game Event
Stop listening to a particular game event.
```lua
bool StopListeningToGameEvent(int int_1)
```

## Stop Sound Event
Stops a sound event.
```lua
void StopSoundEvent(string string_1, handle handle_2)
```

## Stop Sound On
Stop named sound on Entity.
```lua
void StopSoundOn(string soundName, handle playingEntity)
```

## String To File
`*` Directory traversal doesn't seem to work.
The characters `.`, `/` and `\\` are ignored.
```lua
bool StringToFile(string a, string b)
```

## Time
Get the current server time.
```lua
float Time()
```

## Trace Collideable
Does a raytrace against a single entity.
Input and output parameters are stored in the specified table.
```lua
bool TraceCollideable(table parameters)
```
[ValveSoftware Wiki](https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API/Global.TraceCollideable)
```lua
-- Traces a line 100 units forward from the postion of the player, trying to find an entity named "my_prop".
-- If the trace hits, a line is drawn to the hit position, along with the surface normal.
local playerEnt = Entities:FindByClassname(nil, "player")
local startVector = playerEnt:GetOrigin() + Vector(0, 0, 32)
local traceTable =
{
	startpos = startVector;

	-- Traces from the player position 100 units in front of the player
	endpos = startVector + RotatePosition(Vector(0,0,0), playerEnt:GetAngles(), Vector(100, 0, 0));
	ent = Entities:FindByName(nil, "my_prop"); -- Traces the entity named "my_prop"

	-- Adds an extra 20 x 20 x 20 bounding box on the model.
	mins = Vector(-10, -10, -10 );
	maxs = Vector(10, 10, 10 )
}

TraceCollideable(traceTable)

if traceTable.hit
then
	DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, false, 1)
	DebugDrawLine(traceTable.pos, traceTable.pos + traceTable.normal * 10, 0, 0, 255, false, 1)
else
	DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, false, 1)
end
```

## Trace Hull
Traces a bounding box along a line.
Input and output parameters are stored in the specified table.
```lua
bool TraceHull(table parameters)
```
[ValveSoftware Wiki](https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API/Global.TraceHull)
```lua
-- Traces a line 100 units forward from the postion of the player, using the players bounding box.
-- If the trace hits, a line is drawn to the hit position.
local playerEnt = Entities:FindByClassname(nil, "player")
local startVector = playerEnt:GetCenter()
local traceTable =
{
	startpos = startVector;
	endpos = startVector + RotatePosition(Vector(0,0,0), playerEnt:GetAngles(), Vector(100, 0, 0));
	ignore = playerEnt;
	mask =  33636363; -- TRACE_MASK_PLAYER_SOLID from L4D2 script API, may not be correct for Source 2.
	min = playerEnt:GetBoundingMins();
	max = playerEnt:GetBoundingMaxs()
}

TraceHull(traceTable)

if traceTable.hit
then
	DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, false, 1)
	DebugDrawLine(traceTable.pos, traceTable.pos + traceTable.normal * 10, 0, 0, 255, false, 1)
else
	DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, false, 1)
end
```

## Trace Line
Does a raytrace along a line.
Input and output parameters are stored in the specified table.
```lua
bool TraceLine(table parameters)
```
[ValveSoftware Wii](https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API/Global.TraceLine)
```lua
-- Traces a line 100 units forward from the postion of the player
-- If the trace hits, a line is drawn to the hit position.
local playerEnt = Entities:FindByClassname(nil, "player")
local startVector = playerEnt:GetCenter()
local traceTable =
{
	startpos = startVector;
	endpos = startVector + RotatePosition(Vector(0,0,0), playerEnt:GetAngles(), Vector(100, 0, 0));
	ignore = playerEnt;
	mask =  33636363 -- TRACE_MASK_PLAYER_SOLID from L4D2 script API, may not be correct for Source 2.
}

TraceLine(traceTable)

if traceTable.hit
then
	DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, false, 1)
	DebugDrawLine(traceTable.pos, traceTable.pos + traceTable.normal * 10, 0, 0, 255, false, 1)
else
	DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, false, 1)
end
```

## Unit Filter
Check if a unit passes a set of filters.
```lua
int UnitFilter(handle npc, int targetTeam, int targetType, int targetFlags, int teamNumber)
```

## Unload Spawn Group
Unload a spawn group by name.
```lua
void UnloadSpawnGroup(string spawnGroupName)
```

## Unload Spawn Group By Handle
Unload a spawn group by handle.
```lua
void UnloadSpawnGroupByHandle(int spawnGroupHandle)
```

## Update Event Points

```lua
void UpdateEventPoints(handle handle_1)
```

## UTIL Message Text
Displays a message for a specific player.
```lua
void UTIL_MessageText(int playerId, string message, int colorRed, int colorGreen, int colorBlue, int colorAlpha)
```

## UTIL Message Text With Context
Sends a message to a specific player in the message box with a context table.
```lua
void UTIL_MessageText_WithContext(int playerId, string message, int colorRed, int colorGreen, int colorBlue, int colorAlpha, table context)
```

## UTIL Message Text All
Sends a message to everyone in the message box.
```lua
void UTIL_MessageTextAll(string message, int colorRed, int colorGreen, int colorBlue, int colorAlpha)
```

## UTIL Message Text All With Context
Sends a message to everyone in the message box with a context table.
```lua
void UTIL_MessageTextAll_WithContext(string message, int colorRed, int colorGreen, int colorBlue, int colorAlpha, table context)
```

## UTIL Remove
Removes the specified entity.
```lua
void UTIL_Remove(handle handle_1)
```

## UTIL Remove Immediate
[b]Do Not use this function.[/b]
Use UTIL_Remove() instead.
This will crash your game.
```lua
void UTIL_RemoveImmediate(handle handle_1)
```

## UTIL Reset Message Text
Resets the message text for the player.
```lua
void UTIL_ResetMessageText(int playerId)
```

## UTIL Reset Message Text All
Resets the message text for all players.
```lua
void UTIL_ResetMessageTextAll()
```

## Vector To Angles
Get Qangles (with no roll) for a Vector.
```lua
QAngle VectorToAngles(Vector Vector_1)
```

## Warning
Print a warning.
```lua
void Warning(string string_1)
```
