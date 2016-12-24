#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Initializes Command Menu Actions

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

AIC_fnc_addWaypointsActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	AIC_fnc_setGroupControlAddingWaypoints(_groupControlId,true);
};

["GROUP","Add Waypoints",[],AIC_fnc_addWaypointsActionHandler] call AIC_fnc_addCommandMenuAction;

AIC_fnc_setGroupColorActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_color"];
	[_group,_color] call AIC_fnc_setGroupColor;
	AIC_fnc_setGroupControlColor(_groupControlId,_color);
	[_groupControlId,"REFRESH_GROUP_ICON",[]] call AIC_fnc_groupControlEventHandler;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	[_groupControlId,"REFRESH_ACTIONS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("Color set to " + toLower (_color select 0));
};

["GROUP","Red",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_RED]] call AIC_fnc_addCommandMenuAction;
["GROUP","Blue",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_BLUE]] call AIC_fnc_addCommandMenuAction;
["GROUP","Green",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_GREEN]] call AIC_fnc_addCommandMenuAction;
["GROUP","Black",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_BLACK]] call AIC_fnc_addCommandMenuAction;
["GROUP","White",["Set Group Color"],AIC_fnc_setGroupColorActionHandler,[AIC_COLOR_WHITE]] call AIC_fnc_addCommandMenuAction;


AIC_fnc_setGroupBehaviourActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_mode"];
	[_group,_mode] remoteExec ["setBehaviour", leader _group]; 
	hint ("Behaviour set to " + toLower _mode);
};

["GROUP","Careless",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["CARELESS"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Safe",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["SAFE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Aware",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["AWARE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Combat",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["COMBAT"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Stealth",["Set Group Behaviour"],AIC_fnc_setGroupBehaviourActionHandler,["STEALTH"]] call AIC_fnc_addCommandMenuAction;

AIC_fnc_joinGroupActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	private ["_selectedGroup"];
	_selectedGroup = [_groupControlId] call AIC_fnc_selectGroupControlGroup;
	if(!isNull _selectedGroup) then {
		(units _group) joinSilent _selectedGroup;
		hint ("Selected Group Joined");
	} else {
		hint ("No Group Selected");
	};
};

["GROUP","Join A Group",["Group Size"],AIC_fnc_joinGroupActionHandler,[]] call AIC_fnc_addCommandMenuAction;

AIC_fnc_splitGroupHalfActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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

["GROUP","In Half",["Group Size","Split Group"],AIC_fnc_splitGroupHalfActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	count units _group > 1;
}] call AIC_fnc_addCommandMenuAction;

AIC_fnc_splitGroupUnitsActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	
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

["GROUP","Into Individual Units",["Group Size","Split Group"],AIC_fnc_splitGroupUnitsActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	count units _group > 1;
}] call AIC_fnc_addCommandMenuAction;
	
AIC_fnc_setGroupSpeedActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_speed","_label"];
	[_group,_speed] remoteExec ["setSpeedMode", leader _group]; 
	hint ("Speed set to " + _label);
};	
		
