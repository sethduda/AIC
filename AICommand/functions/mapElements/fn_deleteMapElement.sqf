#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Deletes a map element
	
	Parameter(s):
	_this select 0: STRING - Map element id
		
	Returns: 
	Nothing
	
*/

private ["_elementId"];

_elementId = param [0];

AIC_private_fnc_setMapElementSelfVisible(_elementId,nil);
AIC_private_fnc_setMapElementInheritedVisible(_elementId,nil);
AIC_private_fnc_setMapElementSelfEnabled(_elementId,nil);
AIC_private_fnc_setMapElementInheritedEnabled(_elementId,nil);
AIC_private_fnc_setMapElementSelfForeground(_elementId,nil);
AIC_private_fnc_setMapElementInheritedForeground(_elementId,nil);
AIC_fnc_setMapElementChildren(_elementId,nil);