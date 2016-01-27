/*
	Author: [SA] Duda

	Description:
	Shows the group color menu
	
	Parameter(s):
	_this select 0: STRING - Group control id
		
	Returns: 
	Nothing
*/


private ["_groupControlId","_redScript","_blueScript","_goBackScript"];

_groupControlId = param [0];

_blueScript = "['"+_groupControlId+"','CHANGE_COMBAT_MODE',['BLUE']] spawn AIC_fnc_groupControlEventHandler";
_greenScript = "['"+_groupControlId+"','CHANGE_COMBAT_MODE',['GREEN']] spawn AIC_fnc_groupControlEventHandler";
_whiteScript = "['"+_groupControlId+"','CHANGE_COMBAT_MODE',['WHITE']] spawn AIC_fnc_groupControlEventHandler";
_yellowScript = "['"+_groupControlId+"','CHANGE_COMBAT_MODE',['YELLOW']] spawn AIC_fnc_groupControlEventHandler";
_redScript = "['"+_groupControlId+"','CHANGE_COMBAT_MODE',['RED']] spawn AIC_fnc_groupControlEventHandler";
_goBackScript = "['"+_groupControlId+"'] spawn AIC_fnc_showGroupCommandMenu";
	
AIC_Group_Color_Menu = [
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
		["Never fire", [0], "", -5, [["expression", '["'+_blueScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Hold fire - defend only", [0], "", -5, [["expression", '["'+_greenScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Hold fire, engage at will", [0], "", -5, [["expression", '["'+_whiteScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Fire at will", [0], "", -5, [["expression", '["'+_yellowScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Fire at will, engage at will", [0], "", -5, [["expression", '["'+_redScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"],
		["Cancel", [0], "", -5, [["expression", '["'+_goBackScript+'"] spawn AIC_fnc_commandMenuAction']], "1", "1"]
		//["Clear Waypoints", [2], "", -5, [["expression", "["" player sidechat 'second' ""] spawn AIC_fnc_commandMenuAction"]], "1", "1"]
		//["Submenu", [3], "#USER:MY_SUBMENU_inCommunication", -5, [["expression", "showCommandingMenu ""#USER:MY_SUBMENU_inCommunication"""]], "1", "1"]
];
	
showCommandingMenu "";
showCommandingMenu "#USER:AIC_Group_Color_Menu";