#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Adds an action to the command menu
	
	Parameter(s):
	_this select 0: STRING - Command menu type identifier ("GROUP", "WAYPOINT")
	_this select 1: STRING - Label that will appear in the command menu
	_this select 2: ARRAY - Path (default []). Defines command menu path to action (e.g ["Set Behaviour","Test 1"] will result in Set Behaviour > Test 1 > [Label]
	_this select 3: SCRIPT - Action handler (Defaults to {})
	_this select 4: ANY - Action handler params (Defaults to [])
	_this select 5: SCRIPT - Script to determine if action is enabled (Defaults to {true})
		
	Returns: 
	Nothing
*/
params ["_type","_label",["_path",[]],["_actionHandlerScript",{}],["_actionHandlerParams",[]],["_isEnabledScript",{true}]];

private ["_actions"];

_actions = AIC_fnc_getCommandMenuActions();
_actions pushBack [_type,_label,_path,_actionHandlerScript,_actionHandlerParams,_isEnabledScript];
AIC_fnc_setCommandMenuActions(_actions);