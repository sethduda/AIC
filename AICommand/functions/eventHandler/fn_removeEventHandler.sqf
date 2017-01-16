#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Remove an event handler

	Parameter(s):
	_this select 0: STRING - Event handler type ("MAIN_DISPLAY","MAP_DISPLAY","MAP_CONTROL")
	_this select 1: STRING - Event type (e.g. "KeyDown")
	_this select 2: NUMBER - Event handler id
	
	Returns: 
	Nothing
*/

params ["_handlerType","_eventType","_eventHandlerId"];

waitUntil {!isNull AIC_MAP_CONTROL && !isNull AIC_MAIN_DISPLAY && !isNull AIC_MAP_DISPLAY};

if(_eventHandlerId >= 0) then {
	if(_handlerType == "MAIN_DISPLAY") then {
		AIC_MAIN_DISPLAY displayRemoveEventHandler [_eventType, _eventHandlerId];
	};
	if(_handlerType == "MAP_DISPLAY") then {
		AIC_MAP_DISPLAY displayRemoveEventHandler [_eventType, _eventHandlerId];
	};
	if(_handlerType == "MAP_CONTROL") then {
		AIC_MAP_CONTROL ctrlRemoveEventHandler [_eventType, _eventHandlerId];
	};
};
