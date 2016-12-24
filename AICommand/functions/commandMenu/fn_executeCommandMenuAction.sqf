#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Execute a command menu action
	
	Parameter(s):
	_this select 0: NUMBER - Command menu action index
	_this select 1: ARRAY - Command menu params (defaults to [])
		
	Returns: 
	Nothing
*/

params [["_actionIndex",-1],["_menuParams",[]]];

private ["_actions","_handler","_actionParams"];

_actions = AIC_fnc_getCommandMenuActions();

if(count _actions > _actionIndex && _actionIndex >= 0) then {
	_handler = (_actions select _actionIndex) select 3;
	_actionParams = (_actions select _actionIndex) select 4;
	[_menuParams,_actionParams] spawn _handler;
};