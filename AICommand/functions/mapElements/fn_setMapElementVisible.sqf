#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Sets if the map element is visible and updates all child elements
	
	Parameter(s):
	_this select 0: STRING - Map Element Id
	_this select 1: BOOLEAN - Is Visible
	_this select 1: BOOLEAN - Is Inherited
		
	Returns: 
	Nothing
*/

private ["_mapElementId","_isVisible","_isInherited"];

_mapElementId = param [0];
_isVisible = param [1,true];
_isInherited = param [2,false];

if(_isInherited) then {
	AIC_private_fnc_setMapElementInheritedVisible(_mapElementId,_isVisible);
} else {
	AIC_private_fnc_setMapElementSelfVisible(_mapElementId,_isVisible);
};

{
	[_x, AIC_fnc_getMapElementVisible(_mapElementId), true] call AIC_fnc_setMapElementVisible;
} forEach (AIC_fnc_getMapElementChildren(_mapElementId));