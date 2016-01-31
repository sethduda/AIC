#include "..\mapElements\interactiveIcon\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets the interactive icon for a vehicle object. If one doesn't exist, a new one is created. Updates
	interactive icon position each time you get it.

	Parameter(s):
	_this select 0: OBJECT - Vehicle object
	_this select 1: BOOLEAN - Update position to latest vehicle position (optional, default false)

	Returns: 
	STRING: Interactive Icon Id
*/

private ["_vehicle","_updatePosition","_interactiveIconId"];

_vehicle = param [0];
_updatePosition = param [1,false];

_interactiveIconId = _vehicle getVariable ["AIC_Vehicle_Interative_Icon",nil];

if(isNil "_interactiveIconId") then {
	private ["_iconSet"];
	_iconSet = [_vehicle,AIC_COLOR_RED] call AIC_fnc_getVehicleMapIconSet;
	_interactiveIconId = [_iconSet, position _vehicle] call AIC_fnc_createInteractiveIcon;
	_vehicle setVariable ["AIC_Vehicle_Interative_Icon",_interactiveIconId];
} else {
	if(_updatePosition) then {
		AIC_fnc_setInteractiveIconPosition(_interactiveIconId, position _vehicle);
	};
};

_interactiveIconId;


