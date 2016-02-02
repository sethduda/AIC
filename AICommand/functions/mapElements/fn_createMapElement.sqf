#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	
	Creates a new map element. A map element is an abstract representation of something that can can be drawn on a map and handle UI events.
	Map elements can be organized into a hierarchy. When in a hierarchy, the removal of visibility or event handling will override all
	child elements.
	
	For example, a group control is a the parent element for one or more interactive icon elements. If you disable visibility of the group control element,
	all child interactive icon elements will also have visibility disabled. However, if the group control element is visible, visbility of child elements
	is owned and controlled by the child.
	
	Parameter(s):
	_this select 1: BOOLEAN - Is Visible (optional, default: true)
	_this select 2: BOOLEAN - Are Events Enabled (optional, default: true)
	_this select 3: BOOLEAN - Is In Foreground (optional, default: true)
	_this select 4: STRING - Predefined Element Id (optional, must be unique)
		
	Returns: 
	STRING - Element Id
	
*/

private ["_isVisible","_eventsEnabled","_isInForeground","_elementId"];

_isVisible = param [0,true];
_eventsEnabled = param [1,true];
_isInForeground = param [2,true];
_elementId = param [3,nil];

if(isNil "_elementId") then {
	_elementCount = AIC_fnc_getMapElementCount();
	_elementId = str _elementCount;
	AIC_fnc_setMapElementCount(_elementCount + 1);
};

[_elementId,_isVisible] call AIC_fnc_setMapElementVisible;
[_elementId,_eventsEnabled] call AIC_fnc_setMapElementEnabled;
[_elementId,_isInForeground] call AIC_fnc_setMapElementForeground;

_elementId;