#include "..\functions.h"
if(!isNull AIC_FNC_CAMERA) then {
	AIC_FNC_CAMERA cameraEffect ["Terminate", "Back"];
	camDestroy AIC_FNC_CAMERA;
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Distance",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_X_Move_Total",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Y_Move_Total",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Y_Move_Total_Prior",nil];
	["MAIN_DISPLAY","MouseMoving", AIC_Mouse_Move_Handler] call AIC_fnc_removeEventHandler;
	["MAIN_DISPLAY","MouseZChanged", AIC_Mouse_Zoom_Handler] call AIC_fnc_removeEventHandler;
}