//This script will create a custom menu, and display it once.

/*MY_SUBMENU_inCommunication =
[
	["User submenu",true],
	["Option-1", [2], "", -5, [["expression", "player sidechat ""-1"" "]], "0", "0", "\ca\ui\data\cursor_support_ca"],
	["Option 0", [3], "", -5, [["expression", "player sidechat "" 0"" "]], "1", "0", "\ca\ui\data\cursor_support_ca"],
	["Option 1", [4], "", -5, [["expression", "player sidechat "" 1"" "]], "1", "CursorOnGround", "\ca\ui\data\cursor_support_ca"]
];*/

CR_Command_Radio_Menu = 
[
	// First array: "User menu" This will be displayed under the menu, bool value: has Input Focus or not.
	// Note that as to version Arma2 1.05, if the bool value set to false, Custom Icons will not be displayed.
	["Command Radio",false]
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
	//["First", [0], "", -5, [["expression", "player sidechat ""First"" "]], "1", "1"],
	//["Second", [2], "", -5, [["expression", "player sidechat ""Second"" "]], "1", "1"],
	//["Submenu", [3], "#USER:MY_SUBMENU_inCommunication", -5, [["expression", "player sidechat ""Submenu"" "]], "1", "1"]
];

if( [player] call AIC_fnc_isRadioOwner ) then {

	private ["_radioTasks","_radioTaskId","_radioTaskName","_radioTaskFunction","_radioTaskEnabled","_radioTakeTask","_radioDropTask","_radioShowAsAction","_radioTaskSelectableFunc"];
	_radioTasks = ["pv_cr_radio_tasks",[]] call AIC_fnc_getPublicVariable;

	{
		_radioTaskId = [_x,0] call BIS_fnc_param;
		_radioTaskName = [_x,1] call BIS_fnc_param;
		_radioTaskFunction = [_x,2] call BIS_fnc_param;
		_radioTaskEnabled = [_x,3,true] call BIS_fnc_param;
		_radioTakeTask = [_x,4,false] call BIS_fnc_param;
		_radioDropTask = [_x,5,false] call BIS_fnc_param;
		_radioShowAsAction = [_x,6,false] call BIS_fnc_param;		
		_radioTaskSelectableFunc = [_x,7,{true}] call BIS_fnc_param;

		if(_radioTaskEnabled && not(_radioTakeTask) && not(_radioDropTask) && not(_radioShowAsAction)) then {
			private ["_x"];
			_x = player;
			if( [] call _radioTaskSelectableFunc ) then {
				CR_Command_Radio_Menu = CR_Command_Radio_Menu + 
					[[_radioTaskName, [0], "", -5, [["expression", format ["[[player],""%1"",false] spawn BIS_fnc_MP",_radioTaskFunction]]], "1", "1"]];
			} else {
				CR_Command_Radio_Menu = CR_Command_Radio_Menu + 
					[[_radioTaskName, [0], "", -5, [["expression", format ["[[player],""%1"",false] spawn BIS_fnc_MP",_radioTaskFunction]]], "1", "0"]];
			};
		};
		
	} forEach _radioTasks;
	
	showCommandingMenu "#USER:CR_Command_Radio_Menu";
	
};