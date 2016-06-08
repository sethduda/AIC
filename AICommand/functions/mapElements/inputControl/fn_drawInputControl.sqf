#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified input control on the map

	Parameter(s):
	_this select 0: STRING - Input Control ID
		
	Returns: 
	Nothing
*/

private ["_inputControlId"];

_inputControlId = param [0];

if!(AIC_fnc_getMapElementVisible(_inputControlId)) exitWith {};

private ["_inputType"];

_inputType = AIC_fnc_getInputControlType(_inputControlId);

if(_inputType == "VEHICLE") then {

	private ["_contolData","_vehicleIcons","_icon","_iconVehicle","_parameters","_groupControlId","_lineColor","_groupControlInteractiveIconId","_groupControlPosition"];
	
	_contolData = AIC_fnc_getInputControlData(_inputControlId);
	_parameters = AIC_fnc_getInputControlParameters(_inputControlId);
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


if(_inputType == "GROUP") then {

	private ["_contolData","_groupIcons","_icon","_iconVehicle","_parameters","_groupControlId","_lineColor","_groupControlInteractiveIconId","_groupControlPosition"];
	
	_contolData = AIC_fnc_getInputControlData(_inputControlId);
	_parameters = AIC_fnc_getInputControlParameters(_inputControlId);
	_groupControlId = _parameters select 0;
	_groupControlInteractiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
	_groupControlPosition = AIC_fnc_getInteractiveIconPosition(_groupControlInteractiveIconId); 
	
	_groupIcons = _contolData select 0;
	{
		_icon = _x select 0;
		[_icon] call AIC_fnc_drawInteractiveIcon;
	} forEach _groupIcons;
	
	_lineColor = ((AIC_fnc_getGroupControlColor(_groupControlId)) select 1) + [1];

	AIC_MAP_CONTROL drawArrow [
		_groupControlPosition,
		(AIC_fnc_getMouseMapPosition()),
		_lineColor
	];
		
};

if(_inputType == "POSITION") then {

	private ["_vehicleIcons","_icon","_iconVehicle","_parameters","_groupControlId","_lineColor","_groupControlInteractiveIconId","_groupControlPosition"];

	_parameters = AIC_fnc_getInputControlParameters(_inputControlId);
	_groupControlId = _parameters select 0;
	_groupControlInteractiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
	_groupControlPosition = AIC_fnc_getInteractiveIconPosition(_groupControlInteractiveIconId); 

	_lineColor = ((AIC_fnc_getGroupControlColor(_groupControlId)) select 1) + [1];

	AIC_MAP_CONTROL drawArrow [
		_groupControlPosition,
		(AIC_fnc_getMouseMapPosition()),
		_lineColor
	];
		
};