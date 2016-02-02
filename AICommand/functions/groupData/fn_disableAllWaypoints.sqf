#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Disable all waypoints for a group

	Parameter(s):
	_this select 0: GROUP - group to disable all waypoints

	Returns: 
	Nothing
	
*/

private ["_group"];

_group = param [0];

private ["_waypoints"];

_waypoints = [_group] call AIC_fnc_getAllWaypoints;

{
	[_group, _x select 0] call AIC_fnc_disableWaypoint;
} forEach (_waypoints select 1);