#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Event handler manager. Takes care of making sure other addons don't take over control of the event handlers.

	Parameter(s):
	Nothing
	
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

[] spawn {
	waitUntil {!isNull AIC_MAP_CONTROL && !isNull AIC_MAIN_DISPLAY && !isNull AIC_MAP_DISPLAY};
	sleep 60;
	while {true} do {
		_eventHandlers = AIC_fnc_getEventHandlers();
		_index = 0;
		{
			_x params ["_eventHandlerId","_handlerParams"];
			_handlerParams params ["_handlerType","_eventType","_eventScript"];
			[_handlerType, _eventType, _eventHandlerId] call AIC_fnc_removeEventHandler;
			_eventHandlerId = _handlerParams call AIC_fnc_addEventHandler;
			_eventHandlers set [_index,[_eventHandlerId,_handlerParams]];
			_index = _index + 1;
		} forEach _eventHandlers;
		sleep (5 * 60);
	};
};
