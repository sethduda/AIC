#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates an input control

	Parameter(s):
	_this select 0: STRING - Input Type
	_this select 1: ARRAY - Parameters (optional)
	
	Returns: 
	STRING - Input Control ID
*/

private ["_inputType","_parameters"];

_inputType = param [0];
_parameters = param [1,[]];

private ["_inputControlId","_inputControls"];

_inputControlId = [false,true] call AIC_fnc_createMapElement;

AIC_fnc_setInputControlType(_inputControlId,_inputType);
AIC_fnc_setInputControlParameters(_inputControlId,_parameters);

_inputControls = AIC_fnc_getInputControls();
_inputControls pushBack _inputControlId;
AIC_fnc_setInputControls(_inputControls);

if(_inputType == "VEHICLE") then {

	private ["_groupControlId", "_group", "_groupPosition", "_nearVehicles","_nearIcon","_nearVehicleIcons","_eventHandlerScript","_params","_color"];
	
	_groupControlId = _parameters select 0;
	_group = AIC_fnc_getGroupControlGroup(_groupControlId);
	_groupPosition = position (leader _group);
	_nearVehicles = nearestObjects [_groupPosition, ["LandVehicle","Boat","Air"], 300];
	_color = AIC_fnc_getGroupControlColor(_groupControlId);
	
	_eventHandlerScript = {
		private ["_event","_inputControlId","_vehicleAndIconParams"];
		_event = param [1];
		_inputControlId = (param [3]) select 0;
		_vehicleAndIconParams = (param [3]) select 1;
		[_inputControlId, "VEHICLE_" + _event, _vehicleAndIconParams] spawn AIC_fnc_inputControlEventHandler;
	};
	
	_nearVehicleIcons = [];
	{
		//if({alive _x} count crew _x == 0) then {
			_nearIcon = [_x,_color] call AIC_fnc_createVehicleInteractiveIcon;
			[_inputControlId,_nearIcon] call AIC_fnc_addMapElementChild;
			AIC_fnc_setInteractiveIconEventHandlerScript(_nearIcon,_eventHandlerScript);
			_params = [_inputControlId,[_nearIcon,_x]];
			AIC_fnc_setInteractiveIconEventHandlerScriptParams(_nearIcon,_params);
			_nearVehicleIcons pushBack [_nearIcon,_x];
		//};
	} forEach _nearVehicles;

	AIC_fnc_setInputControlData(_inputControlId,[_nearVehicleIcons]);
	
};

_inputControlId;