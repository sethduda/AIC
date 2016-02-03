#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Orders a unit to get in a vehicle is a specific slot
	
	Parameter(s):
	_this select 0: OBJECT - Unit
	_this select 1: OBJECT - Vehicle
	_this select 2: ARRAY - Role
		
	Returns: 
	Nothing
	
*/

private ["_unit","_vehicle","_role"];

_unit = param [0];
_vehicle = param [1];
_role = param [2];


unassignVehicle _unit;

[_unit] allowGetIn true;
if((_role select 0) == "Driver") then {
	_unit assignAsDriver _vehicle;
};
if((_role select 0) == "Turret") then {
	_unit assignAsTurret [_vehicle,_role select 1];
};
if((_role select 0) == "Cargo") then {
	_unit assignAsCargoIndex [_vehicle,(_role select 1) select 0];
};

[_unit] orderGetIn true;
