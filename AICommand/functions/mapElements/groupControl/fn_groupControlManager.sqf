#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for group controls

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

// Setup UI event handlers

["MAP_CONTROL","MouseButtonDown", "[nil, ""MouseButtonDown"",_this] call AIC_fnc_groupControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseButtonClick", "[nil, ""MouseButtonClick"",_this] call AIC_fnc_groupControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseMoving", "[nil, ""MouseMoving"",_this] call AIC_fnc_groupControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;
["MAP_CONTROL","MouseHolding", "[nil, ""MouseHolding"",_this] call AIC_fnc_groupControlEventHandler"] spawn AIC_fnc_addManagedEventHandler;

// Manage updates to group waypoints

[] spawn {
	private ["_lastWpRevision","_waypoints","_currentWpRevision","_groupControls","_group","_groupControlId"];
	while {true} do {
		_groupControls = AIC_fnc_getGroupControls();
		{
			_groupControlId = _x;
			_group = AIC_fnc_getGroupControlGroup(_groupControlId);
			_lastWpRevision = AIC_fnc_getGroupControlWaypointRevision(_groupControlId);  
			_waypoints = [_group] call AIC_fnc_getAllWaypoints;
			_currentWpRevision = _waypoints select 0;
			if(_lastWpRevision != _currentWpRevision) then {
				[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
			};
		} forEach _groupControls;
		sleep 2;
	};
};

// Manage updates to group icon type

[] spawn {
	private ["_groupControls","_groupControlId","_group","_currentGroupType","_groupType"];
	while {true} do {
		_groupControls = AIC_fnc_getGroupControls();
		{
			_groupControlId = _x;
			_group = AIC_fnc_getGroupControlGroup(_groupControlId);
			_currentGroupType = AIC_fnc_getGroupControlType(_groupControlId); 
			_groupType = _group call AIC_fnc_getGroupIconType;
			if(_groupType != _currentGroupType) then {
				[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
			};
		} forEach _groupControls;
		sleep 5;
	};
};

// Manage updates to group color

[] spawn {
	private ["_currentControlColor","_waypoints","_currentWpRevision","_groupControls","_group","_groupControlId"];
	while {true} do {
		_groupControls = AIC_fnc_getGroupControls();
		{
			_groupControlId = _x;
			_group = AIC_fnc_getGroupControlGroup(_groupControlId);
			_currentControlColor = AIC_fnc_getGroupControlColor(_groupControlId);  
			_currentGroupColor = [_group] call AIC_fnc_getGroupColor;
			if((_currentControlColor select 0) != (_currentGroupColor select 0)) then {
				AIC_fnc_setGroupControlColor(_groupControlId,_currentGroupColor);
				[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
				[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
				[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
			};
			_currentGroupType = AIC_fnc_getGroupControlType(_groupControlId); 
			_groupType = _group call AIC_fnc_getGroupIconType;
			if(_groupType != _currentGroupType) then {
				[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
			};
			
		} forEach _groupControls;
		sleep 2;
	};
};

// Manage groups with other groups as cargo

[] spawn {
	private ["_groupsAsDrivers","_groupsAsCargo","_newGroupsAsDrivers","_newGroupsAsCargo","_groupControls","_groupControlId"];
	private ["_group","_groupLeader"];
	_groupsAsDrivers = [];
	_groupsAsCargo = [];
	while {true} do {
		_newGroupsAsDrivers = [];
		_newGroupsAsCargo = [];
		_groupControls = AIC_fnc_getGroupControls();
		{
			_groupControlId = _x;
			_group = AIC_fnc_getGroupControlGroup(_groupControlId);
			_groupLeader = leader _group;
			{
				if( _groupLeader in _x && (group driver _x) == _group ) then {
					_hasOtherGroups = false;
					{
						if(group _x != _group) exitWith {
							_hasOtherGroups = true;
						};
					} forEach (crew _x);
					if(_hasOtherGroups) then {
						_newGroupsAsDrivers pushBack _groupControlId;
						_group setVariable ["AIC_Has_Group_Cargo",true];
					};
				};
				if( _groupLeader in _x && (group driver _x) != _group && (leader group driver _x) in _x ) then {
					_newGroupsAsCargo pushBack _groupControlId;
					[_groupControlId,false] call AIC_fnc_setMapElementEnabled;
					[_groupControlId,false] call AIC_fnc_setMapElementForeground;
				};
			} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
		} forEach _groupControls;
		{
			_group = AIC_fnc_getGroupControlGroup(_x);
			_group setVariable ["AIC_Has_Group_Cargo",false];
		} forEach (_groupsAsDrivers - _newGroupsAsDrivers);
		_groupsAsDrivers = _newGroupsAsDrivers;
		{
			[_x,true] call AIC_fnc_setMapElementEnabled;
			[_x,true] call AIC_fnc_setMapElementForeground;
		} forEach (_groupsAsCargo - _newGroupsAsCargo);
		_groupsAsCargo = _newGroupsAsCargo;
		sleep 1;
	};
};



