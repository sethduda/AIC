#include "..\..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates a group vehicle assignment action

	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 1: GROUP - Group
	_this select 2: ARRAY - [ OBJECT - assigned vehicle, ... ] 
	
	Returns: 
	STRING - Map Element ID
*/

private ["_groupControlId","_group","_vehicles"];

_groupControlId = param [0];
_group = param [1];
_vehicles = param [2,[]];

//hint str _this;

private ["_mapElementId","_actions","_color","_interactiveIcon","_vehicleIcons"];

_mapElementId = ["AIC_fnc_deleteGroupVehicleAssignmentAction"] call AIC_fnc_createMapElement;

AIC_fnc_setGroupVehicleAssignmentActionGroupControlId(_mapElementId,_groupControlId);
AIC_fnc_setGroupVehicleAssignmentActionGroup(_mapElementId,_group);

AIC_fnc_setGroupVehicleAssignmentActionVehicles(_mapElementId,_vehicles);

// Create interactive icons for each of the assigned vehicles

_color = AIC_fnc_getGroupControlColor(_groupControlId);

_vehicleIcons = [];
{
	_interactiveIcon = [_x,_color] call AIC_fnc_createVehicleInteractiveIcon;
	_vehicleIcons pushBack [_x,_interactiveIcon];
	[_mapElementId,_interactiveIcon] call AIC_fnc_addMapElementChild;
} forEach _vehicles;

AIC_fnc_setGroupVehicleAssignmentActionVehicleIcons(_mapElementId,_vehicleIcons);

_actions = AIC_fnc_getGroupVehicleAssignmentActions();
_actions pushBack _mapElementId;
AIC_fnc_setGroupVehicleAssignmentActions(_actions);

_mapElementId;