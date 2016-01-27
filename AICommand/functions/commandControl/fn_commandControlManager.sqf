#include "functions.h"
#include "..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Command Control Manager

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(hasInterface) then {

	AIC_fnc_commandControlDrawHandler = {
		private ["_commandControls"];
		//_temp = diag_tickTime;
		_commandControls = AIC_fnc_getCommandControls();
		{
			[_x] call AIC_fnc_drawCommandControl;
		} forEach _commandControls;
		//_tempend = diag_tickTime;
		//hint format ["%1",_tempend-_temp];
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

	// Create default EAST and WEST command controls
	
	[] spawn {
	
		["ALL_EAST"] call AIC_fnc_createCommandControl;
		["ALL_WEST"] call AIC_fnc_createCommandControl;
		
		while {true} do {
			{
				if(side _x == east) then {
					["ALL_EAST",_x] call AIC_fnc_commandControlAddGroup;
				} else {
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

