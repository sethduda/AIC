#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified command control

	Parameter(s):
	_this select 0: STRING - command control id	
	_this select 1: NUMBER - Alpha (Optional - if set, this alpha value will be used for all drawing actions. If set to -1, alpha will not be changed)

	Returns: 
	Nothing

*/

if(isDedicated || !hasInterface) exitWith {};

private ["_commandId","_alpha"];

_commandId = param [0];
_alpha = param [1,-1];

if(AIC_fnc_getCommandControlShown(_commandId)) then {

	private ["_groupControls"];
	_groupControls = AIC_fnc_getCommandControlGroupsControls(_commandId);
	{
		[_x,_alpha] call AIC_fnc_drawGroupControl;
	} forEach _groupControls;

};