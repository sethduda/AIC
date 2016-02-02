#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Interactive icon event handler

	Parameter(s):
	_this select 0: STRING - Event name
	_this select 1: ANY - Event params
		
	Returns: 
	Nothing
*/

private ["_event","_eventParams"];

_event = param [0];
_eventParams = param [1];

private ["_selectedIcon","_overIcon","_pickedUpIcon","_mouseButtonDownIcon"];

_selectedIcon = missionNamespace getVariable ["AIC_Interactive_Icon_Selected_Icon",nil];
_overIcon = missionNamespace getVariable ["AIC_Interactive_Icon_Over_Icon",nil];
_pickedUpIcon = missionNamespace getVariable ["AIC_Interactive_Icon_Picked_Up_Icon",nil];
_mouseButtonDownIcon = missionNamespace getVariable ["AIC_Interactive_Icon_Mouse_Button_Down_Icon",nil];

// Clear icon variables if the icons aren't currently shown

if(!isNil "_selectedIcon") then {
	if!(AIC_fnc_getMapElementVisible(_selectedIcon)) then {
		AIC_Interactive_Icon_Selected_Icon = nil;
		_selectedIcon = nil;
	};
};

if(!isNil "_overIcon") then {
	if!(AIC_fnc_getMapElementVisible(_overIcon)) then {
		AIC_Interactive_Icon_Over_Icon = nil;
		_overIcon = nil;
	};
};

if(!isNil "_pickedUpIcon") then {
	if!(AIC_fnc_getMapElementVisible(_pickedUpIcon)) then {
		AIC_Interactive_Icon_Picked_Up_Icon = nil;
		_pickedUpIcon = nil;
	};
};

if(!isNil "_mouseButtonDownIcon") then {
	if!(AIC_fnc_getMapElementVisible(_mouseButtonDownIcon)) then {
		AIC_Interactive_Icon_Mouse_Button_Down_Icon = nil;
		_mouseButtonDownIcon = nil;
	};
};

// Event Handlers

if(_event == "KeyDownDisplay") then {
	// Produces KEY_DOWN_XXX events for the interactive icon the mouse is over
	if(!isNil "_overIcon") then {
		[_overIcon,"KEY_DOWN_" + (str (_eventParams select 1))] call AIC_fnc_handleInteractiveIconEvent;
	};
};

//MouseHolding or MouseMoving
if(_event == "MouseHolding" || _event == "MouseMoving") then {

	private ["_mouseButtonDown","_mouseButtonDownTime"];
	
	_mouseButtonDown = missionNamespace getVariable ["AIC_Interactive_Icon_Mouse_Button_Down",true];
	_mouseButtonDownTime = diag_tickTime - (missionNamespace getVariable ["AIC_Interactive_Icon_Mouse_Button_Down_Start_Time",diag_tickTime]);

	private ["_mouseMapPositionX","_mouseMapPositionY","_interactiveIconsByMapPosition","_interactiveIconsOver","_interactiveIconsNotOver"];

	_mouseMapPositionX = _eventParams select 1;
	_mouseMapPositionY = _eventParams select 2;
	
	_interactiveIconsByMapPosition = [_mouseMapPositionX,_mouseMapPositionY] call AIC_fnc_getInteractiveIconsByMapPosition;
	_interactiveIconsOver = _interactiveIconsByMapPosition select 0;
	_interactiveIconsNotOver = _interactiveIconsByMapPosition select 1;
	
	private ["_iconState"];
		
	if(_mouseButtonDown && _mouseButtonDownTime >= 0.15 && isNil "_pickedUpIcon" && !isNil "_mouseButtonDownIcon") then {
		
		{
			AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
		} forEach (_interactiveIconsNotOver+_interactiveIconsOver-[_mouseButtonDownIcon]);

		AIC_fnc_setInteractiveIconState(_mouseButtonDownIcon,"SELECTED");
		[_mouseButtonDownIcon,"SELECTED"] call AIC_fnc_handleInteractiveIconEvent;
		AIC_Interactive_Icon_Selected_Icon = _mouseButtonDownIcon;
		AIC_fnc_setInteractiveIconState(_mouseButtonDownIcon,"PICKEDUP");
		[_mouseButtonDownIcon,"PICKEDUP"] call AIC_fnc_handleInteractiveIconEvent;
		AIC_Interactive_Icon_Picked_Up_Icon = _mouseButtonDownIcon;
		
	} else {
	
		if(!isNil "_pickedUpIcon") then {
			private ["_mouseWorldPosition"];
			_mouseWorldPosition = AIC_MAP_CONTROL ctrlMapScreenToWorld [_mouseMapPositionX,_mouseMapPositionY];
			AIC_fnc_setInteractiveIconPosition(_pickedUpIcon,_mouseWorldPosition);		
		} else {	
			AIC_Interactive_Icon_Over_Icon = nil;
			{
				if(isNil "_selectedIcon") then {
					AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
				} else {
					if(_selectedIcon != _x) then {
						AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
					};
				};
			} forEach _interactiveIconsNotOver;
			{
				if(isNil "_selectedIcon") then {
					AIC_fnc_setInteractiveIconState(_x,"MOUSEOVER");
				} else {
					if(_selectedIcon != _x) then {
						AIC_fnc_setInteractiveIconState(_x,"MOUSEOVER");
					};
				};					
				AIC_Interactive_Icon_Over_Icon = _x;
			} forEach _interactiveIconsOver;
		};
		
	};
	
};

