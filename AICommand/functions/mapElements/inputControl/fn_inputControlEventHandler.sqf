#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Handles events for a input control

	Parameter(s):
	_this select 0: STRING - Input control id
	_this select 1: STRING - Event
	_this select 2: ANY - Params

	Returns: 
	Nothing
*/

private ["_inputControlId","_event","_params"];

_inputControlId = param [0,nil];
_event = param [1];
_params = param [2,[]];

if(isNil "_inputControlId") then {


	if(_event == "MouseButtonDown") then {
		private ["_inputControls"];
		_inputControls = AIC_fnc_getInputControls();
		{
			if((AIC_fnc_getMapElementVisible(_x)) && (AIC_fnc_getMapElementEnabled(_x))) then {
				if(_params select 1 == 1) then {			
					[_x,"RIGHT_MOUSE_BUTTON_DOWN_MAP",[]] call AIC_fnc_inputControlEventHandler;
				} else {
					[_x,"LEFT_MOUSE_BUTTON_DOWN_MAP",[]] call AIC_fnc_inputControlEventHandler;
				};		
			};
		} forEach _inputControls;
	};
	
	
	if(_event == "MouseButtonClick") then {
		private ["_inputControls"];
		_inputControls = AIC_fnc_getInputControls();
		{
			if((AIC_fnc_getMapElementVisible(_x)) && (AIC_fnc_getMapElementEnabled(_x))) then {
				if(_params select 1 == 1) then {			
					[_x,"RIGHT_MOUSE_BUTTON_CLICK_MAP",[]] call AIC_fnc_inputControlEventHandler;
				} else {
					[_x,"LEFT_MOUSE_BUTTON_CLICK_MAP",[]] call AIC_fnc_inputControlEventHandler;
				};		
			};
		} forEach _inputControls;
	};
	
} else {
	
	private ["_inputType","_inputParameters"];
	
	_inputType = AIC_fnc_getInputControlType(_inputControlId);
	_inputParameters = AIC_fnc_getInputControlParameters(_inputControlId);


	
	if(_inputType == "POSITION") then {
	
		if(_event == "RIGHT_MOUSE_BUTTON_CLICK_MAP") then {
			AIC_fnc_setInputControlOutput(_inputControlId,[]);
		};
		
		if(_event == "LEFT_MOUSE_BUTTON_CLICK_MAP") then {
			AIC_fnc_setInputControlOutput(_inputControlId,AIC_fnc_getMouseMapPosition());
		};
	};
	
	if(_inputType == "VEHICLE") then {
	
		if(_event == "RIGHT_MOUSE_BUTTON_CLICK_MAP") then {
			AIC_fnc_setInputControlOutput(_inputControlId,objNull);
		};

		private ["_groupControlId"];
		
		_groupControlId = _inputParameters select 0;
	
		if( _event == "VEHICLE_SELECTED" ) then {
			private ["_vehicle"];
			_vehicle = _params select 1;
			AIC_fnc_setInputControlOutput(_inputControlId,_vehicle);
		};
	};
	
	
	if(_inputType == "GROUP") then {
	
		if(_event == "RIGHT_MOUSE_BUTTON_CLICK_MAP") then {
			AIC_fnc_setInputControlOutput(_inputControlId,grpNull);
		};

		private ["_groupControlId"];
		
		_groupControlId = _inputParameters select 0;
	
		if( _event == "GROUP_SELECTED" ) then {
			private ["_group"];
			_group = _params select 1;
			AIC_fnc_setInputControlOutput(_inputControlId,_group);
		};
	};

};

