#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Command menu manager. Prevents left click from triggering action on menu.
	
	Parameter(s):
	Nothing
	
	Returns: 
	Nothing
*/


[] spawn {

if(!hasInterface) exitWith {};

// This function prevents left clicking from triggering the action on the command menu
AIC_fnc_commandMenuAction = {

	private ["_scriptString"];
	_scriptString = param [0];
	
	private ["_startTime","_timeOut","_actionKeyPressed"];
	_startTime = diag_tickTime;
	_timeOut = false;
	_actionKeyPressed = false;
	
	while {!_timeOut && !_actionKeyPressed} do {
		if( diag_tickTime - _startTime > 0.5 ) then {
			_timeOut = true;
		};
		if( abs (diag_tickTime - AIC_Command_Menu_Action_Button_Last_Pressed) < 0.5 ) then {
			_actionKeyPressed = true;
		};
		sleep 0.01;
	};
	
	if(_actionKeyPressed) then {
		_script = compile _scriptString; 
		[] spawn _script;
	};
	
};

AIC_Command_Menu_Action_Button_Last_Pressed = diag_tickTime;

AIC_fnc_commandMenuEventHandler = {

	private ["_event","_eventParams","_actionKeys"];
	
	_event = param [0];
	_eventParams = param [1];
	_actionKeys = actionKeys "ActionContext";
	
	if(_event == "KeyDown" || _event == "MouseButtonDown") then {
		if( (_eventParams select 1) in _actionKeys || (65536 + (_eventParams select 1)) in _actionKeys ) then {
			AIC_Command_Menu_Action_Button_Last_Pressed = diag_tickTime;
		};
	};
	
};	

["MAIN_DISPLAY","KeyDown", "[""KeyDown"",_this] call AIC_fnc_commandMenuEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAIN_DISPLAY","MouseButtonDown", "[""MouseButtonDown"",_this] call AIC_fnc_commandMenuEventHandler"] spawn AIC_fnc_addManagedEventHandler;

};