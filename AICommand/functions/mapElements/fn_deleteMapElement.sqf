#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Deletes a map element and all its children.
	
	Parameter(s):
	_this select 0: STRING - Map element id
		
	Returns: 
	Nothing
	
*/

private ["_elementId","_deleteScript"];

_elementId = param [0];

_deleteScript = AIC_fnc_getMapElementDeleteFunction(_elementId);
[_elementId] call (missionNamespace getVariable [_deleteScript,{}]);

_children = AIC_fnc_getMapElementChildren(_elementId);
{
	[_x] call AIC_fnc_deleteMapElement;
} forEach _children;

AIC_private_fnc_setMapElementSelfVisible(_elementId,nil);
AIC_private_fnc_setMapElementInheritedVisible(_elementId,nil);
AIC_private_fnc_setMapElementSelfEnabled(_elementId,nil);
AIC_private_fnc_setMapElementInheritedEnabled(_elementId,nil);
AIC_private_fnc_setMapElementSelfForeground(_elementId,nil);
AIC_private_fnc_setMapElementInheritedForeground(_elementId,nil);
AIC_fnc_setMapElementChildren(_elementId,nil);
AIC_fnc_setMapElementDeleteFunction(_elementId,nil);