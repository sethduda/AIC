#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Get all active waypoints for a group

	Parameter(s):
	_this select 0: GROUP - group to get all waypoints

	Returns: 
	ARRAY: [
		NUMBER: Revision,
		ARRAY: [[
			NUMBER: waypoint index
			POSITION: waypoint world position,
			BOOLEAN: waypoint disabled
			STRING: waypoint type
		],...]
*/

private ["_group","_activeWaypoints","_allWaypoints","_allWaypointsRevision","_allWaypointsArray"];
_group = param [0];
_allWaypoints = _group getVariable ["AIC_Waypoints",[0,[]]];
_allWaypointsRevision = _allWaypoints select 0;
_allWaypointsArray = _allWaypoints select 1;
_activeWaypoints = [];
{
	if!(_x select 2) then {
		_activeWaypoints pushBack _x;
	};
} forEach _allWaypointsArray;
[_allWaypointsRevision,_activeWaypoints];