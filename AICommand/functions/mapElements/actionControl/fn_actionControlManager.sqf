#include "functions.h"
#include "..\interactiveIcon\functions.h"
#include "..\..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for action controls

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

// Setup UI event handlers

[] spawn {
	waitUntil {!isNull AIC_MAP_CONTROL};
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonDown", "[nil, ""MouseButtonDown"",_this] call AIC_fnc_actionControlEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonClick", "[nil, ""MouseButtonClick"",_this] call AIC_fnc_actionControlEventHandler" ];
};

[] spawn {
	waitUntil {!isNull AIC_MAIN_DISPLAY};
	AIC_MAIN_DISPLAY displayAddEventHandler ["KeyDown", "[nil, ""KeyDown"",_this] call AIC_fnc_actionControlEventHandler" ];
};





