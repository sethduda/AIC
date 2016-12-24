#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Allows player to select a position near a specified group control

	Parameter(s):
	_this select 0: STRING - Group control id
	
	Returns: 
	ARRAY - The selected position, or [] of no position selected
*/

params ["_groupControlId"];
private ["_group","_commandControls","_inputControl","_output","_selectedPosition"];
_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_commandControls = AIC_fnc_getCommandControls();
{		
	[_x,false] call AIC_fnc_setMapElementForeground;
	[_x,false] call AIC_fnc_setMapElementEnabled;
} forEach _commandControls;
_inputControl = ["POSITION",[_groupControlId]] call AIC_fnc_createInputControl;
[_inputControl,true] call AIC_fnc_setMapElementVisible;
while{true} do {
	_output = AIC_fnc_getInputControlOutput(_inputControl);
	if(!isNil "_output") exitWith {[]};
	sleep 0.1;
};
_selectedPosition = AIC_fnc_getInputControlOutput(_inputControl);
[_inputControl] call AIC_fnc_deleteInputControl;
{		
	[_x,true] call AIC_fnc_setMapElementForeground;
	[_x,true] call AIC_fnc_setMapElementEnabled;
} forEach _commandControls;
_selectedPosition;