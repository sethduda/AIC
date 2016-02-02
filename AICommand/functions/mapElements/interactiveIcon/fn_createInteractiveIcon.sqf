#include "..\..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Creates a new interactive icon
	
	Parameter(s):
	_this select 0: ARRAY - [
		ARRAY - [ STRING - Unselected Map Icon Ids, ... ],
		ARRAY - [ STRING - Selected Map Icon Ids, ... ],
		ARRAY - [ STRING - Mouse Over Map Icon Ids, ... ],
		ARRAY - [ STRING - Picked Up Map Icon Ids, ... ]
	]
	_this select 1: POSITION - world position of interactive icon 

	Returns: 
	STRING - Icon ID
*/

private ["_iconSet","_iconPosition"];

_iconSet = param [0];
_iconPosition = param [1];

private ["_interactiveIconId","_interactiveIconDimensions","_interactiveIcons","_iconProps"];

_interactiveIconId = [] call AIC_fnc_createMapElement;

_iconProps = AIC_fnc_getMapIconProperties((_iconSet select 0) select 0);
_interactiveIconDimensions = [_iconProps select 3, _iconProps select 4];

AIC_fnc_setInteractiveIconIconSet(_interactiveIconId,_iconSet);
AIC_fnc_setInteractiveIconPosition(_interactiveIconId,_iconPosition);
AIC_fnc_setInteractiveIconState(_interactiveIconId,"UNSELECTED");
AIC_fnc_setInteractiveIconDimensions(_interactiveIconId,_interactiveIconDimensions);

_interactiveIcons = AIC_fnc_getInteractiveIcons();
_interactiveIcons pushBack _interactiveIconId;
AIC_fnc_setInteractiveIcons(_interactiveIcons);

_interactiveIconId;