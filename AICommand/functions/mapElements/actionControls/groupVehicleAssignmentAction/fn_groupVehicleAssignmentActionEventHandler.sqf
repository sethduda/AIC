#include "..\..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for group vehicle assignment actions

	Parameter(s):
	_this select 0: STRING - Map element id
	_this select 1: STRING - Event
	_this select 2: ANY - Params

	Returns: 
	Nothing
*/

private ["_mapElementId","_event","_params"];

_mapElementId = param [0,nil];
_event = param [1];
_params = param [2,[]];

if(isNil "_mapElementId") then {

} else {

	if(_event == "VEHICLES_ENTERED") then {
		private ["_vehicles","_vehicleIcons","_newVehicleIcons"];
		_vehicles = _params select 0;
		_vehicleIcons = AIC_fnc_getGroupVehicleAssignmentActionVehicleIcons(_mapElementId);
		_newVehicleIcons = [];
		{
			if!(_x select 0 in _vehicles) then {
				_newVehicleIcons pushBack _x;
			} else {
				[_x select 1] call AIC_fnc_deleteMapElement;
			};
		} forEach _vehicleIcons;
		AIC_fnc_setGroupVehicleAssignmentActionVehicleIcons(_mapElementId,_newVehicleIcons);
	};
	
};

