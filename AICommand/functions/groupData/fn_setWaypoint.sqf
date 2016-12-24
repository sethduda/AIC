#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Sets a waypoint for a group

	Parameter(s):
	_this select 0: GROUP - group to set waypoint
	_this select 1: ARRAY: [
		NUMBER: waypoint index,
		POSITION: waypoint world position,
		BOOLEAN: waypoint disabled,
		STRING: waypoint type,
		STRING: waypoint action script,
		STRING: waypoint condition
		NUMBER: waypoint timeout
		STRING: waypoint formation
		NUMBER: waypoint completion radius
	]

	Returns: 
	Nothing
	
*/

private ["_group","_waypoint","_waypointIndex"];

_group = param [0];
_waypoint = param [1];
_waypointIndex = _waypoint select 0;

private ["_waypoints","_revision","_waypointsArray"];

_waypoints = (_group getVariable ["AIC_Waypoints",[0,[]]]);
_revision = _waypoints select 0;
_waypointsArray = _waypoints select 1;

_waypointsArray set [_waypointIndex,_waypoint];
_revision = _revision + 1;
_group setVariable ["AIC_Waypoints",[_revision,_waypointsArray], true];