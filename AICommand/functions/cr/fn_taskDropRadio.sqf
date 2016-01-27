private ["_owner","_radio","_radioMarker"];
_owner = [_this,0] call BIS_fnc_param;
_radio = [_owner] call AIC_fnc_getOwnerRadio;
_radioMarker = _radio getVariable "radio_marker";
if( not( isNull _radio ) ) then {
	_radio setPos (getPos _owner);
	_radioMarker setMarkerPos getPos _radio;
	_radioMarker setMarkerAlpha 1;
	_radio hideObjectGlobal false;
	_radio hideObject false;
	{
		_x hideObjectGlobal false;
		_x hideObject false;
	} forEach attachedObjects _radio;
	[_radio,objNull] call AIC_fnc_setRadioOwner;
};
[[],"AIC_fnc_syncCommandRadioTasksLocal",true] spawn BIS_fnc_MP; 

