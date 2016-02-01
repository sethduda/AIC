#include "functions.h"
#include "..\..\properties.h"
#include "..\commandControl\functions.h"
#include "..\interactiveIcon\functions.h"
#include "..\functions.h"

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

	// Global group control event handler (not specific to any one group control)

	if(_event == "KeyDown") then {
		if(_params select 1 == 211) then {
			player remoteControl objNull;
			(vehicle player) switchCamera cameraView;
			private ["_rcUnit"];
			_rcUnit = player getVariable ["AIC_Remote_Control_Unit",objNull];
			if(!isNull _rcUnit) then {
				objNull remoteControl _rcUnit;
				player setVariable ["AIC_Remote_Control_Unit",objNull];
				["RemoteControl",["","Remote Control Terminated"]] call BIS_fnc_showNotification;
			};
		}
	};
	
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
	
	if( _event == "ASSIGN_VEHICLE_SELECTED" ) then {
	
		private ["_vehicle","_vehicleRoles","_vehicleRolesCount","_groupUnits","_groupUnitCount","_minCount","_role","_unit","_action","_actions"];
		_vehicle = _params select 0;

		_vehicleRoles = [_vehicle] call BIS_fnc_vehicleRoles;
		_vehicleRolesCount = count _vehicleRoles;
		_groupUnits = units _group;
		_groupUnitCount = count (units _group);
		_minCount = _vehicleRolesCount min _groupUnitCount;
		
		for "_i" from 0 to (_minCount-1) do
		{
			_role = _vehicleRoles select _i;
			_unit = _groupUnits select _i;
			if((_role select 0) == "Driver") then {
				_unit assignAsDriver _vehicle;
			};
			if((_role select 0) == "Turret") then {
				_unit assignAsTurret [_vehicle,_role select 1];
			};
			if((_role select 0) == "Cargo") then {
				_unit assignAsCargoIndex [_vehicle,(_role select 1) select 0];
			};
			[[_unit],true] remoteExec ["orderGetIn", _unit];
		};
		
		
		private ["_groupActions","_newGroupActions","_existingAction","_existingVehicles","_groupActionUpdated"];
		
		_groupActions = ([_group] call AIC_fnc_getGroupActions) select 1;
		_groupActionUpdated = false;
		_newGroupActions = [];
		{
			if((_x select 0) == "GROUP_VEHICLE_ASSIGNMENT") then {
				_existingAction = _x;
				_existingVehicles = (_existingAction select 1) select 0;
				_newGroupActions pushBack ["GROUP_VEHICLE_ASSIGNMENT",[_existingVehicles + [_vehicle]]];
			} else {
				_newGroupActions pushBack _x;
			}
		} forEach _groupActions;
		if(!_groupActionUpdated) then {
			_newGroupActions pushBack ["GROUP_VEHICLE_ASSIGNMENT",[[_vehicle]]];
		};
		[_group, _newGroupActions] call AIC_fnc_setGroupActions;
		
		[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
		
	};
	
	if( _event == "ASSIGN_VEHICLE_ACTION_SELECTED" ) then {
		private ["_actionControl"];
		_actionControl = ["ASSIGN_GROUP_VEHICLE",[_groupControlId]] call AIC_fnc_createActionControl;
		[_actionControl,true] call AIC_fnc_setMapElementVisible;
	};

	if( _event == "UNASSIGN_VEHICLE_ACTION_SELECTED" ) then {
		{
			[_group,vehicle _x] remoteExec ["leaveVehicle", _x];
		} forEach (units _group);
	};
	
	if( _event == "SELECTED" ) then {
		[_groupControlId] call AIC_fnc_showGroupCommandMenu;
		[[_group]] spawn AIC_fnc_showGroupReport;
	};

	if( _event == "CLEAR_WAYPOINTS_SELECTED" ) then {
		[_group] call AIC_fnc_disableAllWaypoints;	
		[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	};

	if( _event == "ADD_WAYPOINTS_SELECTED" ) then {
		AIC_fnc_setGroupControlAddingWaypoints(_groupControlId,true);
	};

	if( _event == "REMOTE_CONTROL_SELECTED" ) then {
		player remoteControl (leader _group);
		(vehicle (leader _group)) switchCamera "External";
		player setVariable ["AIC_Remote_Control_Unit",(leader _group)];
		openMap false;
		["RemoteControl",["","Press DELETE to Exit Remote Control"]] call BIS_fnc_showNotification;
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
	
	if(_event == "CHANGE_BEHAVIOUR" ) then {
		private ["_mode"];
		_mode = _params select 0;
		[_group,_mode] remoteExec ["setBehaviour", leader _group]; 
	};
	
	if(_event == "CHANGE_COMBAT_MODE" ) then {
		private ["_mode"];
		_mode = _params select 0;
		[_group,_mode] remoteExec ["setCombatMode", leader _group]; 
	};
	
	if(_event == "CHANGE_COLOR" ) then {
		private ["_color"];
		_color = _params select 0;
		[_group,_color] call AIC_fnc_setGroupColor;
		[_groupControlId,"COLOR_CHANGED",[]] call AIC_fnc_groupControlEventHandler;
	};
	
	if(_event == "COLOR_CHANGED" ) then {
		AIC_fnc_setGroupControlColor(_groupControlId,[_group] call AIC_fnc_getGroupColor);
		[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
		[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
		[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
	};
	
	if(_event == "REFRESH_GROUP_ICON" ) then {
		private ["_color","_iconSet","_interactiveIconId"];
		_color = AIC_fnc_getGroupControlColor(_groupControlId); 
		_iconSet = [_group,_color] call AIC_fnc_getGroupControlIconSet;
		_interactiveIconId = AIC_fnc_getGroupControlInteractiveIcon(_groupControlId);
		AIC_fnc_setInteractiveIconIconSet(_interactiveIconId,_iconSet);
		AIC_fnc_setGroupControlType(_groupControlId,(_group call AIC_fnc_getGroupIconType));
	};
	
	if(_event == "REFRESH_ACTIONS" ) then {
	
		private ["_groupActions","_existingActions"];
		_groupActions = [_group] call AIC_fnc_getGroupActions;
		_existingActions = AIC_fnc_getGroupControlActions(_groupControlId);
		
		// Remove all existing actions
		{
			[_x] call AIC_fnc_deleteMapElement;
		} forEach _existingActions;
		
		// Add all actions assigned to group
		_newActions = [];
		{
			_actionType = _x select 0;
			_actionParams = _x select 1;
			if(_actionType == "GROUP_VEHICLE_ASSIGNMENT") then {
				_vehicles = _actionParams select 0;
				_action = [_groupControlId, _group, _vehicles] call AIC_fnc_createGroupVehicleAssignmentAction;
				_newActions pushBack _action;
				[_groupControlId,_action] call AIC_fnc_addMapElementChild;
			};
		} forEach (_groupActions select 1);
		AIC_fnc_setGroupControlActions(_groupControlId,_newActions);
		AIC_fnc_setGroupControlActionsRevision(_groupControlId, _groupActions select 0); 
		
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
			_waypointIconSet = [_waypointType,_color] call AIC_fnc_getGroupControlWpIconSet;

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

