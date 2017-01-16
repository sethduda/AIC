#include "..\functions.h"
_this spawn {
	params ["_object"];
	private ["_lastPosition"];
	waitUntil {time > 0};
	showCinemaBorder false;
	AIC_3rd_Person_Camera = "camera" camCreate (_object modelToWorld [0,0,0]); 
	AIC_3rd_Person_Camera camSetTarget _object; 
	AIC_3rd_Person_Camera cameraEffect ["internal", "BACK"];
	[] call AIC_fnc_cameraUpdatePosition;
	AIC_Mouse_Move_Handler = ["MAIN_DISPLAY","MouseMoving", "_this call AIC_fnc_cameraMouseMoveHandler"] call AIC_fnc_addEventHandler;
	AIC_Mouse_Zoom_Handler = ["MAIN_DISPLAY","MouseZChanged", "_this call AIC_fnc_cameraMouseZoomHandler"] call AIC_fnc_addEventHandler;
	_lastPosition = getPos _object;
	_lastVectorDir = vectorDir _object;
	while {!isNull AIC_FNC_CAMERA && !isNull _object && alive _object} do {
		if(_lastPosition distance _object > 0.01 || vectorMagnitude (_lastVectorDir vectorDiff (vectorDir _object)) > 0.01 ) then {
			[] call AIC_fnc_cameraUpdatePosition;
			_lastPosition = getPos _object;
		};
		sleep 0.01;
	};
	[] call AIC_fnc_disable3rdPersonCamera;
};