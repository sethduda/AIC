#include "groupVehicleAssignmentAction\functions.h"

/*
	Gets and sets the action control type
	Data type: STRING - type of action control
*/
#define AIC_fnc_getActionControlType(_controlId) missionNamespace getVariable [format ["AIC_Action_Control_%1_Type",(_controlId)],""]
#define AIC_fnc_setActionControlType(_controlId,_typeName) missionNamespace setVariable [format ["AIC_Action_Control_%1_Type",(_controlId)],(_typeName)]