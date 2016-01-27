private ["_radio","_radioOwners","_foundOwner"];
_radio = [_this,0] call BIS_fnc_param;
_radioOwners = [] call AIC_fnc_getRadioOwners;
_foundOwner = objNull;
{
	if( _x select 0 == _radio ) then {
		_foundOwner = _x select 1;
	};
} forEach _radioOwners;
_foundOwner;

