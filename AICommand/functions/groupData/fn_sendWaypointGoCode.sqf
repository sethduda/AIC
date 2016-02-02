#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	send go code
	Parameter(s):
	_this select 0: GROUP - group to add waypoint to
	_this select 1: STRING - go code

	Returns: 
	Nothing
*/

private ["_group","_goCode","_waitForCode"];
_group = param [0];
_goCode = param [1,"NONE"];

_waitForCode = _group getVariable ["AIC_Wait_For_Go_Code","NONE"];

if(_waitForCode == _goCode) then {
	[_group,"NONE"] call AIC_fnc_waitForWaypointGoCode;
};