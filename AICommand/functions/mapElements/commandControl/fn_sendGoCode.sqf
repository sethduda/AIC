#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Sends the specified go code to all visible command controls. Must be executed on client issuing command.

	Parameter(s):
	_this select 0: STRING - Go code

	Returns: 
	Nothing
*/
private ["_goCode","_commandControlId"];

_goCode = param [0];

{
	_commandControlId = _x;
	if(AIC_fnc_getMapElementVisible(_commandControlId)) then {
		{
			[_x,_goCode] call AIC_fnc_sendWaypointGoCode;
		} forEach (AIC_fnc_getCommandControlGroups(_commandControlId));		
	};
} forEach (AIC_fnc_getCommandControls());