#include "functions.h"
#include "..\properties.h"
#include "..\groupControl\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for a command control

	Parameter(s):
	_this select 0: STRING - command control id
	_this select 1: STRING - Event
	_this select 2: ANY - Params

	Returns: 
	Nothing
*/

private ["_commandControlId","_event","_params"];

_commandControlId = param [0,nil];
_event = param [1];
_params = param [2,[]];

if(_event == "REFRESH_GROUP_CONTROLS") then {

	private ["_groupsRevision","_groups","_groupControls","_newGroupControls","_groupFound","_group","_groupControl"];
	private ["_groupControlGroup","_commandControlShown","_groupControlsToRemove"];
	
	_groupsRevision = AIC_fnc_getCommandControlGroupsRevision(_x);
	_groups = AIC_fnc_getCommandControlGroups(_x);
	_groupControls = AIC_fnc_getCommandControlGroupsControls(_commandControlId);
	_newGroupControls = [];
	
	{
		_groupFound = false;
		_group = _x;
		{
			_groupControl = _x;
			_groupControlGroup = AIC_fnc_getGroupControlGroup(_groupControl);
			if(_groupControlGroup == _group) then {
				_newGroupControls pushBack _groupControl;
				_groupFound = true;
			};
		} forEach _groupControls;
		if(!_groupFound) then {
			_groupControl = [_group] call AIC_fnc_createGroupControl;
			_commandControlShown = AIC_fnc_getCommandControlShown(_commandControlId);
			[_groupControl,_commandControlShown] call AIC_fnc_showGroupControl;
			_newGroupControls pushBack _groupControl;
		};
	} forEach _groups;
	
	_groupControlsToRemove = _groupControls - _newGroupControls;
	{
		[_x] call AIC_fnc_removeGroupControl;
	} forEach _groupControlsToRemove;
	
	AIC_fnc_setCommandControlGroupsControls(_commandControlId,_newGroupControls);
	AIC_fnc_setCommandControlGroupsControlsRevision(_commandControlId,_groupsRevision);
	
};
