#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Adds a group to the specified command control

	Parameter(s):
	_this select 0: STRING - command control id
	_this select 1: GROUP - group to add

	Returns: 
	Nothing
*/

private ["_commandId","_group"];

_commandId = param [0];
_group = param [1];

private ["_groupsUnderCommand","_unitsAlive"];

_unitsAliveAcount = ({alive _x} count units _group);

if(_unitsAliveAcount == 0) exitWith {};

_groupsUnderCommand = AIC_fnc_getCommandControlGroups(_commandId);
if!(_group in _groupsUnderCommand) then {

	_groupsUnderCommand pushBack _group;
	AIC_fnc_setCommandControlGroups(_commandId,_groupsUnderCommand);
	
	// Construct initial set of waypoints for group if they're not already created (for testing purposes)
	/*
	_allWaypoints = [_group] call AIC_fnc_getAllWaypoints;
	_revision = _allWaypoints select 0;
	if(_revision == 0) then {
		{
			if( _x select 1 > 0) then {
				[_group, [getWPPos _x, false,"MOVE"]] call AIC_fnc_addWaypoint;
			};
		} forEach waypoints _group;
	};
	*/
	
};


