#include "functions.h"

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

_interactiveIcons = AIC_fnc_getInteractiveIcons();
_interactiveIcons = _interactiveIcons - [_interactiveIconId];
AIC_fnc_setInteractiveIcons(_interactiveIcons);