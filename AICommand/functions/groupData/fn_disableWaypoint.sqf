#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Disable a waypoint for a group

	Parameter(s):
	_this select 0: GROUP - group to get waypoint
	_this select 1: NUMBER - waypoint index

	Returns: 
	Nothing
	
*/

private ["_group","_waypointIndex"];

_group = param [0];
_waypointIndex = param [1];

private ["_waypoint"];

_waypoint = [_group, _waypointIndex] call AIC_fnc_getWaypoint;

_waypoint set [2,true];
[_group, _waypoint] call AIC_fnc_setWaypoint;