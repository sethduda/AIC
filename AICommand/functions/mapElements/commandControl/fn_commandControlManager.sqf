#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Command Control Manager

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

["ALL_EAST"] call AIC_fnc_createCommandControl;
["ALL_WEST"] call AIC_fnc_createCommandControl;

if(hasInterface) then {
		
	AIC_fnc_commandControlDrawHandler = {
	
		//_temp = diag_tickTime;
		
		private ["_commandControls","_actionControls","_actionControlShown"];
		
		_commandControls = AIC_fnc_getCommandControls();
		_actionControls = AIC_fnc_getActionControls();
		_actionControlShown = false;
		
		// Draw all visible action controls
		
		{
			if(AIC_fnc_getMapElementVisible(_x)) then {
				[_x] call AIC_fnc_drawActionControl;
				_actionControlShown = true;
			};
		} forEach _actionControls;
		
		// Draw command controls
		
		{
			// Move all command controls to the background if an action control is visible
		
			if(_actionControlShown) then {
					if(AIC_fnc_getMapElementForeground(_x)) then {
						[_x,false] call AIC_fnc_setMapElementForeground;
						[_x,false] call AIC_fnc_setMapElementEnabled;
					};
			} else {
					if(!(AIC_fnc_getMapElementForeground(_x))) then {
						[_x,true] call AIC_fnc_setMapElementForeground;
						[_x,true] call AIC_fnc_setMapElementEnabled;
					};
			};
			
			[_x] call AIC_fnc_drawCommandControl;
		} forEach _commandControls;
		
		//_temp2 = diag_tickTime;
		
	    // hint str (_temp2 - _temp);
			
	};

	// Setup UI event handlers

	[] spawn {
		waitUntil {!isNull AIC_MAP_CONTROL};
		AIC_MAP_CONTROL ctrlAddEventHandler ["Draw", "_this call AIC_fnc_commandControlDrawHandler" ];
	};
	
	// Check for command control group controls revision changes
	[] spawn {
		private ["_commandControls","_groupsRevision","_currentRevision"];
		while {true} do {
			_commandControls = AIC_fnc_getCommandControls();
			{
				_groupsRevision = AIC_fnc_getCommandControlGroupsRevision(_x);
				_currentRevision = AIC_fnc_getCommandControlGroupsControlsRevision(_x);
				if(_groupsRevision != _currentRevision) then {
					[_x,"REFRESH_GROUP_CONTROLS",[]] call AIC_fnc_commandControlEventHandler;
				};
			} forEach _commandControls;
			sleep 2;
		};
	};
	
};

