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

[] spawn {
	waitUntil {!isNull AIC_MAP_CONTROL};
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonDown", "[nil, ""MouseButtonDown"",_this] call AIC_fnc_groupControlEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseButtonClick", "[nil, ""MouseButtonClick"",_this] call AIC_fnc_groupControlEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseMoving", "[nil, ""MouseMoving"",_this] call AIC_fnc_groupControlEventHandler" ];
	AIC_MAP_CONTROL ctrlAddEventHandler ["MouseHolding", "[nil, ""MouseHolding"",_this] call AIC_fnc_groupControlEventHandler" ];
};

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



