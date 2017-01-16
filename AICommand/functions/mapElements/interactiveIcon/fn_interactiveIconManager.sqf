#include "..\..\functions.h"

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

["MAP_CONTROL","MouseButtonClick", "[""MouseButtonClick"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseMoving", "[""MouseMoving"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseButtonDown", "[""MouseButtonDown"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseButtonUp", "[""MouseButtonUp"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseHolding", "[""MouseHolding"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_DISPLAY","KeyDown", "[""KeyDownDisplay"",_this] call AIC_fnc_interactiveIconEventHandler"] spawn AIC_fnc_addManagedEventHandler;