if(isServer) then {
	
	[] spawn {

		while {true} do {
			{
				if(side _x == east) then {
					["ALL_EAST",_x] call AIC_fnc_commandControlAddGroup;
				};
				if(side _x == west) then {
					["ALL_WEST",_x] call AIC_fnc_commandControlAddGroup;
				};
			} forEach allGroups;
			sleep 10;
		};
		
	};

	// Check for empty groups associated with command controls and remove them
	
	[] spawn {
		private ["_commandControls","_commandControlId","_groups","_groupControls","_group","_units"];
		while {true} do {
			_commandControls = AIC_fnc_getCommandControls();
			{
				_commandControlId = _x;
				_groups = AIC_fnc_getCommandControlGroups(_commandControlId);
				{
					_group = _x;
					_units = [];
					{if (alive _x) then {_units = _units + [_x]}} foreach (units _group);
					if(count _units == 0) then {
						[_commandControlId, _group] call AIC_fnc_commandControlRemoveGroup;
					};			
				} forEach _groups;
			} forEach _commandControls;
			sleep 10;
		};
	};
	
	// Manage group actions

	[] spawn {
		while {true} do {
			private ["_group","_revisionUpToDate","_actions","_revision","_lastSeenRevision","_actionType","_actionParams"];
			{
				_group = _x;
				_actions = [_group] call AIC_fnc_getGroupActions;
				_revision = _actions select 0;
				_lastSeenRevision = _group getVariable ["AIC_Last_Seen_Actions_Revision",-1];
				_revisionUpToDate = (_revision==_lastSeenRevision);
				
				if(!_revisionUpToDate) then {
					_group setVariable ["AIC_Last_Seen_Actions_Revision",_revision];
				};
				
				{
					_actionType = _x select 0;
					_actionParams = _x select 1;
					if(_actionType == "GROUP_VEHICLE_ASSIGNMENT") then {
					
						private ["_vehicles","_existingVehicles","_vehiclesToUnassign","_vehiclesToAssign","_vehicleSlotsToAssign","_maxSlots","_vehicleRoles","_vehicleToEmpty","_unitIndex","_countOfSlots"];
						private ["_vehicleToAssign","_role"];
					
						_vehicles = _actionParams select 0;
						
						
						if(!_revisionUpToDate) then {
						
							_existingVehicles = [_group] call AIC_fnc_getGroupAssignedVehicles;
							[_group,_vehicles] call AIC_fnc_setGroupAssignedVehicles;
							_vehiclesToUnassign = false;
							_vehiclesToAssign = false;
														
							
							{
								if!(_x in _vehicles) then {
									_vehiclesToUnassign = true;
								};
							} forEach _existingVehicles;
							{
								if!(_x in _existingVehicles) then {
									_vehiclesToAssign = true;
								};
							} forEach _vehicles;
							
							if( _vehiclesToUnassign || _vehiclesToAssign ) then {
							
								_vehicleSlotsToAssign = [];
								
								_maxSlots = 0;
								{
									_vehicleRoles = [_x] call BIS_fnc_vehicleRoles;
									if(count _vehicleRoles > _maxSlots) then {
										_maxSlots = count _vehicleRoles;
									};
								} forEach _vehicles;
								
								if(_maxSlots > 0) then {
									for "_i" from 0 to (_maxSlots-1) do {
										{
											_vehicleRoles = [_x] call BIS_fnc_vehicleRoles;
											if(count _vehicleRoles > _i) then {
												_vehicleSlotsToAssign pushBack [_x,_vehicleRoles select _i];
											};
										} forEach _vehicles;
									};
								};
		
								// Assign units to vehicles
								_unitIndex = 0;
								_countOfSlots = count _vehicleSlotsToAssign;
								{
									if(_countOfSlots > _unitIndex) then {
										_vehicleToAssign = (_vehicleSlotsToAssign select _unitIndex) select 0;
										_role = (_vehicleSlotsToAssign select _unitIndex) select 1;
										[[_x,_vehicleToAssign,_role],"AIC_fnc_getInVehicle",_x] spawn BIS_fnc_MP; 
										_x setVariable ["AIC_Assigned_Vehicle", _vehicleToAssign];
									} else {
										_x setVariable ["AIC_Assigned_Vehicle", nil];
									};
									_unitIndex = _unitIndex + 1;
								} forEach (units _group);
								
							};
						};
						
						private ["_allUnitsIn","_assignedVehicle"];
						_allUnitsIn = true;
						{ 
							_assignedVehicle = _x getVariable ["AIC_Assigned_Vehicle", objNull];
							if(!isNull(_assignedVehicle)) then {
								if(not(_x in _assignedVehicle) && alive _assignedVehicle) then {
									_allUnitsIn = false;
								};
							};
						} forEach (units _group);
						if(_allUnitsIn) then {
							// TODO this won't work once there's more than one action
							[_group,[]] call AIC_fnc_setGroupActions;
						};
						
					};
				} forEach (_actions select 1);
			} forEach allGroups;
			sleep 2;
		};
	};
	
	// Manage group waypoints

	[] spawn {
		while {true} do {
			private ["_group","_groupControl","_lastWpRevision","_groupWaypoints","_groupControlWaypoints","_currentWpRevision","_groupControlWaypointArray","_wp","_goCodeWpFound","_wpType","_waitForCode"];
			{
				_group = _x;

				_lastWpRevision = _group getVariable ["AIC_Server_Last_Wp_Revision",0];
				_groupWaypoints = waypoints _group;
				_groupControlWaypoints = [_group] call AIC_fnc_getAllActiveWaypoints;
				_currentWpRevision = _groupControlWaypoints select 0;
				_groupControlWaypointArray = _groupControlWaypoints select 1;
				
				_waitForCode = _group getVariable ["AIC_Wait_For_Go_Code","NONE"];
				if(_waitForCode == "NONE") then {
					
					if( _currentWpRevision != _lastWpRevision) then {
						//hint "changing waypoints";
						while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
						_goCodeWpFound = false;
						{
							if(!_goCodeWpFound) then {
								_wpType = _x select 3;
								_wp = _group addWaypoint [_x select 1, 0];
								if(_wpType == "ALPHA" || _wpType == "BRAVO") then {
									_goCodeWpFound = true;
									_wp setWaypointStatements ["true", "[group this, "+str (_x select 0)+"] call AIC_fnc_disableWaypoint; [group this,'"+_wpType+"'] call AIC_fnc_waitForWaypointGoCode;"];
								} else {
									_wp setWaypointStatements ["true", "[group this, "+str (_x select 0)+"] call AIC_fnc_disableWaypoint;"];
								};
							};
						} forEach _groupControlWaypointArray;
						if(count (waypoints _group)==0) then {
							_group addWaypoint [position leader _group, 0];
						};
						_group setVariable ["AIC_Server_Last_Wp_Revision",_currentWpRevision];
					};
					
				};

			} forEach allGroups;
			sleep 2;
		};
	};
};

