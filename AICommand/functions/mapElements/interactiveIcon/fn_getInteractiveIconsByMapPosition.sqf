#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets interactive icons based on a map position. Only returns up to 1 icon at position.

	Parameter(s):
	_this select 0: NUMBER -  Map x position
	_this select 1: NUMBER - Map y position
		
	Returns: 
	ARRAY - [
		ARRAY - Interactive icon ids at position
		ARRAY - Interactive icon ids not at position
	]
*/

private ["_mapPositionX","_mapPositionY","_iconAtPositionFound"];

_mapPositionX = param [0];
_mapPositionY = param [1];
_iconAtPositionFound = false;

private ["_interactiveIcons","_iconsAtPosition","_iconsNotAtPosition","_iconWorldPosition","_iconMapPosition"];
private ["_iconMapPositionX","_iconMapPositionY","_iconMapDimensions","_iconMapWidth","_iconMapHeight"];

_interactiveIcons = AIC_fnc_getInteractiveIcons();
_iconsAtPosition = [];
_iconsNotAtPosition = [];

{
	if((AIC_fnc_getMapElementVisible(_x)) && (AIC_fnc_getMapElementEnabled(_x))) then {
		_iconWorldPosition = AIC_fnc_getInteractiveIconPosition(_x);
		_iconMapPosition = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _iconWorldPosition;
		_iconMapPositionX = _iconMapPosition select 0;
		_iconMapPositionY = _iconMapPosition select 1;
		_iconMapDimensions = AIC_fnc_getInteractiveIconDimensions(_x);
		_iconMapWidth = _iconMapDimensions select 0;
		_iconMapHeight = _iconMapDimensions select 1;
		if(_iconAtPositionFound) then {
			_iconsNotAtPosition pushBack _x;
		} else {		
			if( (_mapPositionX < _iconMapPositionX + (_iconMapWidth/2)) && (_mapPositionX > _iconMapPositionX - (_iconMapWidth/2)) && (_mapPositionY < _iconMapPositionY + (_iconMapHeight/2)) && (_mapPositionY > _iconMapPositionY - (_iconMapHeight/2)) ) then {
				_iconsAtPosition pushBack _x;
				_iconAtPositionFound = true;
			} else {
				_iconsNotAtPosition pushBack _x;
			};
		};
	};
	
} forEach _interactiveIcons;

[_iconsAtPosition,_iconsNotAtPosition];
	