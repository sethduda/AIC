#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Draws the specified map icon on the map

	Parameter(s):
	_this select 0: STRING - Icon ID
	_this select 1: POSITION - World position of icon ([X,Y])
	_this select 2: BOOLEAN - Is in foreground (alpha will be reduced by 50% if in background), (optional, default true)
		
	Returns: 
	Nothing
*/
private ["_iconProperties"];
_iconProperties = AIC_fnc_getMapIconProperties(param [0]);
if((param [2,true])) then {
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
	_color = [_color select 0, _color select 1, _color select 2, (_color select 3) * 0.5];
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