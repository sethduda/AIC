#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Adds a child element to a parent map element
	
	Parameter(s):
	_this select 0: STRING - Parent Map Element Id
	_this select 1: STRING - Child Map Element Id
		
	Returns: 
	Nothing
	
*/

private ["_parentElementId","_childElementId","_children"];

_parentElementId = param [0];
_childElementId = param [1];

_children = AIC_fnc_getMapElementChildren(_parentElementId);
_children pushBack _childElementId;
AIC_fnc_setMapElementChildren(_parentElementId,_children);
	
[_childElementId,AIC_fnc_getMapElementVisible(_parentElementId),true] call AIC_fnc_setMapElementVisible;
[_childElementId,AIC_fnc_getMapElementEnabled(_parentElementId),true] call AIC_fnc_setMapElementEnabled;
[_childElementId,AIC_fnc_getMapElementForeground(_parentElementId),true] call AIC_fnc_setMapElementForeground;