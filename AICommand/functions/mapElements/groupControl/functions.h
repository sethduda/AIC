/*
	Gets and sets the group associated to the group control
	Data type: GROUP
*/
#define AIC_fnc_getGroupControlGroup(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Group",(_controlId)],nil]
#define AIC_fnc_setGroupControlGroup(_controlId,_controlGroup) missionNamespace setVariable [format ["AIC_Group_Control_%1_Group",(_controlId)],_controlGroup]

/*
	Gets and sets the interactive icon associated to the group control
	Data type: STRING - interactive icon id
*/
#define AIC_fnc_getGroupControlInteractiveIcon(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Icon",(_controlId)],nil]
#define AIC_fnc_setGroupControlInteractiveIcon(_controlId,_interactiveGroupIcon) missionNamespace setVariable [format ["AIC_Group_Control_%1_Icon",(_controlId)],_interactiveGroupIcon]

/*
	Gets and sets group control wp interactive icons
	Data type: ARRAY - [
		NUMBER - Waypoint index
		STRING - Interactive icon id
		BOOLEAN - Disabled
	]
*/
#define AIC_fnc_getGroupControlWaypointIcons(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Wp_Icons",(_controlId)],[]]
#define AIC_fnc_setGroupControlWaypointIcons(_controlId,_wpIcons) missionNamespace setVariable [format ["AIC_Group_Control_%1_Wp_Icons",(_controlId)],_wpIcons]

/*
	Gets and sets if the user is currently adding waypoints to the group control
	Data type: BOOLEAN - is adding waypoints
*/
#define AIC_fnc_getGroupControlAddingWaypoints(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Adding_Waypoints",(_controlId)],false]
#define AIC_fnc_setGroupControlAddingWaypoints(_controlId,_isAdding) missionNamespace setVariable [format ["AIC_Group_Control_%1_Adding_Waypoints",(_controlId)],_isAdding]

/*
	Gets and sets a list of all group controls
	Data type: ARRAY - [
		STRING - Group Control Id, ...
	]
*/
#define AIC_fnc_getGroupControls() missionNamespace getVariable ["AIC_Group_Controls",[]]
#define AIC_fnc_setGroupControls(_groupControls) missionNamespace setVariable ["AIC_Group_Controls",_groupControls]

/*
	Gets and sets waypoints revision for a group command
	Data type: STRING - interactive icon id
*/
#define AIC_fnc_getGroupControlWaypointRevision(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Wp_Revision",(_controlId)],0]
#define AIC_fnc_setGroupControlWaypointRevision(_controlId,_wpRevision) missionNamespace setVariable [format ["AIC_Group_Control_%1_Wp_Revision",(_controlId)],_wpRevision]

/*
	Gets and sets group control color (might be different than group color)
	Data type: ARRAY - [ STRING - Color Name, RGB - Color array ]
*/
#define AIC_fnc_getGroupControlColor(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Color",(_controlId)],AIC_COLOR_BLUE]
#define AIC_fnc_setGroupControlColor(_controlId,_controlColor) missionNamespace setVariable [format ["AIC_Group_Control_%1_Color",(_controlId)],_controlColor]

/*
	Gets and sets group control group type
	Data type: ARRAY - [ STRING - Color Name, RGB - Color array ]
*/
#define AIC_fnc_getGroupControlType(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Group_Type",(_controlId)],""]
#define AIC_fnc_setGroupControlType(_controlId,_groupType) missionNamespace setVariable [format ["AIC_Group_Control_%1_Group_Type",(_controlId)],_groupType]

/*
	Gets and sets group level actions
	Data type: ARRAY - [
		STRING - Action id, ...
	]
*/
#define AIC_fnc_getGroupControlActions(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Actions",(_controlId)],[]]
#define AIC_fnc_setGroupControlActions(_controlId,_controlActions) missionNamespace setVariable [format ["AIC_Group_Control_%1_Actions",(_controlId)],(_controlActions)]

/*
	Gets and sets waypoints revision for a group command
	Data type: STRING - interactive icon id
*/
#define AIC_fnc_getGroupControlActionsRevision(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Actions_Revision",(_controlId)],0]
#define AIC_fnc_setGroupControlActionsRevision(_controlId,_actionRevision) missionNamespace setVariable [format ["AIC_Group_Control_%1_Actions_Revision",(_controlId)],_actionRevision]

