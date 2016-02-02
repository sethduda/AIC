#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets icon sets for a group control waypoint 

	Parameter(s):
	_this select 0: STRING - Type
	_this select 1: COLOR - Color array

	Returns: 
	ARRAY - icon set for group control wp
*/

private ["_type","_color"];

_type = param [0];
_color = param [1];

private ["_iconSet","_colorName"];

_colorName = _color select 0;
_iconSet = missionNamespace getVariable ["AIC_Wp_Icon_Set_" + _colorName + "_" + _type, nil];

if(isNil "_iconSet") then {
	_iconSet = [];
	_iconSet pushBack [missionNamespace getVariable ["AIC_UNSELECTED_WP_ICON_" + toUpper _colorName + "_" + toUpper _type,nil]];
	_iconSet pushBack [missionNamespace getVariable ["AIC_SELECTED_WP_ICON_" + toUpper _colorName + "_" + toUpper _type,nil]];
	_iconSet pushBack [missionNamespace getVariable ["AIC_MOUSE_OVER_WP_ICON_" + toUpper _colorName + "_" + toUpper _type,nil]];
	_iconSet pushBack [missionNamespace getVariable ["AIC_PICKED_UP_WP_ICON_" + toUpper _colorName + "_" + toUpper _type,nil]];
	missionNamespace setVariable ["AIC_Icon_Set_" + _colorName + "_" + _type, _iconSet];
};
_iconSet;