private ["_owner","_radio"];
_owner = [_this,0] call BIS_fnc_param;
_radio = [_owner] call AIC_fnc_getOwnerRadio;
if( not( isNull _radio ) ) then {
	[[_owner,_radio],"AIC_fnc_showCommandRadioMenuLocal",_owner] spawn BIS_fnc_MP; 
};

