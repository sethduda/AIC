#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Sets the color of a group

	Parameter(s):
	_this select 0: GROUP - group
	_this select 1: STRING - Color name

	Returns: 
	Nothing
*/

private ["_group","_colorName"];

_group = param [0];
_colorName = param [1];

_group setVariable ["AIC_Group_Color",_colorName,true];