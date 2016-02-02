#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Sets if the map element is foreground and updates all child elements
	
	Parameter(s):
	_this select 0: STRING - Map Element Id
	_this select 1: BOOLEAN - Is Foreground
	_this select 1: BOOLEAN - Is Inherited
		
	Returns: 
	Nothing
*/

private ["_mapElementId","_isForeground","_isInherited"];

_mapElementId = param [0];
_isForeground = param [1,true];
_isInherited = param [2,false];

if(_isInherited) then {
	AIC_private_fnc_setMapElementInheritedForeground(_mapElementId,_isForeground);
} else {
	AIC_private_fnc_setMapElementSelfForeground(_mapElementId,_isForeground);
};

{
	[_x, AIC_fnc_getMapElementForeground(_mapElementId), true] call AIC_fnc_setMapElementForeground;
} forEach (AIC_fnc_getMapElementChildren(_mapElementId));