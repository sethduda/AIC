#include "..\interactiveIcon\functions.h"
#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Remove the specified group control

	Parameter(s):
	_this select 0: STRING - group control id

	Returns: 
	Nothing
*/

private ["_groupControlId"];

_groupControlId = param [0];

private ["_groupControlIcon","_groupControls","_waypointIcons"];

_groupControls = AIC_fnc_getGroupControls();
_groupControls = _groupControls - [_groupControlId];
AIC_fnc_setGroupControls(_groupControls);

_groupControlIcon = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
if(!isNil "_groupControlIcon") then {
	[_groupControlIcon] call AIC_fnc_removeInteractiveIcon;
};

_waypointIcons = AIC_fnc_getGroupControlWaypointIcons(_groupControlId);
{	
	[_x select 1] call AIC_fnc_removeInteractiveIcon;
} forEach _waypointIcons;