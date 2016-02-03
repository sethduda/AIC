#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Get vehicles a group is assigned to 
	
	Parameter(s):
	_this select 0: GROUP - group

	Returns: 
	ARRAY - [
		OBJECT - Vehicle, 
		...
	]
	
*/
private ["_group"];
_group = param [0];
_group getVariable ["AIC_Assigned_Vehicles",[]];