#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Remove interactive icon

	Parameter(s):
	_this select 0: STRING - Interactive Icon ID
		
	Returns: 
	Nothing
*/

private ["_interactiveIconId","_interactiveIcons"];

_interactiveIconId = param [0];

[_interactiveIconId] call AIC_fnc_deleteMapElement;

AIC_fnc_setInteractiveIconIconSet(_interactiveIconId, nil);
AIC_fnc_setInteractiveIconPosition(_interactiveIconId, nil);
AIC_fnc_setInteractiveIconState(_interactiveIconId, nil);
AIC_fnc_setInteractiveIconDimensions(_interactiveIconId, nil);
AIC_fnc_setInteractiveIconEventHandlerScript(_interactiveIconId, nil);
AIC_fnc_setInteractiveIconEventHandlerScriptParams(_interactiveIconId, nil);

_interactiveIcons = AIC_fnc_getInteractiveIcons();
_interactiveIcons = _interactiveIcons - [_interactiveIconId];
AIC_fnc_setInteractiveIcons(_interactiveIcons);