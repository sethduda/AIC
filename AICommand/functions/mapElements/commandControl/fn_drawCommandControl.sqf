#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified command control

	Parameter(s):
	_this select 0: STRING - command control id	

	Returns: 
	Nothing

*/

if(isDedicated || !hasInterface) exitWith {};

private ["_commandId"];

_commandId = param [0];

if(AIC_fnc_getMapElementVisible(_commandId)) then {

	private ["_groupControls"];
	_groupControls = AIC_fnc_getCommandControlGroupsControls(_commandId);
	{
		[_x] call AIC_fnc_drawGroupControl;
	} forEach _groupControls;

};