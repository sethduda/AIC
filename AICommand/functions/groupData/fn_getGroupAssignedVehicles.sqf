#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Get vehicles a group is assigned to 
	
	Parameter(s):
	_this select 0: GROUP - group

	Returns: 
	ARRAY - [
		OBJECT - Vehicle, 
		...
	]
	
*/
private ["_group","_assignedVehicles"];
_group = param [0];
_assignedVehicles = _group getVariable ["AIC_Assigned_Vehicles",[]];
{
	if( _x != vehicle _x ) then {
		_assignedVehicles = _assignedVehicles + [vehicle _x];
	};
} forEach (units _group);
_assignedVehicles;