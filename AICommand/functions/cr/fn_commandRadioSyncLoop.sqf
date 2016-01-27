private ["_radios","_startPos","_owner"];
_startPos = [_this,0] call BIS_fnc_param;
_radios = ["pv_cr_radios",[]] call AIC_fnc_getPublicVariable;
while {true} do {
	{
		_owner = [_x] call AIC_fnc_getRadioOwner;
		if(!alive _owner) then {
			[_owner] call AIC_fnc_taskDropRadio;
		};
	} forEach _radios;
	sleep 1;
};

