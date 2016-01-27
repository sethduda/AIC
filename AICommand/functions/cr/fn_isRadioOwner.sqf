private ["_owner","_isOwner"];
_owner = [_this,0] call BIS_fnc_param;
_radioOwners = [] call AIC_fnc_getRadioOwners;
_isOwner = false;
{
	if( _x select 1 == _owner ) then {
		_isOwner = true;
	};
} forEach _radioOwners;
_isOwner;

