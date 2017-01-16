#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Add a managed event handler (will ensure that it doesn't get disabled by other addons)

	Parameter(s):
	_this select 0: STRING - Event handler type ("MAIN_DISPLAY","MAP_DISPLAY","MAP_CONTROL")
	_this select 1: STRING - Event type (e.g. "KeyDown")
	_this select 2: STRING - Event script
	
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

params ["_handlerType","_eventType","_eventScript"];
waitUntil {!isNull AIC_MAP_CONTROL && !isNull AIC_MAIN_DISPLAY && !isNull AIC_MAP_DISPLAY};
private _eventHandlers = AIC_fnc_getEventHandlers();
private _eventHandlerId = _this call AIC_fnc_addEventHandler;
_eventHandlers pushBack [_eventHandlerId,_this];
AIC_fnc_setEventHandlers(_eventHandlers);








