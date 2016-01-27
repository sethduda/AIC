#include "functions.h"
#include "..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Runtime manager for interactive icons. Starts up all of the UI event handlers.

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

[] spawn {
	waitUntil {!isNull AIC_MAP_CONTROL};
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonClick", "[""MouseButtonClick"",_this] call AIC_fnc_interactiveIconEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseMoving", "[""MouseMoving"",_this] call AIC_fnc_interactiveIconEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonDown", "[""MouseButtonDown"",_this] call AIC_fnc_interactiveIconEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonUp", "[""MouseButtonUp"",_this] call AIC_fnc_interactiveIconEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseHolding", "[""MouseHolding"",_this] call AIC_fnc_interactiveIconEventHandler" ];
};

[] spawn {
	waitUntil {!isNull AIC_MAP_DISPLAY};
	AIC_MAP_DISPLAY displayAddEventHandler ["KeyDown", "[""KeyDownDisplay"",_this] call AIC_fnc_interactiveIconEventHandler" ];
};