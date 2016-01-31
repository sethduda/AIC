#include "..\..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for the group vehicle assignment action

	Parameter(s):
	None
		
	Returns: 
	Nothing
*/

if(isDedicated || !hasInterface) exitWith {};

// Detects and issues events when the vehicles are entered

[] spawn {
	private ["_allActions","_group","_vehicleIcons","_vehiclesEntered","_vehicle"];
	while {true} do {
		_allActions = AIC_fnc_getGroupVehicleAssignmentActions();
		{
			_group = AIC_fnc_getGroupVehicleAssignmentActionGroup(_x);
			_vehicleIcons = AIC_fnc_getGroupVehicleAssignmentActionVehicleIcons(_x);
			_vehiclesEntered = [];
			{
				_vehicle = _x select 0;
				_vehicleEntered = false;
				{
					if( _x in _vehicle) then {
						_vehicleEntered = true;
					};
				} forEach (units _group);
				if(_vehicleEntered) then {
					_vehiclesEntered pushBack _vehicle;
				};
			} forEach _vehicleIcons;
			if(count _vehiclesEntered > 0) then {
				[_x, "VEHICLES_ENTERED",[_vehiclesEntered]] call AIC_fnc_GroupVehicleAssignmentActionEventHandler;
			};
		} forEach _allActions;
		sleep 2;
	};
};


