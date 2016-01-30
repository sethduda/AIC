#include "functions.h"
#include "..\properties.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified map icon on the map

	Parameter(s):
	_this select 0: STRING - Icon ID
	_this select 1: POSITION - World position of icon ([X,Y])
	_this select 2: NUMBER - Alpha (Optional - if set, this alpha value will be used for all drawing actions. If set to -1, alpha will not be changed)
		
	Returns: 
	Nothing
*/
private ["_iconProperties"];
_iconProperties = AIC_fnc_getMapIconProperties(param [0]);
if((param [2,-1]) < 0) then {
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
} else {
	private ["_color"];
	_color = _iconProperties select 6;
	_color = [_color select 0, _color select 1, _color select 2, _alpha];
	AIC_MAP_CONTROL drawIcon [
		_iconProperties select 0,
		_color,
		param [1],
		_iconProperties select 1,
		_iconProperties select 2,
		0,
		'',
		_iconProperties select 5
	];
};