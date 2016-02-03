#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates command control

	Parameter(s):
	_this select 0: STRING - unique command control id

	Returns:
	Nothing
*/

private ["_commandId"];

_commandId = param [0];

if(isServer) then {

	private ["_commandControls"];

	_commandControls = AIC_fnc_getCommandControls();
	_commandControls pushBack _commandId;
	AIC_fnc_setCommandControls(_commandControls);

};

if(hasInterface) then {

	private ["_containerId"];

	// Create map element for command control
	
	[false,true,true,_commandId] call AIC_fnc_createMapElement;
	
	// Create map element to contain all of the group controls within the command control
	// This is used so that we can control visibility/enablement/foreground settings for all
	// group controls under a command control at once. (e.g. when using the assign vehicle 
	// action control, all group controls are set to the background and disabled.
	
	_containerId = AIC_fnc_getCommandControlGroupControlContainer(_commandId);
	if(isNil "_containerId") then {
		_containerId = [] call AIC_fnc_createMapElement;
		[_commandId,_containerId] call AIC_fnc_addMapElementChild;
		AIC_fnc_setCommandControlGroupControlContainer(_commandId,_containerId);
	};
	
};

