#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified command control

	Parameter(s):
	_this select 0: STRING - command control id
	_this select 1: BOOLEAN - disable interaction (default false)

	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

private ["_commandId","_interactionDisabled"];

_commandId = param [0];
_interactionDisabled = param [1,false];

if(AIC_fnc_getCommandControlShown(_commandId)) then {

	private ["_groupControls"];
	_groupControls = AIC_fnc_getCommandControlGroupsControls(_commandId);
	{
		[_x,_interactionDisabled] call AIC_fnc_drawGroupControl;
	} forEach _groupControls;

};