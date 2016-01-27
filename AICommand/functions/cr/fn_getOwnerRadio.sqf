private ["_owner","_radioOwners","_foundRadio"];
_owner = [_this,0] call BIS_fnc_param;
_radioOwners = [] call AIC_fnc_getRadioOwners;
_foundRadio = objNull;
{
	if( _x select 1 == _owner ) then {
		_foundRadio = _x select 0;
	};
} forEach _radioOwners;
_foundRadio;
