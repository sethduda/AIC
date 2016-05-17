#include "..\functions.h"

params ["_module"];
private ["_commandControlId"];

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
} forEach (synchronizedObjects _module);

[_module, _commandControlId] remoteExec ["AIC_fnc_initAICommandModuleClient", 0, true];