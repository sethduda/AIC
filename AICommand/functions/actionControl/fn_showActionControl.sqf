#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Show the specified action control on the map of the calling player

	Parameter(s):
	_this select 0: STRING - action control id
	_this select 1: BOOLEAN - show control

	Returns: 
	Nothing
*/

private ["_actionControlId","_showControl","_actionType"];

_actionControlId = param [0];
_showControl = param [1];

[_actionControlId,_showControl] call AIC_fnc_setMapElementVisible;

AIC_fnc_setActionControlShown(_actionControlId,_showControl);
