#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Execute a command menu action
	
	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 1: NUMBER - Command menu action index (defaults to -1)
	_this select 2: NUMBER - Command menu action path index (defaults to 0)
		
	Returns: 
	Nothing
*/

params ["_groupControlId",["_actionIndex",-1]];

private ["_group","_actions","_handler","_params"];

_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_actions = AIC_fnc_getCommandMenuActions();

if(count _actions > _actionIndex && _actionIndex >= 0) then {
	_handler = (_actions select _actionIndex) select 2;
	_params = (_actions select _actionIndex) select 3;
	_inputType = (_actions select _actionIndex) select 4;
	if(_inputType == "NONE") then {
		[_group,_groupControlId,_params] spawn _handler;
	};
	if(_inputType == "VEHICLE") then {
		_commandControls = AIC_fnc_getCommandControls();
		{		
			[_x,false] call AIC_fnc_setMapElementForeground;
			[_x,false] call AIC_fnc_setMapElementEnabled;
		} forEach _commandControls;
		_inputControl = ["VEHICLE",[_groupControlId]] call AIC_fnc_createInputControl;
		[_inputControl,true] call AIC_fnc_setMapElementVisible;
		while{true} do {
			_output = AIC_fnc_getInputControlOutput(_inputControl);
			if(!isNil "_output") exitWith {};
			sleep 0.1;
		};
		_selectedVehicle = AIC_fnc_getInputControlOutput(_inputControl);
		[_inputControl] call AIC_fnc_deleteInputControl;
		{		
			[_x,true] call AIC_fnc_setMapElementForeground;
			[_x,true] call AIC_fnc_setMapElementEnabled;
		} forEach _commandControls;
		[_group,_groupControlId,_selectedVehicle,_params] spawn _handler;
	};
	if(_inputType == "GROUP") then {
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
			if(!isNil "_output") exitWith {};
			sleep 0.1;
		};
		_selectedGroup = AIC_fnc_getInputControlOutput(_inputControl);
		[_inputControl] call AIC_fnc_deleteInputControl;
		{		
			[_x,true] call AIC_fnc_setMapElementVisible;
			[_x,true] call AIC_fnc_setMapElementForeground;
			[_x,true] call AIC_fnc_setMapElementEnabled;
		} forEach _groupControls;
		[_group,_groupControlId,_selectedGroup,_params] spawn _handler;
	};
	if(_inputType == "POSITION") then {
		_commandControls = AIC_fnc_getCommandControls();
		{		
			[_x,false] call AIC_fnc_setMapElementForeground;
			[_x,false] call AIC_fnc_setMapElementEnabled;
		} forEach _commandControls;
		_inputControl = ["POSITION",[_groupControlId]] call AIC_fnc_createInputControl;
		[_inputControl,true] call AIC_fnc_setMapElementVisible;
		while{true} do {
			_output = AIC_fnc_getInputControlOutput(_inputControl);
			if(!isNil "_output") exitWith {};
			sleep 0.1;
		};
		_selectedPosition = AIC_fnc_getInputControlOutput(_inputControl);
		[_inputControl] call AIC_fnc_deleteInputControl;
		{		
			[_x,true] call AIC_fnc_setMapElementForeground;
			[_x,true] call AIC_fnc_setMapElementEnabled;
		} forEach _commandControls;
		[_group,_groupControlId,_selectedPosition,_params] spawn _handler;
	};
};