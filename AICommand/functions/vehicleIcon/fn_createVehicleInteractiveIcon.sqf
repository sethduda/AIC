#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates an interactive icon for a vehicle object.

	Parameter(s):
	_this select 0: OBJECT - Vehicle object
	_this select 1: COLOR - AIC Color (optional, default AIC_COLOR_BLUE)

	Returns: 
	STRING: Interactive Icon Id
*/

private ["_vehicle","_interactiveIconId"];

_vehicle = param [0];
_color = param [1,AIC_COLOR_BLUE];

private ["_iconSet"];

_iconSet = [_vehicle,_color] call AIC_fnc_getVehicleMapIconSet;
_interactiveIconId = [_iconSet, position _vehicle] call AIC_fnc_createInteractiveIcon;

_interactiveIconId;


