#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Shows the group waypoint command menu
	
	Parameter(s):
	_this select 0: STRING - Group control id
	_this select 1: NUMBER - Waypoint id
		
	Returns: 
	Nothing
*/

params ["_groupControlId","_waypointId"];	

["WAYPOINT",[_groupControlId,_waypointId]] call AIC_fnc_showCommandMenu;