/*
	Author: [SA] Duda

	Description:
	Shows the group command menu
	
	Parameter(s):
	_this select 0: STRING - Group control id
		
	Returns: 
	Nothing
*/

private ["_groupControlId","_addWaypointsScript","_addWaypointsScript","_clearAllWaypointsScript","_setGoCodeScript"];

_groupControlId = param [0];

_addWaypointsScript = "['"+_groupControlId+"','ADD_WAYPOINTS_SELECTED'] spawn AIC_fnc_groupControlEventHandler";
_clearAllWaypointsScript = "['"+_groupControlId+"','CLEAR_WAYPOINTS_SELECTED','Confirm Cancel All'] spawn AIC_fnc_showGroupConfirmMenu";
_setGoCodeScript = "['"+_groupControlId+"'] spawn AIC_fnc_showGroupGoCodeMenu";
_remoteControlScript = "['"+_groupControlId+"','REMOTE_CONTROL_SELECTED'] spawn AIC_fnc_groupControlEventHandler";
_switchPlayerScript = "['"+_groupControlId+"','SWITCH_PLAYER_SELECTED'] spawn AIC_fnc_groupControlEventHandler";
_setColorScript = "['"+_groupControlId+"'] spawn AIC_fnc_showGroupColorMenu";
_setBehaviourScript = "['"+_groupControlId+"'] spawn AIC_fnc_showGroupBehaviourMenu";
_setCombatModeScript = "['"+_groupControlId+"'] spawn AIC_fnc_showGroupCombatModeMenu";
_assignVehicleScript = "['"+_groupControlId+"','ASSIGN_VEHICLE_ACTION_SELECTED'] spawn AIC_fnc_groupControlEventHandler";
_unassignVehicleScript = "['"+_groupControlId+"','UNASSIGN_VEHICLE_ACTION_SELECTED'] spawn AIC_fnc_groupControlEventHandler";


AIC_Group_Control_Menu = [
		// First array: "User menu" This will be displayed under the menu, bool value: has Input Focus or not.
		// Note that as to version Arma2 1.05, if the bool value set to false, Custom Icons will not be displayed.
		["Group Command",false],
		// Syntax and semantics for following array elements:
		// ["Title_in_menu", [assigned_key], "Submenu_name", CMD, [["expression",script-string]], "isVisible", "isActive" <, optional icon path> ]
		// Title_in_menu: string that will be displayed for the player
		// Assigned_key: 0 - no key, 1 - escape key, 2 - key-1, 3 - key-2, ... , 10 - key-9, 11 - key-0, 12 and up... the whole keyboard
		// Submenu_name: User menu name string (eg "#USER:MY_SUBMENU_NAME" ), "" for script to execute.
		// CMD: (for main menu:) CMD_SEPARATOR -1; CMD_NOTHING -2; CMD_HIDE_MENU -3; CMD_BACK -4; (for custom menu:) CMD_EXECUTE -5
		// script-string: command to be executed on activation. (no arguments passed)
		// isVisible - Boolean 1 or 0 for yes or no, - or optional argument string, eg: "CursorOnGround"
		// isActive - Boolean 1 or 0 for yes or no - if item is not active, it appears gray.
		// optional icon path: The path to the texture of the cursor, that should be used on this menuitem.
		["Add Waypoints", [0], "", -5, [["expression", '["'+_addWaypointsScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Set Group Combat Mode", [0], "", -5, [["expression", '["'+_setCombatModeScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Set Group Behaviour", [0], "", -5, [["expression", '["'+_setBehaviourScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Set Group Color", [0], "", -5, [["expression", '["'+_setColorScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Remote Control", [0], "", -5, [["expression", '["'+_remoteControlScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Assign Vehicle", [0], "", -5, [["expression", '["'+_assignVehicleScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Unassign Vehicle", [0], "", -5, [["expression", '["'+_unassignVehicleScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Clear All Waypoints", [0], "", -5, [["expression", '["'+_clearAllWaypointsScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"]
		//["Clear Waypoints", [2], "", -5, [["expression", "["" player sidechat 'second' ""] spawn AIC_fnc_commandMenuAction"]], "1", "1"]
		//["Submenu", [3], "#USER:MY_SUBMENU_inCommunication", -5, [["expression", "showCommandingMenu ""#USER:MY_SUBMENU_inCommunication"""]], "1", "1"]
];
	
showCommandingMenu "#USER:AIC_Group_Control_Menu";