#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for input controls

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

// Setup UI event handlers

["MAP_CONTROL","MouseButtonDown", "[nil, ""MouseButtonDown"",_this] call AIC_fnc_inputControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseButtonClick", "[nil, ""MouseButtonClick"",_this] call AIC_fnc_inputControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAIN_DISPLAY","KeyDown", "[nil, ""KeyDown"",_this] call AIC_fnc_inputControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;




