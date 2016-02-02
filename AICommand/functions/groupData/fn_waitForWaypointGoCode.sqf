#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Wait for go code

	Parameter(s):
	_this select 0: GROUP - group to add waypoint to
	_this select 1: STRING - go code

	Returns: 
	Nothing
*/

private ["_group","_goCode"];
_group = param [0];
_goCode = param [1,"NONE"];
_group setVariable ["AIC_Wait_For_Go_Code",_goCode, true];