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
["ALL_GUER"] call AIC_fnc_createCommandControl;
["ALL_CIV"] call AIC_fnc_createCommandControl;


AIC_fnc_addWaypointsActionHandler = {
	params ["_group","_groupControlId","_params"];
	AIC_fnc_setGroupControlAddingWaypoints(_groupControlId,true);
};

["Add Waypoints",[],AIC_fnc_addWaypointsActionHandler] call AIC_fnc_addCommandMenuAction;


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

AIC_fnc_setGroupColorActionHandler = {
	params ["_group","_groupControlId","_params"];
	_params params ["_color"];
	[_group,_color] call AIC_fnc_setGroupColor;
	AIC_fnc_setGroupControlColor(_groupControlId,_color);
	[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("Color set to " + toLower (_color select 0));
};

["Red",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_RED]] call AIC_fnc_addCommandMenuAction;
["Blue",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_BLUE]] call AIC_fnc_addCommandMenuAction;
["Green",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_GREEN]] call AIC_fnc_addCommandMenuAction;
["Black",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_BLACK]] call AIC_fnc_addCommandMenuAction;
["White",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_WHITE]] call AIC_fnc_addCommandMenuAction;


AIC_fnc_setGroupBehaviourActionHandler = {
	params ["_group","_groupControlId","_params"];
	_params params ["_mode"];
	[_group,_mode] remoteExec ["setBehaviour", leader _group]; 
	hint ("Behaviour set to " + toLower _mode);
};

["Careless",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["CARELESS"]] call AIC_fnc_addCommandMenuAction;
["Safe",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["SAFE"]] call AIC_fnc_addCommandMenuAction;
["Aware",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["AWARE"]] call AIC_fnc_addCommandMenuAction;
["Combat",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["COMBAT"]] call AIC_fnc_addCommandMenuAction;
["Stealth",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["STEALTH"]] call AIC_fnc_addCommandMenuAction;

AIC_fnc_joinGroupActionHandler = {
	params ["_group","_groupControlId","_selectedGroup","_params"];
	if(!isNull _selectedGroup) then {
		(units _group) joinSilent _selectedGroup;
		hint ("Selected Group Joined");
	} else {
		hint ("No Group Selected");
	};
};

["Join A Group",["Group Size"],AIC_fnc_joinGroupActionHandler,[],"GROUP"] call AIC_fnc_addCommandMenuAction;

AIC_fnc_splitGroupHalfActionHandler = {
	params ["_group","_groupControlId"];
	_group2 = createGroup (side _group);
	_joinNewGroup = false;
	{
		if(_joinNewGroup) then {
			[_x] joinSilent _group2;
			_joinNewGroup = false;
		} else {	
			_joinNewGroup = true;
		};
	} forEach (units _group);
	hint ("Group Split in Half");
};

["In Half",["Group Size","Split Group"],AIC_fnc_splitGroupHalfActionHandler,[],"NONE",{
	params ["_group"];
	count units _group > 1;
}] call AIC_fnc_addCommandMenuAction;

AIC_fnc_splitGroupUnitsActionHandler = {
	params ["_group","_groupControlId"];
	
	// Find all command controls to update with new split groups
	_commandControlsToUpdate = [];
	_commandControls = AIC_fnc_getCommandControls();
	{
		_commandControlId = _x;
		_groups = AIC_fnc_getCommandControlGroups(_commandControlId);
		if(_group in _groups) then {
			_commandControlsToUpdate pushBack _commandControlId;
		};
	} forEach _commandControls;
	
	{
		_group = createGroup (side _x);
		[_x] joinSilent _group;
		{
			[_x,_group] call AIC_fnc_commandControlAddGroup;
		} forEach _commandControlsToUpdate;
	} forEach (units _group);
	
	hint ("Group Split into Individual Units");
	
};

["Into Individual Units",["Group Size","Split Group"],AIC_fnc_splitGroupUnitsActionHandler,[],"NONE",{
	params ["_group"];
	count units _group > 1;
}] call AIC_fnc_addCommandMenuAction;
	
AIC_fnc_setGroupSpeedActionHandler = {
	params ["_group","_groupControlId","_params"];
	_params params ["_speed","_label"];
	[_group,_speed] remoteExec ["setSpeedMode", leader _group]; 
	hint ("Speed set to " + _label);
};	
		
