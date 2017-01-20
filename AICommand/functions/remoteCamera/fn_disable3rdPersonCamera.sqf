#include "..\functions.h"
if(!isNull AIC_FNC_CAMERA) then {
	
	removeMissionEventHandler ["EachFrame", AIC_3rd_Person_Camera_Frame_Handler];
	["MAIN_DISPLAY","MouseMoving", AIC_Mouse_Move_Handler] call AIC_fnc_removeEventHandler;
	["MAIN_DISPLAY","MouseZChanged", AIC_Mouse_Zoom_Handler] call AIC_fnc_removeEventHandler;
	["MAIN_DISPLAY","KeyDown", AIC_3rd_Person_Camera_Map_Handler1] call AIC_fnc_removeEventHandler;
	["MAIN_DISPLAY","MouseButtonDown", AIC_3rd_Person_Camera_Map_Handler2] call AIC_fnc_removeEventHandler;
	
	AIC_FNC_CAMERA cameraEffect ["Terminate", "Back"];
	camDestroy AIC_FNC_CAMERA;
	
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Distance",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_X_Move_Total",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Y_Move_Total",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Y_Move_Total_Prior",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Last_Position",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Frame_Handler",nil];
	missionNamespace setVariable ["AIC_Mouse_Move_Handler",nil];
	missionNamespace setVariable ["AIC_Mouse_Zoom_Handler",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Map_Handler1",nil];
	missionNamespace setVariable ["AIC_3rd_Person_Camera_Map_Handler2",nil];

}