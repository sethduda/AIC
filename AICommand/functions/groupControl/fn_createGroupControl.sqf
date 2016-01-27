#include "functions.h"
#include "..\interactiveIcon\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates a group control

	Parameter(s):
	_this select 0: GROUP - Group

	Returns: 
	STRING - Group Control ID
*/

private ["_group"];

_group = param [0];

private ["_groupControlCount","_groupControlId","_groupControls"];

_groupControlCount = AIC_fnc_getGroupControlCount();
_groupControlId = str _groupControlCount;
AIC_fnc_setGroupControlCount(_groupControlCount + 1);

private ["_interactiveGroupIcon","_iconSet","_eventHandlerScript","_color"];

_color = AIC_fnc_getGroupControlColor(_groupControlId); 
_iconSet = [_group,_color] call AIC_fnc_getGroupControlIconSet;
_interactiveGroupIcon = [_iconSet, position (leader _group)] call AIC_fnc_createInteractiveIcon;

_eventHandlerScript = {
	private ["_event","_groupControlId","_params"];
	_event = param [1];
	_params = param [2];
	_groupControlId = param [3];
	[_groupControlId, _event, _params] spawn AIC_fnc_groupControlEventHandler;
};

AIC_fnc_setInteractiveIconEventHandlerScript(_interactiveGroupIcon, _eventHandlerScript);
AIC_fnc_setInteractiveIconEventHandlerScriptParams(_interactiveGroupIcon, _groupControlId);

AIC_fnc_setGroupControlGroup(_groupControlId,_group);
AIC_fnc_setGroupControlInteractiveIcon(_groupControlId,_interactiveGroupIcon);

_groupControls = AIC_fnc_getGroupControls();
_groupControls pushBack _groupControlId;
AIC_fnc_setGroupControls(_groupControls);

_groupControlId;