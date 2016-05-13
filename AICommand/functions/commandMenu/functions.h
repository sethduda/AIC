/*
	Get and sets command actions
	Data Type: ARRAY
*/
#define AIC_fnc_getCommandMenuActions() missionNamespace getVariable ["AIC_Command_Actions",[]]
#define AIC_fnc_setCommandMenuActions(_actions) missionNamespace setVariable ["AIC_Command_Actions",(_actions)]