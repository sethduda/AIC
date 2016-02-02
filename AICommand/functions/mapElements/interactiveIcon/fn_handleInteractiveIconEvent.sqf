#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for interactive icons

	Parameter(s):
	_this select 0: STRING - Interactive Icon ID
	_this select 1: STRING - Event ("SELECTED","DESELECTED","DROPPED",etc)
	_this select 2: ANY - params
		
	Returns: 
	Nothing
*/

private ["_interactiveIconId","_event","_params","_eventHandler","_eventHandlerParams"];

_interactiveIconId = param [0];
_event = param [1];
_params = param [2,[]];

_eventHandler = AIC_fnc_getInteractiveIconEventHandlerScript(_interactiveIconId);
_eventHandlerParams = AIC_fnc_getInteractiveIconEventHandlerScriptParams(_interactiveIconId);

[_interactiveIconId,_event,_params,_eventHandlerParams] spawn _eventHandler;

