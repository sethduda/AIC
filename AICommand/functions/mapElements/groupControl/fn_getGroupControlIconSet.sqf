#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets icon sets for a group control 

	Parameter(s):
	_this select 0: GROUP - Group
	_this select 1: COLOR - Color array

	Returns: 
	ARRAY - icon set for group control
*/

private ["_group","_color"];

_group = param [0];
_color = param [1];

private ["_groupType","_iconSet","_colorName"];

_colorName = _color select 0;
_groupType = _group call AIC_fnc_getGroupIconType;
_iconSet = missionNamespace getVariable [format ["AIC_Icon_Set_%1_%2", _colorName, _groupType], nil];

if(isNil "_iconSet") then {
	_iconSet = [];
	_iconSet pushBack [AIC_UNSELECTED_GROUP_SELECTOR_ICON, missionNamespace getVariable ["AIC_UNSELECTED_GROUP_ICON_" + toUpper _colorName + "_" + toUpper _groupType,nil]];
	_iconSet pushBack [AIC_SELECTED_GROUP_SELECTOR_ICON, missionNamespace getVariable ["AIC_SELECTED_GROUP_ICON_" + toUpper _colorName + "_" + toUpper _groupType,nil]];
	_iconSet pushBack [AIC_MOUSE_OVER_GROUP_SELECTOR_ICON, missionNamespace getVariable ["AIC_MOUSE_OVER_GROUP_ICON_" + toUpper _colorName + "_" + toUpper _groupType,nil]];
	_iconSet pushBack [AIC_PICKED_UP_SELECTOR_ICON, missionNamespace getVariable ["AIC_PICKED_UP_GROUP_ICON_" + toUpper _colorName + "_" + toUpper _groupType,nil]];
	missionNamespace setVariable ["AIC_Icon_Set_" + _colorName + "_" + _groupType, _iconSet];
};
_iconSet;