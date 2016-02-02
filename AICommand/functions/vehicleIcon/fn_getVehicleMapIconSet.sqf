#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets an icon set for the specified vehicle object

	Parameter(s):
	_this select 0: OBJECT - Vehicle object
	_this select 1: COLOR - Color array

	Returns: 
	ARRAY: Icon Set
*/
private ["_vehicle","_color"];

_vehicle = param [0];
_color = param [1];

private ["_iconSet","_colorName","_vehicleClassName"];

_vehicleClassName = typeOf _vehicle;
_colorName = _color select 0;
_iconSet = missionNamespace getVariable [format ["AIC_Icon_Set_%1_%2", _colorName, _vehicleClassName], nil];

if(isNil "_iconSet") then {

	private ["_iconPath","_colorRgb","_mapIconUnselected","_mapIconMouseOver","_mapIconSelected"];

	_iconPath = [_vehicleClassName] call AIC_fnc_getVehicleIconPath;
	_colorRgb = _color select 1;
	_mapIconUnselected = [_iconPath,32,32,0,_colorRgb + [0.5]] call AIC_fnc_createMapIcon;
	_mapIconMouseOver = [_iconPath,36,36,0,_colorRgb + [0.8]] call AIC_fnc_createMapIcon;
	_mapIconSelected = [_iconPath,32,32,0,_colorRgb + [1]] call AIC_fnc_createMapIcon;

	_iconSet = [];
	_iconSet pushBack [_mapIconUnselected];
	_iconSet pushBack [AIC_SELECTED_GROUP_SELECTOR_ICON, _mapIconSelected];
	_iconSet pushBack [AIC_UNSELECTED_GROUP_SELECTOR_ICON, _mapIconMouseOver];
	_iconSet pushBack [_mapIconSelected];
	
	missionNamespace setVariable [format ["AIC_Icon_Set_%1_%2", _colorName, _vehicleClassName], _iconSet];

};

_iconSet;