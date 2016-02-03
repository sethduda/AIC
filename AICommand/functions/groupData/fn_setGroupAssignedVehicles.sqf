#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Set vehicles a group is assigned to 
	
	Parameter(s):
	_this select 0: GROUP - group
	_this select 1: ARRAY - [
		OBJECT - Vehicle, 
		...
	]

	Returns: 
	Nothing
	
*/

private ["_group","_vehicles"];

_group = param [0];
_vehicles = param [1,[]];

_group setVariable ["AIC_Assigned_Vehicles",_vehicles, true];