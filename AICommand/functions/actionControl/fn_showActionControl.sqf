#include "..\interactiveIcon\functions.h"
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
_actionType = AIC_fnc_getActionControlType(_actionControlId);

if(_actionType == "ASSIGN_GROUP_VEHICLE") then {
	private ["_contolData","_vehicleIcons","_interactiveIconId"];
	_contolData = AIC_fnc_getActionControlData(_actionControlId);
	_vehicleIcons = _contolData select 0;
	{
		_interactiveIconId = (_x select 0);
		AIC_fnc_setInteractiveIconShown(_interactiveIconId, _showControl);
	} forEach _vehicleIcons;
};

AIC_fnc_setActionControlShown(_actionControlId,_showControl);