["Half Speed",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["LIMITED", "Half Speed"]] call AIC_fnc_addCommandMenuAction;
["Full Speed (In Formation)",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["NORMAL", "Full Speed (In Formation)"]] call AIC_fnc_addCommandMenuAction;
["Full (No Formation)",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["FULL", "Full (No Formation)"]] call AIC_fnc_addCommandMenuAction;	

AIC_fnc_setFlyInHeightActionHandler = {
	params ["_group","_groupControlId","_params"];
	_params params ["_height"];
	{
		if(_x isKindOf "Air") then {
			[_x,_height] remoteExec ["flyInHeight", _x]; 
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	hint ("Fly in height set to " + (str _height) + " meters");
};

["500 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[500],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["250 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[250],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["100 meters (default)",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[100],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["50 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[50],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["40 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[40],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["30 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[30],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["20 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[20],"NONE",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

AIC_fnc_setGroupCombatModeActionHandler = {
	params ["_group","_groupControlId","_params"];
	_params params ["_mode","_modeLabel"];
	[_group,_mode] remoteExec ["setCombatMode", leader _group]; 
	hint ("Combat mode set to " + toLower _modeLabel);
};

["Never fire",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["BLUE","Never fire"]] call AIC_fnc_addCommandMenuAction;
["Hold fire - defend only",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["GREEN","Hold fire - defend only"]] call AIC_fnc_addCommandMenuAction;
["Hold fire, engage at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["WHITE","Hold fire, engage at will"]] call AIC_fnc_addCommandMenuAction;
["Fire at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["YELLOW","Fire at will"]] call AIC_fnc_addCommandMenuAction;
["Fire at will, engage at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["RED","Fire at will, engage at will"]] call AIC_fnc_addCommandMenuAction;
		
AIC_fnc_clearAllWaypointsActionHandler = {
	params ["_group","_groupControlId","_params"];
	[_group] call AIC_fnc_disableAllWaypoints;	
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("All waypoints cleared");
};

["Confirm Cancel All",["Clear All Waypoints"],AIC_fnc_clearAllWaypointsActionHandler] call AIC_fnc_addCommandMenuAction;		

AIC_fnc_remoteControlActionHandler = {
	params ["_group","_groupControlId","_params"];
	private ["_fromUnit","_rcUnit","_exitingRcUnit"];

	_fromUnit = missionNamespace getVariable ["AIC_Remote_Control_From_Unit",objNull];
	if(isNull _fromUnit || !alive _fromUnit) then {
		_fromUnit = player;
		missionNamespace setVariable ["AIC_Remote_Control_From_Unit",_fromUnit];
	};
	
	_rcUnit = leader _group;
	if(!alive _rcUnit) exitWith {
		["RemoteControl",["","Remote Control Failed: Not Alive"]] call BIS_fnc_showNotification;
	};
	_exitingRcUnit = missionNamespace getVariable ["AIC_Remote_Control_To_Unit",objNull];
	if(!isNull _exitingRcUnit) then {
		_exitingRcUnit removeEventHandler ["HandleDamage", (missionNamespace getVariable ["AIC_Remote_Control_To_Unit_Event_Handler",-1])];
		AIC_MAIN_DISPLAY displayRemoveEventHandler ["KeyDown", (missionNamespace getVariable ["AIC_Remote_Control_Delete_Handler",-1])];
	};
	missionNamespace setVariable ["AIC_Remote_Control_To_Unit",_rcUnit];

	AIC_Remote_Control_From_Unit_Event_Handler = _fromUnit addEventHandler ["HandleDamage", "[] call AIC_fnc_terminateRemoteControl; _this select 2;"];
	AIC_Remote_Control_To_Unit_Event_Handler = _rcUnit addEventHandler ["HandleDamage", "[] call AIC_fnc_terminateRemoteControl; _this select 2;"];
	AIC_Remote_Control_Delete_Handler = AIC_MAIN_DISPLAY displayAddEventHandler ["KeyDown", "if(_this select 1 == 211) then { [] call AIC_fnc_terminateRemoteControl; }" ];
	
	BIS_fnc_feedback_allowPP = false;
	selectPlayer _rcUnit;
	(vehicle _rcUnit) switchCamera "External";
	openMap false;
	
	["RemoteControl",["","Press DELETE to Exit Remote Control"]] call BIS_fnc_showNotification;
	
};

AIC_fnc_terminateRemoteControl = {
	AIC_MAIN_DISPLAY displayRemoveEventHandler ["KeyDown", (missionNamespace getVariable ["AIC_Remote_Control_Delete_Handler",-1])];
	(missionNamespace getVariable ["AIC_Remote_Control_From_Unit",objNull]) removeEventHandler ["HandleDamage", (missionNamespace getVariable ["AIC_Remote_Control_From_Unit_Event_Handler",-1])];
	(missionNamespace getVariable ["AIC_Remote_Control_To_Unit",objNull]) removeEventHandler ["HandleDamage", (missionNamespace getVariable ["AIC_Remote_Control_To_Unit_Event_Handler",-1])];
	missionNamespace setVariable ["AIC_Remote_Control_To_Unit",nil];
	selectPlayer (missionNamespace getVariable ["AIC_Remote_Control_From_Unit",player]);
	(vehicle player) switchCamera cameraView;
	BIS_fnc_feedback_allowPP = true;
	["RemoteControl",["","Remote Control Terminated"]] call BIS_fnc_showNotification;
};

["Remote Control",[],AIC_fnc_remoteControlActionHandler,[],"NONE",{
	params ["_group"];
	private ["_canControl"];
	_canControl = true;
	if(!alive leader _group) then {
		_canControl = false;
	};
	if(isPlayer leader _group) then {
		_canControl = false;
	};
	_canControl;
}] call AIC_fnc_addCommandMenuAction;

AIC_fnc_assignVehicleActionHandler = {
	params ["_group","_groupControlId","_selectedVehicle","_params"];
	if(!isNull _selectedVehicle) then {
		private ["_vehicleName","_assignedVehicles","_vehicleSlotsToAssign","_maxSlots","_vehicleRoles"];
		private ["_unitIndex","_countOfSlots","_vehicleToAssign"];
		[_group,_selectedVehicle] remoteExec ["addVehicle", leader _group];
		_assignedVehicles = [_group] call AIC_fnc_getGroupAssignedVehicles;
		_assignedVehicles pushBack _selectedVehicle;
		[_group,_assignedVehicles] call AIC_fnc_setGroupAssignedVehicles;
		_vehicleSlotsToAssign = [];
		_maxSlots = 0;
		{
			_vehicleRoles = [_x] call BIS_fnc_vehicleRoles;
			if(count _vehicleRoles > _maxSlots) then {
				_maxSlots = count _vehicleRoles;
			};
		} forEach _assignedVehicles;
		if(_maxSlots > 0) then {
			for "_i" from 0 to (_maxSlots-1) do {
				{
					_vehicleRoles = [_x] call BIS_fnc_vehicleRoles;
					if(count _vehicleRoles > _i) then {
						_vehicleSlotsToAssign pushBack [_x,_vehicleRoles select _i];
					};
				} forEach _assignedVehicles;
			};
		};
		_unitIndex = 0;
		_countOfSlots = count _vehicleSlotsToAssign;
		{
			if(_countOfSlots > _unitIndex) then {
				_vehicleToAssign = (_vehicleSlotsToAssign select _unitIndex) select 0;
				_role = (_vehicleSlotsToAssign select _unitIndex) select 1;
				[_x,_vehicleToAssign,_role] remoteExec ["AIC_fnc_getInVehicle", _x];
			};
			_unitIndex = _unitIndex + 1;
		} forEach (units _group);
		if(_selectedVehicle isKindOf "Air") then {
			[_selectedVehicle,100] remoteExec ["flyInHeight", _selectedVehicle]; 
		};
		_vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _selectedVehicle >> "displayName");
		hint ("Vehicle assigned: " + _vehicleName);
	} else {
		hint ("No vehicle assigned");
	};
};

["Assign Vehicle",[],AIC_fnc_assignVehicleActionHandler,[],"VEHICLE"] call AIC_fnc_addCommandMenuAction;		

AIC_fnc_unassignVehicleActionHandler = {
	params ["_group"];
	{
		[_group,_x] remoteExec ["leaveVehicle", leader _group];
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	[_group,nil] call AIC_fnc_setGroupAssignedVehicles;
	hint ("All vehicles unassigned");
};

["Unassign All Vehicle(s)",[],AIC_fnc_unassignVehicleActionHandler,[],"NONE",{
	params ["_group"];
	private ["_canUnassign"];
	_canUnassign = false;
	_canUnassign = (count ([_group] call AIC_fnc_getGroupAssignedVehicles) > 0);
	{
		if( _x != vehicle _x ) then {
			_canUnassign = true;
		};
	} forEach (units _group);
	_canUnassign;
}] call AIC_fnc_addCommandMenuAction;	

AIC_fnc_unloadOtherGroupsActionHandler = {
	params ["_group"];
	private ["_vehicle","_unloadedGroups","_assignedVehicles"];
	_unloadedGroups = [];
	{
		_vehicle = _x;
		{
			if(group _x != _group) then {
				if!(group _x in _unloadedGroups) then {
					[group _x, _vehicle] remoteExec ["leaveVehicle", leader group _x];
					_unloadedGroups pushBack (group _x);
					_assignedVehicles = [group _x] call AIC_fnc_getGroupAssignedVehicles;
					_assignedVehicles = _assignedVehicles - [_vehicle];
					[group _x,_assignedVehicles] call AIC_fnc_setGroupAssignedVehicles;
				};
			};
		} forEach (crew _vehicle);
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	hint ((str count _unloadedGroups) + " other group(s) unloaded");
};

["Unload Other Group(s)",[],AIC_fnc_unloadOtherGroupsActionHandler,[],"NONE",{
	params ["_group"];
	_group getVariable ["AIC_Has_Group_Cargo",false];
}] call AIC_fnc_addCommandMenuAction;	

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


AIC_fnc_landActionHandler = {
	params ["_group","_groupControlId","_selectedPosition"];
	if(count _selectedPosition > 0) then {
		_hasAir = false;
		{
			if(_x isKindOf "Air") then {
				_hasAir = true;
			};
		} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
		if(_hasAir) then {
			[_group] call AIC_fnc_disableAllWaypoints;	
			[_group, [_selectedPosition,false,"MOVE","{ if((vehicle _x) isKindOf 'Air') then { (vehicle this) land 'LAND'; }; } forEach (units (group this))"]] call AIC_fnc_addWaypoint;
			[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
		};
	};
};

["Land",[],AIC_fnc_landActionHandler,[],"POSITION",{
	params ["_group"];
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			if(((position _x) select 2) > 1) then {
				_hasAir = true;
			};
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;



if(hasInterface) then {
		
	AIC_fnc_commandControlDrawHandler = {
	
		//_temp = diag_tickTime;
		
		private ["_commandControls","_inputControls","_actionControlShown"];
		
		_commandControls = AIC_fnc_getCommandControls();
		_inputControls = AIC_fnc_getInputControls();
		
		// Draw all visible input controls
		{
			if(AIC_fnc_getMapElementVisible(_x)) then {
				[_x] call AIC_fnc_drawInputControl;
			};
		} forEach _inputControls;
		
		// Draw command controls
		
		{
			// Move all command controls to the background if an action control is visible
		
			/*
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
			*/
			
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
				if(side _x == resistance) then {
					["ALL_GUER",_x] call AIC_fnc_commandControlAddGroup;
				};
				if(side _x == civilian) then {
					["ALL_CIV",_x] call AIC_fnc_commandControlAddGroup;
				};
			} forEach allGroups;
			sleep 5;
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
			private ["_group","_groupControl","_lastWpRevision","_groupWaypoints","_groupControlWaypoints","_currentWpRevision","_groupControlWaypointArray","_wp","_goCodeWpFound","_wpType","_waitForCode","_wpActionScript"];
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
								if(count _x > 4) then {
									_wpActionScript = _x select 4;
								} else {
									_wpActionScript = "";
								};
								_wp = _group addWaypoint [_x select 1, 0];
								if(_wpType == "ALPHA" || _wpType == "BRAVO") then {
									_goCodeWpFound = true;
									_wp setWaypointStatements ["true", "[group this, "+str (_x select 0)+"] call AIC_fnc_disableWaypoint; [group this,'"+_wpType+"'] call AIC_fnc_waitForWaypointGoCode;"];
								} else {
									_wp setWaypointStatements ["true", "[group this, "+str (_x select 0)+"] call AIC_fnc_disableWaypoint;" + _wpActionScript];
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

