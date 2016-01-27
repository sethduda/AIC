#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates command control (executes on server side only)

	Parameter(s):
	_this select 0: STRING - unique command control id

	Returns:
	Nothing
*/

if(!isServer) exitWith {};

private ["_commandId"];

_commandId = param [0];

private ["_commandControls"];

_commandControls = AIC_fnc_getCommandControls();
_commandControls pushBack _commandId;
AIC_fnc_setCommandControls(_commandControls);