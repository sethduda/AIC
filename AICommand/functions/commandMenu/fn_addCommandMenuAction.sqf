#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Adds an action to the command menu
	
	Parameter(s):
	_this select 0: STRING - Label that will appear in the command menu
	_this select 1: ARRAY - Path (default []). Defines command menu path to action (e.g ["Set Behaviour","Test 1"] will result in Set Behaviour > Test 1 > [Label]
	_this select 2: SCRIPT - Action handler (Defaults to {})
	_this select 3: ANY - Action handler params (Defaults to [])
	_this select 4: STRING - Input selection type (Defaults to "NONE)
	_this select 5: SCRIPT - Script to determine if action is enabled (Defaults to {true})
		
	Returns: 
	Nothing
*/
params ["_label",["_path",[]],["_actionHandlerScript",{}],["_actionHandlerParams",[]],["_inputSelection","NONE"],["_isEnabledScript",{true}]];

private ["_actions"];

_actions = AIC_fnc_getCommandMenuActions();
_actions pushBack [_label,_path,_actionHandlerScript,_actionHandlerParams,_inputSelection,_isEnabledScript];
AIC_fnc_setCommandMenuActions(_actions);