// Left Mouse Button Down
if(_event == "MouseButtonDown" && (_eventParams select 1) == 0) then {

	private ["_mouseMapPositionX","_mouseMapPositionY","_interactiveIconsOver","_interactiveIconsByMapPosition"];
	
	_mouseMapPositionX = _eventParams select 2;
	_mouseMapPositionY = _eventParams select 3;
	_interactiveIconsByMapPosition = [_mouseMapPositionX,_mouseMapPositionY] call AIC_fnc_getInteractiveIconsByMapPosition;
	_interactiveIconsOver = _interactiveIconsByMapPosition select 0;
	
	{	
		AIC_Interactive_Icon_Mouse_Button_Down_Icon = _x;
		AIC_Interactive_Icon_Mouse_Button_Down = true;
		AIC_Interactive_Icon_Mouse_Button_Down_Start_Time = diag_tickTime;	
	} forEach _interactiveIconsOver;

};

// Left Mouse Button Up
if(_event == "MouseButtonUp" && (_eventParams select 1) == 0) then {

	private ["_mouseMapPositionX","_mouseMapPositionY"];

	_mouseMapPositionX = _eventParams select 2;
	_mouseMapPositionY = _eventParams select 3;
	
	if(!isNil "_pickedUpIcon") then {
		
		// User dropped picked up icon
		
		private ["_mouseWorldPosition"];
		_mouseWorldPosition = AIC_MAP_CONTROL ctrlMapScreenToWorld [_mouseMapPositionX,_mouseMapPositionY];
		AIC_fnc_setInteractiveIconPosition(_pickedUpIcon,_mouseWorldPosition);
		AIC_fnc_setInteractiveIconState(_pickedUpIcon,"SELECTED");
		[_pickedUpIcon,"SELECTED"] call AIC_fnc_handleInteractiveIconEvent;
		AIC_Interactive_Icon_Picked_Up_Icon = nil;
		AIC_Interactive_Icon_Selected_Icon = _pickedUpIcon;
		
		// Execute event handler
		[_pickedUpIcon,"DROPPED",[_mouseWorldPosition]] call AIC_fnc_handleInteractiveIconEvent;
		
	} else {

		_interactiveIconsByMapPosition = [_mouseMapPositionX,_mouseMapPositionY] call AIC_fnc_getInteractiveIconsByMapPosition;
		_interactiveIconsOver = _interactiveIconsByMapPosition select 0;
		_interactiveIconsNotOver = _interactiveIconsByMapPosition select 1;
		AIC_Interactive_Icon_Selected_Icon = nil;
		
		{
			AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
		} forEach _interactiveIconsNotOver;
		
		{
			if(!isNil "_mouseButtonDownIcon" && _mouseButtonDownIcon == _x) then {
				AIC_fnc_setInteractiveIconState(_x,"SELECTED");
				[_x,"SELECTED"] call AIC_fnc_handleInteractiveIconEvent;
				AIC_Interactive_Icon_Selected_Icon = _x;
			} else {
				AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
			};
		} forEach _interactiveIconsOver;

	};
	
	AIC_Interactive_Icon_Mouse_Button_Down = false;
	AIC_Interactive_Icon_Mouse_Button_Down_Icon = nil;	
	
};

// Right Mouse Button Click
if(_event == "MouseButtonClick" && (_eventParams select 1) == 1) then {
	private ["_interactiveIcons"];
	if(isNil "_pickedUpIcon") then {
		hint "";
		_interactiveIcons = AIC_fnc_getInteractiveIcons();
		{
			AIC_fnc_setInteractiveIconState(_x,"UNSELECTED");
		} forEach _interactiveIcons;
		AIC_Interactive_Icon_Selected_Icon = nil;
	};
};
