#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Shows the command menu
	
	Parameter(s):
	_this select 0: STRING - Command menu type (e.g. "GROUP","WAYPOINT")
	_this select 1: ARRAY - Parameters (defaults to [])
	_this select 2: NUMBER - Command menu action index (defaults to -1)
	_this select 3: NUMBER - Command menu action path index (defaults to 0)
		
	Returns: 
	Nothing
*/

params ["_commandMenuType",["_menuParams",[]],["_actionIndex",-1],["_pathPositionIndex",0]];

private ["_index","_pathLabel","_actionString","_seenMenuLabels"];

//_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_actions = AIC_fnc_getCommandMenuActions();
_seenMenuLabels = [];

if(_actionIndex < 0) then {
	AIC_Group_Control_Menu = [["Command Menu",false]];
	_index = 0;
	{
		_x params ["_type","_label","_path","_actionHandlerScript","_actionHandlerParams","_isEnabledScript"];
		if(_menuParams call _isEnabledScript && _commandMenuType == _type) then {
			if(count _path > 0) then {
				_pathLabel = _path select 0;
				if!(_pathLabel in _seenMenuLabels) then {
					_actionString = format ["[""%1"", %2, %3, %4] spawn AIC_fnc_showCommandMenu",_commandMenuType, _menuParams, _index, 0];
					AIC_Group_Control_Menu pushBack [_pathLabel, [0], "", -5, [["expression", "['" + _actionString + "'] spawn AIC_fnc_commandMenuAction"]], "1", "1"];
					_seenMenuLabels pushBack _pathLabel;
				};
			} else {
				_actionString = format ["[%1, %2] spawn AIC_fnc_executeCommandMenuAction",_index,_menuParams];
				AIC_Group_Control_Menu pushBack [_label, [0], "", -5, [["expression", "['" + _actionString + "'] spawn AIC_fnc_commandMenuAction"]], "1", "1"];
			};
		};
		_index = _index + 1;
	} forEach _actions;
} else {
	private ["_currentAction"];
	_currentAction = _actions select _actionIndex;
	_currentPathLabel = (_currentAction select 2) select _pathPositionIndex;
	AIC_Group_Control_Menu = [[_currentPathLabel,false]];
	_index = 0;
	{
		_x params ["_type","_label","_path","_actionHandlerScript","_actionHandlerParams","_isEnabledScript"];
		if(_menuParams call _isEnabledScript && count _path > _pathPositionIndex && _commandMenuType == _type) then {
			if(_currentPathLabel == (_path select _pathPositionIndex)) then {
				if(count _path > (_pathPositionIndex + 1)) then {
					_pathLabel = _path select (_pathPositionIndex + 1);
					if!(_pathLabel in _seenMenuLabels) then {
						_actionString = format ["[""%1"", %2, %3, %4] spawn AIC_fnc_showCommandMenu",_commandMenuType,_menuParams,_index,(_pathPositionIndex + 1)];
						AIC_Group_Control_Menu pushBack [_pathLabel, [0], "", -5, [["expression", "['" + _actionString + "'] spawn AIC_fnc_commandMenuAction"]], "1", "1"];
						_seenMenuLabels pushBack _pathLabel;
					};
				} else {
					_actionString = format ["[%1, %2] spawn AIC_fnc_executeCommandMenuAction",_index,_menuParams];
					AIC_Group_Control_Menu pushBack [_label, [0], "", -5, [["expression", "['" + _actionString + "'] spawn AIC_fnc_commandMenuAction"]], "1", "1"];
				};
			};
		};		
		_index = _index + 1;
	} forEach _actions;
};

showCommandingMenu "#USER:AIC_Group_Control_Menu";