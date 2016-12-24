#include "..\functions.h"
								
/*
	Author: [SA] Duda

	Description:
	Adds a waypoint to a group

	Parameter(s):
	_this select 0: GROUP - group to add waypoint to
	_this select 1: ARRAY - waypoint params [
		POSITION: waypoint world position,
		BOOLEAN: waypoint disabled,
		STRING: waypoint type,
		STRING: waypoint action script,
		STRING: waypoint condition
		NUMBER: waypoint timeout
		STRING: waypoint formation
		NUMBER: waypoint completion radius,
		NUMBER: waypoint completion radius
	]

	Returns: 
	ARRAY: [
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
*/

private ["_group","_waypointParams"];

_group = param [0];
_waypointParams = param [1];

private ["_waypoints","_revision","_waypointsArray"];

_waypoints = _group getVariable ["AIC_Waypoints",[0,[]]];
_revision = _waypoints select 0;
_waypointsArray = _waypoints select 1;

_waypoint = [count _waypointsArray] + _waypointParams;
_waypointsArray pushBack _waypoint;

_revision = _revision + 1;

_group setVariable ["AIC_Waypoints",[_revision,_waypointsArray], true];

_waypoint;