#include "..\functions.h"
_this spawn {
	params ["_object",["_followDirection",false]];
	waitUntil {time > 0};
	showCinemaBorder false;
	AIC_3rd_Person_Camera_Target = _object;
	AIC_3rd_Person_Camera = "camera" camCreate (_object modelToWorld [0,0,0]); 
	AIC_3rd_Person_Camera cameraEffect ["internal", "BACK"];
	AIC_Mouse_Move_Handler = ["MAIN_DISPLAY","MouseMoving", "_this call AIC_fnc_cameraMouseMoveHandler"] call AIC_fnc_addEventHandler;
	AIC_Mouse_Zoom_Handler = ["MAIN_DISPLAY","MouseZChanged", "_this call AIC_fnc_cameraMouseZoomHandler"] call AIC_fnc_addEventHandler;
	AIC_3rd_Person_Camera_Frame_Handler = addMissionEventHandler ["EachFrame", {[] call AIC_fnc_cameraUpdatePosition; false}];
	
	AIC_fnc_remoteCameraMapHandler = {
		private ["_event","_eventParams","_actionKeys"];
		_event = param [0];
		_eventParams = param [1];
		_actionKeys = actionKeys "ShowMap";
		if(_event == "KeyDown" || _event == "MouseButtonDown") then {
			if( (_eventParams select 1) in _actionKeys || (65536 + (_eventParams select 1)) in _actionKeys ) then {
				[] spawn {
					AIC_FNC_CAMERA cameraEffect ["Terminate", "Back"];
					openMap true;
					waitUntil {!visibleMap};
					if(!isNil "AIC_3rd_Person_Camera") then {
						AIC_3rd_Person_Camera cameraEffect ["internal", "BACK"];
					};
				};
			};
		};
		
	};	

	AIC_3rd_Person_Camera_Map_Handler1 = ["MAIN_DISPLAY","KeyDown", "[""KeyDown"",_this] call AIC_fnc_remoteCameraMapHandler"] call AIC_fnc_addEventHandler;
	AIC_3rd_Person_Camera_Map_Handler2 = ["MAIN_DISPLAY","MouseButtonDown", "[""MouseButtonDown"",_this] call AIC_fnc_remoteCameraMapHandler"] call AIC_fnc_addEventHandler;

	waitUntil {isNull AIC_FNC_CAMERA || isNull _object};
	[] call AIC_fnc_disable3rdPersonCamera;
};