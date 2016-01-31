#include "..\..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Deletes group vehicle assignment action (do not call directly - use AIC_fnc_deleteMapElement instead)

	Parameter(s):
	_this select 0: STRING - Map Element ID
		
	Returns: 
	Nothing
*/

private ["_mapElementId"];

_mapElementId = param [0];

AIC_fnc_setGroupVehicleAssignmentActionGroupControlId(_mapElementId,nil);
AIC_fnc_setGroupVehicleAssignmentActionGroup(_mapElementId,nil);
AIC_fnc_setGroupVehicleAssignmentActionVehicles(_mapElementId,nil);
AIC_fnc_setGroupVehicleAssignmentActionVehicleIcons(_mapElementId,nil);

_actions = AIC_fnc_getGroupVehicleAssignmentActions();
_actions = _actions - [_mapElementId];
AIC_fnc_setGroupVehicleAssignmentActions(_actions);