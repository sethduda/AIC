#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Set actions assigned to a group

	Parameter(s):
	_this select 0: GROUP - group to get actions
	_this select 1: ARRAY - [
		ARRAY - [
			STRING - Action Type,
			ARRAY - Action Params
		], ...
	]

	Returns: 
	Nothing
	
*/

private ["_group","_newActions"];

_group = param [0];
_newActions = param [1];

private ["_actions","_revision"];

_actions = _group getVariable ["AIC_Actions",[0,[]]];
_revision = _actions select 0;

_revision = _revision + 1;

_group setVariable ["AIC_Actions",[_revision,_newActions], true];