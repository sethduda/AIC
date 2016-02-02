#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Get actions assigned to a group

	Parameter(s):
	_this select 0: GROUP - group to get actions

	Returns: 
	ARRAY - [
		NUMBER - Revision,
		ARRAY - [
			ARRAY: [
				STRING - Action Type,
				ARRAY - Action Params
			], ...
		]
	]
*/

private ["_group"];
_group = param [0];
(_group getVariable ["AIC_Actions",[0,[]]]);
