#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Add an event handler

	Parameter(s):
	_this select 0: STRING - Event handler type ("MAIN_DISPLAY","MAP_DISPLAY","MAP_CONTROL")
	_this select 1: STRING - Event type (e.g. "KeyDown")
	_this select 2: STRING - Event script
	
	Returns: 
	NUMBER - Event handler id
*/

params ["_handlerType","_eventType","_eventScript"];

waitUntil {!isNull AIC_MAP_CONTROL && !isNull AIC_MAIN_DISPLAY && !isNull AIC_MAP_DISPLAY};

private _eventId = -1;
if(_handlerType == "MAIN_DISPLAY") then {
	_eventId = AIC_MAIN_DISPLAY displayAddEventHandler [_eventType, _eventScript + "; false"];
};
if(_handlerType == "MAP_DISPLAY") then {
	_eventId = AIC_MAP_DISPLAY displayAddEventHandler [_eventType, _eventScript+ "; false"];
};
if(_handlerType == "MAP_CONTROL") then {
	_eventId = AIC_MAP_CONTROL ctrlAddEventHandler [_eventType, _eventScript+ "; false"];
};
_eventId;








