if(isServer) then {
	private ["_radio","_caller","_currentRadioOwner","_radioMarker"];
	_radio = [_this,0] call BIS_fnc_param;
	_caller = [_this,1] call BIS_fnc_param;
	_radioMarker = _radio getVariable "radio_marker";
	[_radio,_caller] call AIC_fnc_setRadioOwner;
	_radio hideObjectGlobal true;
	_radio hideObject true;
	{
		_x hideObjectGlobal true;
		_x hideObject true;
	} forEach attachedObjects _radio;
	_radioMarker setMarkerAlpha 0;
	[[],"AIC_fnc_syncCommandRadioTasksLocal",true] spawn BIS_fnc_MP; 
};
