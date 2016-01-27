private ["_radio","_owner","_radioOwners","_index","_foundIndex"];
_radio = [_this,0] call BIS_fnc_param;
_owner = [_this,1] call BIS_fnc_param;
_radioOwners = [] call AIC_fnc_getRadioOwners;
_index = 0;
_foundIndex = false;
scopeName "arraySearchLoop";
{
	if( _x select 0 == _radio ) then {
		_foundIndex = true;
		breakTo "arraySearchLoop";
	};
	_index = _index + 1;
} forEach _radioOwners;
if( _foundIndex ) then {
	_radioOwners set [_index,[_radio,_owner]];
} else {
	_radioOwners = _radioOwners + [[_radio,_owner]];
};
["pv_cr_radio_owners",_radioOwners] call AIC_fnc_setPublicVariable;	

