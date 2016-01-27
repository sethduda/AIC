#include "functions.h"
#include "..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified map icon on the map

	Parameter(s):
	_this select 0: STRING - Icon ID
	_this select 1: POSITION - World position of icon ([X,Y])
		
	Returns: 
	Nothing
*/
private ["_iconProperties"];
_iconProperties = AIC_fnc_getMapIconProperties(param [0]);
AIC_MAP_CONTROL drawIcon [
	_iconProperties select 0,
	_iconProperties select 6,
	param [1],
	_iconProperties select 1,
	_iconProperties select 2,
	0,
	'',
	_iconProperties select 5
];