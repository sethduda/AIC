#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Shows the group command menu
	
	Parameter(s):
	_this select 0: STRING - Group control id
		
	Returns: 
	Nothing
*/

params ["_groupControlId"];	

["GROUP",[_groupControlId]] call AIC_fnc_showCommandMenu;