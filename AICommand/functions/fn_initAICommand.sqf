#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Starts Advanced AI Command. Must be executed on all clients & the server. Will be executed automatically
	if running Advanced AI Command as an addon/mod. If running Advanced AI Command as a script embedded 
	inside a mission, this should be executed from the init.sqf file (e.g. call AIC_fnc_initAICommand; )

	Parameter(s):
	_this select 0: BOOLEAN - Auto-configure commanders & the groups they can command (optional, defaults to true)
	
		Note: If this is set to false, it's the responsibility of the mission creator using 
		scripts to define commanders and their associated groups.
		
*/

// Prevent init from running twice
if(!isNil "AIC_INIT") exitWith {}; 
AIC_INIT = true;

params [["_autoConfigureCommanders",true]];

// Start up Advanced AI Command scripts
[] call AIC_fnc_mapIconDefinitions;
[] call AIC_fnc_commandControlManager;
[] call AIC_fnc_groupControlManager;
[] call AIC_fnc_interactiveIconManager;
[] call AIC_fnc_inputControlManager;
[] call AIC_fnc_commandMenuManager;
[] call AIC_fnc_commandMenuActionsInit;
[] call AIC_fnc_eventHandlerManager;

AIC_INIT_STARTUP_SCRIPTS_EXECUTED = true;

if(!_autoConfigureCommanders || !isServer) exitWith {};

// Auto-configure commanders and groups under command

private["_commandersModules","_groupsModules","_configurationMode"];

_commandersModules = allMissionObjects "AdvancedAICommand_Commanders";
_groupsModules = allMissionObjects "AdvancedAICommand_Groups";

_configurationMode = "ALL_COMMANDERS_ALL_GROUPS";
if(count _commandersModules > 0) then {
	if(count _groupsModules > 0) then {
		// Specific commanders assigned to specific groups
		_configurationMode = "SPECIFIED_COMMANDERS_SPECIFIED_GROUPS"
	} else {
		// Specific commanders assigned to all local-side groups
		_configurationMode = "SPECIFIED_COMMANDERS_ALL_GROUPS"
	};
};

if(_configurationMode == "SPECIFIED_COMMANDERS_SPECIFIED_GROUPS") then {
	_commandControlIndex = 0;
	{
		_commandControlId = "COMMAND_MODULE_" + (str _commandControlIndex);
		[_commandControlId] call AIC_fnc_createCommandControl;
		{
			if(typeOf _x == "AdvancedAICommand_Groups") then {
				{
					if(typeOf _x != "AdvancedAICommand_Commanders" && !isNull (group _x)) then {
						[_commandControlId,group _x] call AIC_fnc_commandControlAddGroup;
					};
				} forEach ( synchronizedObjects _x );
			};
		} forEach (synchronizedObjects _x);
		[_configurationMode, [_x, _commandControlId]] remoteExec ["AIC_fnc_initAICommandClient", 0, true];
		_commandControlIndex = _commandControlIndex + 1;
	} forEach _commandersModules;
};

if(_configurationMode == "SPECIFIED_COMMANDERS_ALL_GROUPS") then {
	{
		[_configurationMode, [_x]] remoteExec ["AIC_fnc_initAICommandClient", 0, true];
	} forEach _commandersModules;
};

if(_configurationMode == "ALL_COMMANDERS_ALL_GROUPS") then {
	[_configurationMode] remoteExec ["AIC_fnc_initAICommandClient", 0, true];
};









