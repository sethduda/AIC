/*
	Gets and sets the input control type
	Data type: STRING - type of input control
*/
#define AIC_fnc_getInputControlType(_controlId) missionNamespace getVariable [format ["AIC_Input_Control_%1_Type",(_controlId)],""]
#define AIC_fnc_setInputControlType(_controlId,_type) missionNamespace setVariable [format ["AIC_Input_Control_%1_Type",(_controlId)],(_type)]

/*
	Gets and sets the input control output
	Data type: STRING - type of input control
*/
#define AIC_fnc_getInputControlOutput(_controlId) missionNamespace getVariable [format ["AIC_Input_Control_%1_Output",(_controlId)],nil]
#define AIC_fnc_setInputControlOutput(_controlId,_output) missionNamespace setVariable [format ["AIC_Input_Control_%1_Output",(_controlId)],(_output)]

/*
	Gets and sets the input control parameters
	Data type: ARRAY - input control parameters
*/
#define AIC_fnc_getInputControlParameters(_controlId) missionNamespace getVariable [format ["AIC_Input_Control_%1_Params",(_controlId)],[]]
#define AIC_fnc_setInputControlParameters(_controlId,_actionParams) missionNamespace setVariable [format ["AIC_Input_Control_%1_Params",(_controlId)],(_actionParams)]

/*
	Gets and sets the input control data
	Data type: ARRAY - input control data
*/
#define AIC_fnc_getInputControlData(_controlId) missionNamespace getVariable [format ["AIC_Input_Control_%1_Data",(_controlId)],[]]
#define AIC_fnc_setInputControlData(_controlId,_inputData) missionNamespace setVariable [format ["AIC_Input_Control_%1_Data",(_controlId)],(_inputData)]

/*
	Gets and sets all input controls
	Data type: ARRAY - [ STRING - input Control ID, .... ]
*/
#define AIC_fnc_getInputControls() missionNamespace getVariable ["AIC_Input_Controls",[]]
#define AIC_fnc_setInputControls(_actionControls) missionNamespace setVariable ["AIC_Input_Controls",_actionControls]