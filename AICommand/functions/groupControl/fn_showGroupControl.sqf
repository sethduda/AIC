#include "..\interactiveIcon\functions.h"
#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Show the specified group control on the map of the calling player

	Parameter(s):
	_this select 0: STRING - group control id
	_this select 1: BOOLEAN - show control

	Returns: 
	Nothing
*/

private ["_groupControlId","_showControl"];

_groupControlId = param [0];
_showControl = param [1];

private ["_groupControlIcon"];

_groupControlIcon = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
if(!isNil "_groupControlIcon") then {
	AIC_fnc_setInteractiveIconShown(_groupControlIcon,_showControl);
};

AIC_fnc_setGroupControlShown(_groupControlId,_showControl);

private ["_waypointIcons"];
_waypointIcons = AIC_fnc_getGroupControlWaypointIcons(_groupControlId);
{	
	AIC_fnc_setInteractiveIconShown(_x select 1,_showControl);
} forEach _waypointIcons;