["GROUP","Half Speed",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["LIMITED", "Half Speed"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Full Speed (In Formation)",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["NORMAL", "Full Speed (In Formation)"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Full (No Formation)",["Set Group Speed"],AIC_fnc_setGroupSpeedActionHandler,["FULL", "Full (No Formation)"]] call AIC_fnc_addCommandMenuAction;	

AIC_fnc_setFlyInHeightActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_height"];
	{
		if(_x isKindOf "Air") then {
			[_x,_height] remoteExec ["flyInHeight", _x]; 
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	hint ("Fly in height set to " + (str _height) + " meters");
};

["GROUP","500 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[500],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","250 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[250],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","100 meters (default)",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[100],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","50 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[50],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","40 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[40],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","30 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[30],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

["GROUP","20 meters",["Set Fly in Height"],AIC_fnc_setFlyInHeightActionHandler,[20],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Air") then {
			_hasAir = true;
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir;	
}] call AIC_fnc_addCommandMenuAction;

AIC_fnc_setGroupCombatModeActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_mode","_modeLabel"];
	[_group,_mode] remoteExec ["setCombatMode", leader _group]; 
	hint ("Combat mode set to " + toLower _modeLabel);
};

["GROUP","Never fire",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["BLUE","Never fire"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Hold fire - defend only",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["GREEN","Hold fire - defend only"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Hold fire, engage at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["WHITE","Hold fire, engage at will"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Fire at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["YELLOW","Fire at will"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Fire at will, engage at will",["Set Group Combat Mode"],AIC_fnc_setGroupCombatModeActionHandler,["RED","Fire at will, engage at will"]] call AIC_fnc_addCommandMenuAction;
		
AIC_fnc_clearAllWaypointsActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	[_group] call AIC_fnc_disableAllWaypoints;	
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("All waypoints cleared");
};

["GROUP","Confirm Cancel All",["Clear All Waypoints"],AIC_fnc_clearAllWaypointsActionHandler] call AIC_fnc_addCommandMenuAction;		

AIC_fnc_remoteControlActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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

["GROUP","Remote Control",[],AIC_fnc_remoteControlActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	private ["_selectedVehicle"];
	_selectedVehicle = [_groupControlId] call AIC_fnc_selectGroupControlVehicle;
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

["GROUP","Assign Vehicle",[],AIC_fnc_assignVehicleActionHandler,[]] call AIC_fnc_addCommandMenuAction;		

AIC_fnc_unassignVehicleActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	{
		[_group,_x] remoteExec ["leaveVehicle", leader _group];
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	[_group,nil] call AIC_fnc_setGroupAssignedVehicles;
	hint ("All vehicles unassigned");
};

["GROUP","Unassign All Vehicle(s)",[],AIC_fnc_unassignVehicleActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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

["GROUP","Unload Other Group(s)",[],AIC_fnc_unloadOtherGroupsActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_group getVariable ["AIC_Has_Group_Cargo",false];
}] call AIC_fnc_addCommandMenuAction;	




AIC_fnc_landActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	private ["_selectedPosition"];
	_selectedPosition = [_groupControlId] call AIC_fnc_selectGroupControlPosition;
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

["GROUP","Land",[],AIC_fnc_landActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
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


AIC_fnc_rappelActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	private ["_selectedPosition"];
	_selectedPosition = [_groupControlId] call AIC_fnc_selectGroupControlPosition;
	if(count _selectedPosition > 0) then {
		{
			if(_x isKindOf "Helicopter") then {
				[_x,25,AGLtoASL [_selectedPosition select 0, _selectedPosition select 1, 0]] call AR_Rappel_All_Cargo;
			};
		} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
		[_group] spawn {
			params ["_groupRappelling"];
			_unitsInVehicle = true;
			while {_unitsInVehicle} do {
				_unitsInVehicle = false;
				{
					if(vehicle _x != _x) then {
						_unitsInVehicle = true;
					};
				} forEach (units _groupRappelling);
				sleep 1;
			};
			[_groupRappelling] call AIC_fnc_unassignVehicleActionHandler;
		};
	};
};

["GROUP","Rappel Other Group(s)",[],AIC_fnc_rappelActionHandler,[],{
	params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_hasAir = false;
	{
		if(_x isKindOf "Helicopter") then {
			if(((position _x) select 2) > 1) then {
				_hasAir = true;
			};
		};
	} forEach ([_group] call AIC_fnc_getGroupAssignedVehicles);
	_hasAir && (_group getVariable ["AIC_Has_Group_Cargo",false]) && !isNil "AR_RAPPELLING_INIT";	
}] call AIC_fnc_addCommandMenuAction;


AIC_fnc_setGroupFormationActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_mode"];
	[_group,_mode] remoteExec ["setFormation", leader _group]; 
	hint ("Formation set to " + toLower _mode);
};

["GROUP","Column",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["COLUMN"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Stag. Column",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["STAG COLUMN"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Wedge",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["WEDGE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Echelon Left",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["ECH LEFT"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Echelon Right",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["ECH RIGHT"]] call AIC_fnc_addCommandMenuAction;
["GROUP","V",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["VEE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Line",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["LINE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","File",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["FILE"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Diamond",["Set Group Formation"],AIC_fnc_setGroupFormationActionHandler,["DIAMOND"]] call AIC_fnc_addCommandMenuAction;

AIC_fnc_setGroupAutoCombatActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_actionParams params ["_mode"];
	if (_mode == "On") then {
		{_x enableAI "AUTOCOMBAT"} foreach (units _group);
	} else {
		{_x disableAI "AUTOCOMBAT"} foreach (units _group);
	};
	hint ("AutoCombat " + toLower _mode);
};

["GROUP","On",["Toggle AutoCombat"],AIC_fnc_setGroupAutoCombatActionHandler,["On"]] call AIC_fnc_addCommandMenuAction;
["GROUP","Off",["Toggle AutoCombat"],AIC_fnc_setGroupAutoCombatActionHandler,["Off"]] call AIC_fnc_addCommandMenuAction;

AIC_fnc_deleteWaypointHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId","_waypointId"];
	private ["_group"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	[_group,_waypointId] call AIC_fnc_disableWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
};

["WAYPOINT","Delete Waypoint",[],AIC_fnc_deleteWaypointHandler] call AIC_fnc_addCommandMenuAction;

AIC_fnc_setWaypointFormationActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId","_waypointId"];
	private ["_group","_waypoint"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_actionParams params ["_mode"];
	_waypoint set [7,_mode];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("Formation set to " + toLower _mode);
};

["WAYPOINT","Column",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["COLUMN"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Stag. Column",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["STAG COLUMN"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Wedge",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["WEDGE"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Echelon Left",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["ECH LEFT"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Echelon Right",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["ECH RIGHT"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","V",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["VEE"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Line",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["LINE"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","File",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["FILE"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Diamond",["Set Group Formation"],AIC_fnc_setWaypointFormationActionHandler,["DIAMOND"]] call AIC_fnc_addCommandMenuAction;
								
AIC_fnc_setWaypointTypeActionHandler = {
	params ["_menuParams","_actionParams"];
	_menuParams params ["_groupControlId","_waypointId"];
	private ["_group","_waypoint"];
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
	_actionParams params ["_mode","_label"];
	_waypoint set [3,_mode];
	[_group, _waypoint] call AIC_fnc_setWaypoint;
	[_groupControlId,"REFRESH_WAYPOINTS",[]] call AIC_fnc_groupControlEventHandler;
	hint ("Type set to " + toLower _label);
};

["WAYPOINT","Move (default)",["Set Waypoint Type"],AIC_fnc_setWaypointTypeActionHandler,["MOVE","Move"]] call AIC_fnc_addCommandMenuAction;
["WAYPOINT","Seek & Destroy",["Set Waypoint Type"],AIC_fnc_setWaypointTypeActionHandler,["SAD","Seek & Destroy"]] call AIC_fnc_addCommandMenuAction;
