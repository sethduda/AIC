#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for a group control waypoints

	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 1: STRING - Group wp id
	_this select 2: STRING - Event
	_this select 3: ARRAY - Event params

	Returns: 
	Nothing
*/

private ["_groupControlId","_event","_waypointId"];

_groupControlId = param [0];
_waypointId = param [1];
_event = param [2];
_params = param [3,[]];

private ["_group"];

_group = AIC_fnc_getGroupControlGroup(_groupControlId);

if( _event == "SELECTED" ) then {
	[_groupControlId,_waypointId] call AIC_fnc_showGroupWpCommandMenu;
	[_groupControlId,_waypointId] spawn AIC_fnc_showGroupWaypointReport;
};

if( _event == "DELETE_WAYPOINT_SELECTED" || _event == "KEY_DOWN_211" ) then {
	[_group,_waypointId] call AIC_fnc_disableWaypoint;
	showCommandingMenu "";
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

if( _event == "PICKEDUP" ) then {
	showCommandingMenu "";
};

if( _event == "DROPPED" ) then {
	private ["_waypoint","_position"];
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_position = _params select 0;
	_waypoint set [1,_position];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

if( _event == "NO_GO_CODE_SELECTED" ) then {
	private ["_waypoint"];
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_waypoint set [3,"MOVE"];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

if( _event == "ALPHA_GO_CODE_SELECTED" ) then {
	private ["_waypoint"];
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_waypoint set [3,"ALPHA"];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

if( _event == "BRAVO_GO_CODE_SELECTED" ) then {
	private ["_waypoint"];
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_waypoint set [3,"BRAVO"];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

