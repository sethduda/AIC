/*
	Gets and sets an array of command controls (network global)
	Data type: ARRAY - [ STRING - Id of command control, ... ]
*/
#define AIC_fnc_getCommandControls() missionNamespace getVariable ["AIC_Command_Controls",[]]
#define AIC_fnc_setCommandControls(_commandControls) missionNamespace setVariable ["AIC_Command_Controls",(_commandControls),true]

/*
	Gets and sets the current mouse world position on the map (client local)
	Data type: POSITION - last known mouse position on the map
*/
#define AIC_fnc_getMouseMapPosition() missionNamespace getVariable ["AIC_Current_Mouse_Position",[0,0]]
#define AIC_fnc_setMouseMapPosition(_mousePosition) missionNamespace setVariable ["AIC_Current_Mouse_Position",(_mousePosition)]

/*
	Gets and sets the groups associated with a command control (network global)
	Data type: ARRAY - [
		NUMBER - Revision
		ARRAY - [ STRING - Command Control Id, ... ]
	]
*/
#define AIC_fnc_getCommandControlGroups(_commandControlId) ((missionNamespace getVariable [format ["AIC_Command_Control_%1_Groups",_commandControlId],[0,[]]]) select 1)
#define AIC_fnc_setCommandControlGroups(_commandControlId,_groupsArray) missionNamespace setVariable [format ["AIC_Command_Control_%1_Groups",_commandControlId],[AIC_fnc_getCommandControlGroupsRevision(_commandControlId)+1,_groupsArray],true]
#define AIC_fnc_getCommandControlGroupsRevision(_commandControlId) ((missionNamespace getVariable [format ["AIC_Command_Control_%1_Groups",_commandControlId],[0,[]]]) select 0)

/*
	Gets and sets group controls associated with a control id (client local)
	Data type: ARRAY - [ STRING - group control id, ... ]
*/
#define AIC_fnc_getCommandControlGroupsControls(_controlId) missionNamespace getVariable [format ["AIC_Command_Control_%1_Group_Controls",(_controlId)],[]]
#define AIC_fnc_setCommandControlGroupsControls(_controlId,_groupControls) missionNamespace setVariable [format ["AIC_Command_Control_%1_Group_Controls",(_controlId)],_groupControls]

/*
	Gets and sets group controls revision (client local)
	Data type: NUMBER - revision
*/
#define AIC_fnc_getCommandControlGroupsControlsRevision(_controlId) missionNamespace getVariable [format ["AIC_Command_Control_%1_Group_Controls_Revision",(_controlId)],0]
#define AIC_fnc_setCommandControlGroupsControlsRevision(_controlId,_groupControlsRevision) missionNamespace setVariable [format ["AIC_Command_Control_%1_Group_Controls_Revision",(_controlId)],_groupControlsRevision]

/*
	Gets and sets a command control's group control container element 
	Data type: STRING - map element id
*/
#define AIC_fnc_getCommandControlGroupControlContainer(_controlId) missionNamespace getVariable [format ["AIC_Command_Control_%1_Group_Control_Container",(_controlId)],nil]
#define AIC_fnc_setCommandControlGroupControlContainer(_controlId,_groupControlContainer) missionNamespace setVariable [format ["AIC_Command_Control_%1_Group_Control_Container",(_controlId)],_groupControlContainer]
