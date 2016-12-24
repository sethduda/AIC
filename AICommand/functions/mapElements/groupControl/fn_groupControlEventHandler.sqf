#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for a group control

	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 1: STRING - Event
	_this select 2: ANY - Params

	Returns: 
	Nothing
*/

private ["_groupControlId","_event","_params"];

_groupControlId = param [0,nil];
_event = param [1];
_params = param [2,[]];
if(isNil "_groupControlId") then {
	
	if(_event == "MouseHolding" || _event == "MouseMoving") then {
		private ["_mouseMapPositionX","_mouseMapPositionY"];
		_mouseMapPositionX = _params select 1;
		_mouseMapPositionY = _params select 2;
		_mouseWorldPosition = AIC_MAP_CONTROL ctrlMapScreenToWorld [_mouseMapPositionX,_mouseMapPositionY];
		AIC_fnc_setMouseMapPosition(_mouseWorldPosition);
	};
	
	if(_event == "MouseButtonDown") then {
		private ["_groupControls"];
		_groupControls = AIC_fnc_getGroupControls();
		{
			if(AIC_fnc_getMapElementVisible(_x)) then {
				if(_params select 1 == 1) then {			
					[_x,"RIGHT_MOUSE_BUTTON_DOWN_MAP",[]] call AIC_fnc_groupControlEventHandler;
				} else {
					[_x,"LEFT_MOUSE_BUTTON_DOWN_MAP",[]] call AIC_fnc_groupControlEventHandler;
				};		
			};
		} forEach _groupControls;
	};
	
	
	if(_event == "MouseButtonClick") then {
		private ["_groupControls"];
		_groupControls = AIC_fnc_getGroupControls();
		{
			if(AIC_fnc_getMapElementVisible(_x)) then {
				if(_params select 1 == 1) then {			
					[_x,"RIGHT_MOUSE_BUTTON_CLICK_MAP",[]] call AIC_fnc_groupControlEventHandler;
				} else {
					[_x,"LEFT_MOUSE_BUTTON_CLICK_MAP",[]] call AIC_fnc_groupControlEventHandler;
				};		
			};
		} forEach _groupControls;
	};
	
} else {

	// Individual group control event handler (specific to one group control)

	private ["_group"];

	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	
	if( _event == "SELECTED" ) then {
		[_groupControlId] call AIC_fnc_showGroupCommandMenu;
		[[_group]] spawn AIC_fnc_showGroupReport;
	};

	if(_event == "RIGHT_MOUSE_BUTTON_CLICK_MAP" ) then {
		if(AIC_fnc_getGroupControlAddingWaypoints(_groupControlId)) then {
			AIC_fnc_setGroupControlAddingWaypoints(_groupControlId,false);
		};
	};

	if(_event == "LEFT_MOUSE_BUTTON_DOWN_MAP" ) then {
		if(AIC_fnc_getGroupControlAddingWaypoints(_groupControlId)) then {
			[_group, [(AIC_fnc_getMouseMapPosition()),false,"MOVE"]] call AIC_fnc_addWaypoint;
			[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
		};
	};

	if(_event == "REFRESH_GROUP_ICON" ) then {
		private ["_color","_iconSet","_interactiveIconId"];
		_color = AIC_fnc_getGroupControlColor(_groupControlId); 
		_iconSet = [_group,_color] call AIC_fnc_getGroupControlIconSet;
		_interactiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
		AIC_fnc_setInteractiveIconIconSet(_interactiveIconId,_iconSet);
		AIC_fnc_setGroupControlType(_groupControlId,(_group call AIC_fnc_getGroupIconType));
	};
	
	if(_event == "REFRESH_WAYPOINTS" ) then {
		
		private ["_waypointIcons","_waypointIconCount","_waypoints","_currentWpRevision","_waypointsArray", "_waypointIconIndex","_color"];
		
		_waypointIcons = AIC_fnc_getGroupControlWaypointIcons(_groupControlId);

		_waypointIconCount = count _waypointIcons;
		
		_waypoints = [_group] call AIC_fnc_getAllActiveWaypoints;
		_color = AIC_fnc_getGroupControlColor(_groupControlId);

		_currentWpRevision = _waypoints select 0;
		_waypointsArray = _waypoints select 1;
		
		_waypointIconIndex = 0;

		
		private ["_waypointIcon","_wpIconId","_waypointType","_waypointIconSet","_interactiveIconId","_interactiveIconPosition","_eventHandlerScript","_eventHandlerScriptParams"];
		
		{
			
			_waypointType = _x select 3;
			_waypointIconSet = ["MOVE",_color] call AIC_fnc_getGroupControlWpIconSet;

			if(_waypointIconIndex >= _waypointIconCount) then {
				_wpIconId = [_waypointIconSet, _x select 1] call AIC_fnc_createInteractiveIcon;
				[_groupControlId,_wpIconId] call AIC_fnc_addMapElementChild;
				_waypointIcons set [_waypointIconIndex,[_waypointIconIndex,_wpIconId]];
				_eventHandlerScript = {
					private ["_event","_groupControlId","_waypointId","_params"];
					_event = param [1];
					_params = param [2];
					_groupControlId = param [3] select 0;
					_waypointId = param [3] select 1;
					[_groupControlId, _waypointId, _event, _params] spawn AIC_fnc_groupControlWaypointEventHandler;
				};
				_eventHandlerScriptParams = [_groupControlId,_x select 0];
				AIC_fnc_setInteractiveIconEventHandlerScript(_wpIconId, _eventHandlerScript);
				AIC_fnc_setInteractiveIconEventHandlerScriptParams(_wpIconId, _eventHandlerScriptParams);
			} else {
				_waypointIcon = _waypointIcons select _waypointIconIndex;
				_interactiveIconId = _waypointIcon select 1;
				_interactiveIconPosition = _x select 1;
				AIC_fnc_setInteractiveIconPosition(_interactiveIconId,_interactiveIconPosition);
				AIC_fnc_setInteractiveIconIconSet(_interactiveIconId,_waypointIconSet);
				_eventHandlerScriptParams = [_groupControlId,_x select 0];
				AIC_fnc_setInteractiveIconEventHandlerScriptParams(_interactiveIconId, _eventHandlerScriptParams);
				//diag_log format ["Setting Waypoints: %1, %2, %3", _x, _interactiveIconId, _eventHandlerScriptParams];
				_waypointIcons set [_waypointIconIndex,_waypointIcon];
			};
			
			_waypointIconIndex = _waypointIconIndex + 1;
			
		} forEach _waypointsArray;
	
		if(_waypointIconIndex < _waypointIconCount) then {
			for "_i" from _waypointIconIndex to (_waypointIconCount-1) do
			{
				_waypointIcon = _waypointIcons select _i;
				_interactiveIconId = _waypointIcon select 1;
				[_interactiveIconId,false] call AIC_fnc_setMapElementVisible;
			};
		};
		_waypointIcons resize _waypointIconIndex;

		AIC_fnc_setGroupControlWaypointRevision(_groupControlId,_currentWpRevision);  
		AIC_fnc_setGroupControlWaypointIcons(_groupControlId,_waypointIcons);

	};

};

