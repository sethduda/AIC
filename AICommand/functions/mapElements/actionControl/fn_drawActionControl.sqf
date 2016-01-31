#include "functions.h"
#include "..\interactiveIcon\functions.h"
#include "..\commandControl\functions.h"
#include "..\groupControl\functions.h"
#include "..\functions.h"
#include "..\..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified action control on the map

	Parameter(s):
	_this select 0: STRING - Action Control ID
		
	Returns: 
	Nothing
*/

private ["_actionControlId"];

_actionControlId = param [0];

if!(AIC_fnc_getMapElementVisible(_actionControlId)) exitWith {};

private ["_actionType"];

_actionType = AIC_fnc_getActionControlType(_actionControlId);

if(_actionType == "ASSIGN_GROUP_VEHICLE") then {

	private ["_contolData","_vehicleIcons","_icon","_iconVehicle","_parameters","_groupControlId","_lineColor","_groupControlInteractiveIconId","_groupControlPosition"];
	
	_contolData = AIC_fnc_getActionControlData(_actionControlId);
	_parameters = AIC_fnc_getActionControlParameters(_actionControlId);
	_groupControlId = _parameters select 0;
	_groupControlInteractiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
	_groupControlPosition = AIC_fnc_getInteractiveIconPosition(_groupControlInteractiveIconId); 
	
	_vehicleIcons = _contolData select 0;
	{
		_icon = _x select 0;
		_iconVehicle = _x select 1;
		AIC_fnc_setInteractiveIconPosition(_icon,position _iconVehicle);	
		[_icon] call AIC_fnc_drawInteractiveIcon;
	} forEach _vehicleIcons;
	
	_lineColor = ((AIC_fnc_getGroupControlColor(_groupControlId)) select 1) + [1];

	AIC_MAP_CONTROL drawArrow [
		_groupControlPosition,
		(AIC_fnc_getMouseMapPosition()),
		_lineColor
	];
		
};