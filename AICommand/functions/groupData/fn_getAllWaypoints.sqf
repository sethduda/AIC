#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Get all waypoints for a group

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

private ["_group"];
_group = param [0];
_group getVariable ["AIC_Waypoints",[0,[]]];