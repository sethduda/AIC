/*
	Gets and sets the count of group controls that have been created.
	Data type: NUMBER - count of interactive icons
*/
#define AIC_fnc_getGroupControlCount() missionNamespace getVariable ["AIC_Group_Control_Count",0]
#define AIC_fnc_setGroupControlCount(_controlCount) missionNamespace setVariable ["AIC_Group_Control_Count",(_controlCount)]

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
	Gets and sets if the group control is shown
	Data type: BOOLEAN - is shown
*/
#define AIC_fnc_getGroupControlShown(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Shown",(_controlId)],false]
#define AIC_fnc_setGroupControlShown(_controlId,_isShown) missionNamespace setVariable [format ["AIC_Group_Control_%1_Shown",(_controlId)],_isShown]

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
#define AIC_fnc_getGroupControlColor(_controlId) missionNamespace getVariable [format ["AIC_Group_Control_%1_Color",(_controlId)],AIC_COLOR_RED]
#define AIC_fnc_setGroupControlColor(_controlId,_controlColor) missionNamespace setVariable [format ["AIC_Group_Control_%1_Color",(_controlId)],_controlColor]



/*
	Author: [SA] Duda

	Description:
	Gets a map icon's properties

	Parameter(s):
	_this select 0: STRING - Icon ID
		
	Returns: 
	ARRAY - [
		STRING - Icon image path
		NUMBER - Icon screen width
		NUMBER - Icon screen height
		NUMBER - Icon map width
		NUMBER - Icon map height 
	]
*/
#define AIC_fnc2_getMapIconProperties(iconId) missionNamespace getVariable ["AIC_Map_Icon_" + _iconId,nil]

/*
	Author: [SA] Duda

	Description:
	Gets a map icon's properties

	Parameter(s):
	_this select 0: STRING - Icon ID
		
	Returns: 
	ARRAY - [
		STRING - Icon image path
		NUMBER - Icon screen width
		NUMBER - Icon screen height
		NUMBER - Icon map width
		NUMBER - Icon map height 
	]
*/
#define AIC_inc_getInteractiveIconPosition(interactiveIconId) missionNamespace getVariable ("AIC_Interactive_Icon_" + (interactiveIconId) + "_Position")