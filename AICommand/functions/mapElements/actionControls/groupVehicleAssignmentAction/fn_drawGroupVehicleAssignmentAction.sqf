#include "..\..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws group vehicle assignment action

	Parameter(s):
	_this select 0: STRING - Map Element ID
		
	Returns: 
	Nothing
*/

private ["_mapElementId"];

_mapElementId = param [0];

if!(AIC_fnc_getMapElementVisible(_mapElementId)) exitWith {};

private ["_groupControlId","_vehicleIcons","_groupControlInteractiveIconId","_groupControlPosition","_lineColor"];

_groupControlId = AIC_fnc_getGroupVehicleAssignmentActionGroupControlId(_mapElementId);
_vehicleIcons = AIC_fnc_getGroupVehicleAssignmentActionVehicleIcons(_mapElementId);
_groupControlInteractiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
_groupControlPosition = AIC_fnc_getInteractiveIconPosition(_groupControlInteractiveIconId); 

if(AIC_fnc_getMapElementForeground(_mapElementId)) then {
	_lineColor = ((AIC_fnc_getGroupControlColor(_groupControlId)) select 1) + [1];
} else {
	_lineColor = ((AIC_fnc_getGroupControlColor(_groupControlId)) select 1) + [0.4];
};

{
	AIC_MAP_CONTROL drawLine [
		_groupControlPosition,
		(AIC_fnc_getInteractiveIconPosition(_x select 1)),
		_lineColor
	];
	[_x select 1] call AIC_fnc_drawInteractiveIcon;
} forEach _vehicleIcons;