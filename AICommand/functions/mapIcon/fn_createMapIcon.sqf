#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates a new map icon that can be drawn on the map. Use AIC_fnc_drawMapIcon to draw on the map 
	once a map icon has been created.

	Parameter(s):
	_this select 0: STRING - Icon image path
		Note: You can reference images in mission using relative path (e.g. images/test.paa). Relative paths cannot begin with an underscore.
	_this select 1: NUMBER - Icon width in pixels
	_this select 2: NUMBER - Icon height in pixels
	_this select 3: NUMBER - Show icon shadow (1=true, 0=false) (optional, default 0)
	_this select 4: RGBA - Icon color (optional, default [-1,-1,-1,1])
		
	Returns: 
	STRING - Icon ID
*/

private ["_iconImage","_iconWidth","_iconHeight","_iconShadow","_iconColor"];

_iconImage = param [0];
_iconWidth = param [1];
_iconHeight = param [2];
_iconShadow = param [3,0];
_iconColor = param [4,[-1,-1,-1,1]];

// Append mission root directory if using a relative path
private ["_iconImageStartChar"];
_iconImageStartChar = toString [((toArray _iconImage) select 0)];
if(_iconImageStartChar != "/" && _iconImageStartChar != "\") then { 
	if(isNil "AIC_MISSION_ROOT") then {
		AIC_MISSION_ROOT = call {
			private "_arr";
			_arr = toArray __FILE__;
			_arr resize (count _arr - 48);
			toString _arr;
		};
	};
	_iconImage = AIC_MISSION_ROOT + _iconImage;
};

private ["_mapIconCount","_mapIconId","_iconMapWidth","_iconMapHeight","_iconParams"];

_mapIconCount = AIC_fnc_getMapIconCount();
_mapIconId = str _mapIconCount;
AIC_fnc_setMapIconCount(_mapIconCount + 1);

_iconMapWidth = safeZoneWAbs * (_iconWidth / (getResolution select 0));
_iconMapHeight = safeZoneH * (_iconHeight / (getResolution select 1)); 

_iconParams = [_iconImage, _iconWidth, _iconHeight, _iconMapWidth, _iconMapHeight, _iconShadow, _iconColor];
AIC_fnc_setMapIconProperties(_mapIconId,_iconParams);

_mapIconId;