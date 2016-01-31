#include "functions.h"
#include "..\interactiveIcon\functions.h"
#include "..\..\properties.h"

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

[] spawn {
	waitUntil {!isNull AIC_MAIN_DISPLAY};
	AIC_MAIN_DISPLAY displayAddEventHandler ["KeyDown", "[nil, ""KeyDown"",_this] call AIC_fnc_groupControlEventHandler" ];
};

// Remote control manager

[] spawn {
	while {true} do {
		private ["_rcUnit"];
		_rcUnit = player getVariable ["AIC_Remote_Control_Unit",objNull];
		if(!isNull _rcUnit) then {	
			if(!alive _rcUnit) then {
				// Trigger delete key event handler
				[nil, "KeyDown",[nil,211]] call AIC_fnc_groupControlEventHandler;
			};
		};
		sleep 2;
	};
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
				[_groupControlId,"COLOR_CHANGED",[]] call AIC_fnc_groupControlEventHandler;
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

// Manage updates to group actions

[] spawn {
	private ["_lastActionRevision","_groupActions","_currentActionsRevision","_groupControls","_group","_groupControlId"];
	while {true} do {
		_groupControls = AIC_fnc_getGroupControls();
		{
			_groupControlId = _x;
			_group = AIC_fnc_getGroupControlGroup(_groupControlId);
			_lastActionRevision = AIC_fnc_getGroupControlActionsRevision(_groupControlId);  
			_groupActions = [_group] call AIC_fnc_getGroupActions;
			_currentActionsRevision = _groupActions select 0;
			if(_lastActionRevision != _currentActionsRevision) then {
				[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
			};
		} forEach _groupControls;
		sleep 2;
	};
};





