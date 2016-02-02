#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Sets the interactive icon's world position

	Parameter(s):
	_this select 0: STRING - Interactive Icon ID
	_this select 1: STRING -  State ("UNSELECTED","SELECTED")
		
	Returns: 
	Nothing
*/

private ["_interactiveIconId","_state","_currentState"];
_interactiveIconId = param [0];
_state = param [1];
_currentState = missionNamespace getVariable ["AIC_Interactive_Icon_" + _interactiveIconId + "_State","NONE"];
missionNamespace setVariable ["AIC_Interactive_Icon_" + _interactiveIconId + "_State",_state];

if(_currentState != _state || _state == "SELECTED") then {
	// Execute event handler
//	[_interactiveIconId,_state] call AIC_fnc_handleInteractiveIconEvent;
};