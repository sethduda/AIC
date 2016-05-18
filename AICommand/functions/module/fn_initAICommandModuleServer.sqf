#include "..\functions.h"
params ["_module"];

_commandersModules = allMissionObjects "AdvancedAICommand_Commanders";

if(count _commandersModules > 0) then {
	// At least one commanders module placed
	{
		_commandersModule = _x;
		_containsGroupsModule = false;
		{
			if(typeOf _x == "AdvancedAICommand_Groups") exitWith {
				_containsGroupsModule = true;
			}
		} forEach (synchronizedObjects _commandersModule);

		if(_containsGroupsModule) then {
			// Use mission-defined command control	
			_commandControlId = call {
				private ["_currentIndex"];
				_currentIndex = missionNamespace getVariable ["AIC_Command_Module_Index",0];
				_currentIndex = _currentIndex + 1;
				missionNamespace setVariable ["AIC_Command_Module_Index",_currentIndex];
				"COMMAND_MODULE_" + (str _currentIndex);
			};
			[_commandControlId] call AIC_fnc_createCommandControl;
			{
				if(typeOf _x == "AdvancedAICommand_Groups") then {
					{
						if(typeOf _x != "AdvancedAICommand_Commanders" && !isNull (group _x)) then {
							[_commandControlId,group _x] call AIC_fnc_commandControlAddGroup;
						};
					} forEach ( synchronizedObjects _x );
				};
			} forEach (synchronizedObjects _commandersModule);
			[_commandersModule, _commandControlId] remoteExec ["AIC_fnc_initAICommandModuleClient", 0, true];
		} else {
			// Use pre-defined side-global command controls
			[_commandersModule] remoteExec ["AIC_fnc_initAICommandModuleClient", 0, true];
		};
	} forEach _commandersModules;
} else {
	// No commanders module placed
	[] remoteExec ["AIC_fnc_initAICommandModuleClient", 0, true];
};










