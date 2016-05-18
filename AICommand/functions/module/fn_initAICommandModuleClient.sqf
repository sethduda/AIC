#include "..\functions.h"

params [["_module",nil],["_commandControlId",nil]];

// Create mission-defined command controls
if(!isServer && !isNil "_commandControlId") then {
	[_commandControlId] call AIC_fnc_createCommandControl;
};

if(isNil "_module") then {
	if(!isDedicated && hasInterface) then {
		[] spawn {
			while {true} do {
				if(!isNull player && isPlayer player) then {
					if!( player getVariable ["AIC_Command_Control_Added",false] ) then {
						if(side player == west) then {
							["ALL_WEST",true] call AIC_fnc_showCommandControl;
						};
						if(side player == east) then {
							["ALL_EAST",true] call AIC_fnc_showCommandControl;
						};
						if(side player == resistance) then {
							["ALL_GUER",true] call AIC_fnc_showCommandControl;
						};
						if(side player == civilian) then {
							["ALL_CIV",true] call AIC_fnc_showCommandControl;
						};
						player setVariable ["AIC_Command_Control_Added",true];
					};
				};
				sleep 2;
			};
		};
	};
} else {
	{
		if(_x == player) then {
			if(isNil "_commandControlId") then {
				[] spawn {
					while {true} do {
						if(!isNull player && isPlayer player) then {
							if!( player getVariable ["AIC_Command_Control_Added",false] ) then {
								if(side player == west) then {
									["ALL_WEST",true] call AIC_fnc_showCommandControl;
								};
								if(side player == east) then {
									["ALL_EAST",true] call AIC_fnc_showCommandControl;
								};
								if(side player == resistance) then {
									["ALL_GUER",true] call AIC_fnc_showCommandControl;
								};
								if(side player == civilian) then {
									["ALL_CIV",true] call AIC_fnc_showCommandControl;
								};
								player setVariable ["AIC_Command_Control_Added",true];
							};
						};
						sleep 2;
					};
				};
			} else {
				// Use mission-defined command control	
				[_commandControlId,true] call AIC_fnc_showCommandControl;
			};
		};
	} forEach (synchronizedObjects _module);
};