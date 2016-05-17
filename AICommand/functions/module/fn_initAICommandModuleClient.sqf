#include "..\functions.h"

params ["_module","_commandControlId"];

if(!isServer) then {
	[_commandControlId] call AIC_fnc_createCommandControl;
};

{
	if(_x == player) then {
		[_commandControlId,true] call AIC_fnc_showCommandControl;
	};
} forEach (synchronizedObjects _module);