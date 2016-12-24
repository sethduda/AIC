#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Allows player to select a vehicle near a specified group control

	Parameter(s):
	_this select 0: STRING - Group control id
	
	Returns: 
	OBJECT - The selected vehicle (or objNull if not selected)
*/

params ["_groupControlId"];
private ["_group","_commandControls","_inputControl","_output","_selectedVehicle"];
_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_commandControls = AIC_fnc_getCommandControls();
{		
	[_x,false] call AIC_fnc_setMapElementForeground;
	[_x,false] call AIC_fnc_setMapElementEnabled;
} forEach _commandControls;
_inputControl = ["VEHICLE",[_groupControlId]] call AIC_fnc_createInputControl;
[_inputControl,true] call AIC_fnc_setMapElementVisible;
while{true} do {
	_output = AIC_fnc_getInputControlOutput(_inputControl);
	if(!isNil "_output") exitWith {objNull};
	sleep 0.1;
};
_selectedVehicle = AIC_fnc_getInputControlOutput(_inputControl);
[_inputControl] call AIC_fnc_deleteInputControl;
{		
	[_x,true] call AIC_fnc_setMapElementForeground;
	[_x,true] call AIC_fnc_setMapElementEnabled;
} forEach _commandControls;
_selectedVehicle;