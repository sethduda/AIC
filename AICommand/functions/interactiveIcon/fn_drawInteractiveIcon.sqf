#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified interactive icon on the map

	Parameter(s):
	_this select 0: NUMBER - Interactive Icon ID
		
	Returns: 
	Nothing
*/

private ["_interactiveIconId","_shown","_activeIconIds","_position","_state"];
_interactiveIconId = param [0];

_shown = AIC_fnc_getInteractiveIconShown(_interactiveIconId);
if(!_shown) exitWith {};

_state = AIC_fnc_getInteractiveIconState(_interactiveIconId);

if(_state == "UNSELECTED") then {
	_activeIconIds = (AIC_fnc_getInteractiveIconIconSet(_interactiveIconId)) select 0;
} else {
	if(_state == "SELECTED") then {
		_activeIconIds = (AIC_fnc_getInteractiveIconIconSet(_interactiveIconId)) select 1;
	};
	if(_state == "MOUSEOVER") then {
		_activeIconIds = (AIC_fnc_getInteractiveIconIconSet(_interactiveIconId)) select 2;
	};
	if(_state == "PICKEDUP") then {
		_activeIconIds = (AIC_fnc_getInteractiveIconIconSet(_interactiveIconId)) select 3;
	};
};

_position = AIC_fnc_getInteractiveIconPosition(_interactiveIconId);

{
	[_x, _position] call AIC_fnc_drawMapIcon;
} forEach _activeIconIds;