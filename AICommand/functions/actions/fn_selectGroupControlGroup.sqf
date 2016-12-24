#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Allows player to select a group near a specified group control

	Parameter(s):
	_this select 0: STRING - Group control id
	
	Returns: 
	OBJECT - The selected group (or grpNull if not selected)
*/

params ["_groupControlId"];
private ["_group","_groupControls","_inputControl","_output","_selectedVehicle"];
_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_groupControls = AIC_fnc_getGroupControls();
{		
	[_x,false] call AIC_fnc_setMapElementVisible;
	[_x,false] call AIC_fnc_setMapElementForeground;
	[_x,false] call AIC_fnc_setMapElementEnabled;
} forEach _groupControls;
[_groupControlId,true] call AIC_fnc_setMapElementVisible;
[_groupControlId,true] call AIC_fnc_setMapElementForeground;
[_groupControlId,false] call AIC_fnc_setMapElementEnabled;
_inputControl = ["GROUP",[_groupControlId]] call AIC_fnc_createInputControl;
[_inputControl,true] call AIC_fnc_setMapElementVisible;
while{true} do {
	_output = AIC_fnc_getInputControlOutput(_inputControl);
	if(!isNil "_output") exitWith {grpNull};
	sleep 0.1;
};
_selectedGroup = AIC_fnc_getInputControlOutput(_inputControl);
[_inputControl] call AIC_fnc_deleteInputControl;
{		
	[_x,true] call AIC_fnc_setMapElementVisible;
	[_x,true] call AIC_fnc_setMapElementForeground;
	[_x,true] call AIC_fnc_setMapElementEnabled;
} forEach _groupControls;
_selectedGroup;