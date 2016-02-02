#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Sets if the map element is enabled and updates all child elements
	
	Parameter(s):
	_this select 0: STRING - Map Element Id
	_this select 1: BOOLEAN - Is Enabled
	_this select 1: BOOLEAN - Is Inherited
		
	Returns: 
	Nothing
*/

private ["_mapElementId","_isEnabled","_isInherited"];

_mapElementId = param [0];
_isEnabled = param [1,true];
_isInherited = param [2,false];

if(_isInherited) then {
	AIC_private_fnc_setMapElementInheritedEnabled(_mapElementId,_isEnabled);
} else {
	AIC_private_fnc_setMapElementSelfEnabled(_mapElementId,_isEnabled);
};

{
	[_x, AIC_fnc_getMapElementEnabled(_mapElementId), true] call AIC_fnc_setMapElementEnabled;
} forEach (AIC_fnc_getMapElementChildren(_mapElementId));