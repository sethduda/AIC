#include "functions.h"

/*
	Author: [SA] Duda

	Description:
	Deletes an action control (do not call directly - use AIC_fnc_deleteMapElement instead)

	Parameter(s):
	_this select 0: STRING - Action Control ID
		
	Returns: 
	Nothing
*/

private ["_actionControlId"];

_actionControlId = param [0];

AIC_fnc_setActionControlType(_actionControlId, nil);
AIC_fnc_setActionControlParameters(_actionControlId, nil);
AIC_fnc_setActionControlData(_actionControlId, nil);

_actionControls = AIC_fnc_getActionControls();
_actionControls = _actionControls - [_actionControlId];
AIC_fnc_setActionControls(_actionControls);