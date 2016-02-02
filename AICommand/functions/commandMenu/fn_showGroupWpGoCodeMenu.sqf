#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Shows the group wp go code menu
	
	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 0: NUMBER - Waypoint id
		
	Returns: 
	Nothing
*/


private ["_groupControlId","_alphaScript","_bravoScript","_goBackScript"];

_groupControlId = param [0];
_waypointId = param [1];

_noGoCode = "['"+_groupControlId+"',"+str _waypointId+",'NO_GO_CODE_SELECTED'] spawn AIC_fnc_groupControlWaypointEventHandler";
_alphaScript = "['"+_groupControlId+"',"+str _waypointId+",'ALPHA_GO_CODE_SELECTED'] spawn AIC_fnc_groupControlWaypointEventHandler";
_bravoScript = "['"+_groupControlId+"',"+str _waypointId+",'BRAVO_GO_CODE_SELECTED'] spawn AIC_fnc_groupControlWaypointEventHandler";
_goBackScript = "['"+_groupControlId+"',"+str _waypointId+"] spawn AIC_fnc_showGroupWpCommandMenu";
	
AIC_Group_Waypoint_Go_Code_Menu = [
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
		["No Go Code", [0], "", -5, [["expression", '["'+_noGoCode+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Alpha", [0], "", -5, [["expression", '["'+_alphaScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Bravo", [0], "", -5, [["expression", '["'+_bravoScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Cancel", [0], "", -5, [["expression", '["'+_goBackScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"]
		//["Clear Waypoints", [2], "", -5, [["expression", "["" player sidechat 'second' ""] spawn AIC_fnc_commandMenuAction"]], "1", "1"]
		//["Submenu", [3], "#USER:MY_SUBMENU_inCommunication", -5, [["expression", "showCommandingMenu ""#USER:MY_SUBMENU_inCommunication"""]], "1", "1"]
];
	
showCommandingMenu "";
showCommandingMenu "#USER:AIC_Group_Waypoint_Go_Code_Menu";