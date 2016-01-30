/*
	Gets and sets the count of action controls that have been created.
	Data type: NUMBER - count of action controls
*/
#define AIC_fnc_getActionControlCount() missionNamespace getVariable ["AIC_Action_Control_Count",0]
#define AIC_fnc_setActionControlCount(_controlCount) missionNamespace setVariable ["AIC_Action_Control_Count",(_controlCount)]

/*
	Gets and sets the action control type
	Data type: STRING - type of action control
*/
#define AIC_fnc_getActionControlType(_controlId) missionNamespace getVariable [format ["AIC_Action_Control_%1_Type",(_controlId)],""]
#define AIC_fnc_setActionControlType(_controlId,_type) missionNamespace setVariable [format ["AIC_Action_Control_%1_Type",(_controlId)],(_type)]

/*
	Gets and sets the action control parameters
	Data type: ARRAY - action control parameters
*/
#define AIC_fnc_getActionControlParameters(_controlId) missionNamespace getVariable [format ["AIC_Action_Control_%1_Params",(_controlId)],[]]
#define AIC_fnc_setActionControlParameters(_controlId,_actionParams) missionNamespace setVariable [format ["AIC_Action_Control_%1_Params",(_controlId)],(_actionParams)]

/*
	Gets and sets the action control data
	Data type: ARRAY - action control data
*/
#define AIC_fnc_getActionControlData(_controlId) missionNamespace getVariable [format ["AIC_Action_Control_%1_Data",(_controlId)],[]]
#define AIC_fnc_setActionControlData(_controlId,_actionData) missionNamespace setVariable [format ["AIC_Action_Control_%1_Data",(_controlId)],(_actionData)]

/*
	Gets and sets if the action control is shown
	Data type: BOOLEAN - is shown
*/
#define AIC_fnc_getActionControlShown(_controlId) missionNamespace getVariable [format ["AIC_Action_Control_%1_Shown",(_controlId)],false]
#define AIC_fnc_setActionControlShown(_controlId,_isShown) missionNamespace setVariable [format ["AIC_Action_Control_%1_Shown",(_controlId)],_isShown]

/*
	Gets and sets all action controls
	Data type: ARRAY - [ STRING - Action Control ID, .... ]
*/
#define AIC_fnc_getActionControls() missionNamespace getVariable ["AIC_Action_Controls",[]]
#define AIC_fnc_setActionControls(_actionControls) missionNamespace setVariable ["AIC_Action_Controls",_actionControls]