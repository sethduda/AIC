#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Removes a group from the specified command control

	Parameter(s):
	_this select 0: STRING - command control id
	_this select 1: GROUP - group to remove

	Returns: 
	Nothing
*/

private ["_commandId","_group"];

_commandId = param [0];
_group = param [1];

private ["_groupsUnderCommand"];

_groupsUnderCommand = AIC_fnc_getCommandControlGroups(_commandId);
if(_group in _groupsUnderCommand) then {
	_groupsUnderCommand = _groupsUnderCommand - [_group];
	AIC_fnc_setCommandControlGroups(_commandId,_groupsUnderCommand);
};


