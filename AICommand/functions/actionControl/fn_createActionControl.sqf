#include "functions.h"
#include "..\interactiveIcon\functions.h"
#include "..\groupControl\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates an action control

	Parameter(s):
	_this select 0: STRING - Action Type
	_this select 1: ARRAY - Parameters (optional)
	
	Returns: 
	STRING - Action Control ID
*/

private ["_actionType","_parameters"];

_actionType = param [0];
_parameters = param [1,[]];

private ["_actionControlCount","_actionControlId","_actionControls"];

_actionControlCount = AIC_fnc_getActionControlCount();
_actionControlId = str _actionControlCount;
AIC_fnc_setActionControlCount(_actionControlCount + 1);

AIC_fnc_setActionControlType(_actionControlId,_actionType);
AIC_fnc_setActionControlParameters(_actionControlId,_parameters);

_actionControls = AIC_fnc_getActionControls();
_actionControls pushBack _actionControlId;
AIC_fnc_setActionControls(_actionControls);

if(_actionType == "ASSIGN_GROUP_VEHICLE") then {

	private ["_groupControlId", "_group", "_groupPosition", "_nearVehicles","_nearIcon","_nearVehicleIcons","_eventHandlerScript","_params"];
	
	_groupControlId = _parameters select 0;
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_groupPosition = position (leader _group);
	_nearVehicles = nearestObjects [_groupPosition, ["LandVehicle","Boat","Air"], 300];
	
	_eventHandlerScript = {
		private ["_event","_actionControlId","_vehicleAndIconParams"];
		_event = param [1];
		_actionControlId = (param [3]) select 0;
		_vehicleAndIconParams = (param [3]) select 1;
		[_actionControlId, "VEHICLE_" + _event, _vehicleAndIconParams] spawn AIC_fnc_actionControlEventHandler;
	};
	
	_nearVehicleIcons = [];
	{
		if({alive _x} count crew _x == 0) then {
			_nearIcon = [_x] call AIC_fnc_getVehicleInteractiveIcon;
			AIC_fnc_setInteractiveIconShown(_nearIcon, false);
			AIC_fnc_setInteractiveIconEventHandlerScript(_nearIcon,_eventHandlerScript);
			_params = [_actionControlId,[_nearIcon,_x]];
			AIC_fnc_setInteractiveIconEventHandlerScriptParams(_nearIcon,_params);
			_nearVehicleIcons pushBack [_nearIcon,_x];
		};
	} forEach _nearVehicles;

	AIC_fnc_setActionControlData(_actionControlId,[_nearVehicleIcons]);
	
};

if(_actionType == "ASSIGN_WAYPOINT_VEHICLE") then {
	/*private ["_groupControlId", "_waypointId", "_group", "_groupPosition", "_nearVehicles","_nearIcon","_nearVehicleIcons"];
	_groupControlId = _parameters select 0;
	_waypointId = _parameters select 1;
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_groupPosition = position (leader _group);
	_nearVehicles = nearestObjects [_groupPosition, ["LandVehicle","Boat","Air"], 300];
	_nearVehicleIcons = [];
	{
		_nearIcon = [_x] call AIC_fnc_getVehicleInteractiveIcon;
		AIC_fnc_setInteractiveIconShown(_nearIcon, false);
		_nearVehicleIcons pushBack [_nearIcon,_x];
	} forEach _nearVehicles;
	AIC_fnc_setActionControlData(_actionControlId,[_nearVehicleIcons]);*/
};

_actionControlId;