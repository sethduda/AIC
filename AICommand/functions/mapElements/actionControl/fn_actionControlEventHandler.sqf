#include "functions.h"
#include "..\..\properties.h"
#include "..\commandControl\functions.h"
#include "..\interactiveIcon\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for a action control

	Parameter(s):
	_this select 0: STRING - Action control id
	_this select 1: STRING - Event
	_this select 2: ANY - Params

	Returns: 
	Nothing
*/

private ["_actionControlId","_event","_params"];

_actionControlId = param [0,nil];
_event = param [1];
_params = param [2,[]];

if(isNil "_actionControlId") then {
	
} else {
	
	private ["_actionType","_actionParameters"];
	
	_actionType = AIC_fnc_getActionControlType(_actionControlId);
	_actionParameters = AIC_fnc_getActionControlParameters(_actionControlId);

	if(_actionType == "ASSIGN_GROUP_VEHICLE") then {

		private ["_groupControlId"];
		
		_groupControlId = _actionParameters select 0;
	
		if( _event == "VEHICLE_SELECTED" ) then {
			private ["_vehicle"];
			_vehicle = _params select 1;
			[_groupControlId, "ASSIGN_VEHICLE_SELECTED", [_vehicle]] spawn AIC_fnc_groupControlEventHandler;
			[_actionControlId] call AIC_fnc_deleteMapElement;
		};
	};

};

