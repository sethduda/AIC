#include "..\functions.h"
private ["_cam"];
_cam = AIC_FNC_CAMERA;
if(!isNil "_cam") then {
	if(AIC_FNC_CAMERA_WORLD_POSITION select 2 < 0) then {
		AIC_3rd_Person_Camera_Y_Move_Total = AIC_FNC_CAMERA_Y_TOTAL min AIC_FNC_CAMERA_Y_TOTAL_PRIOR;
	};
	_cam camSetRelPos AIC_FNC_CAMERA_REL_POSITION;
	_cam camCommit 0.01;
	AIC_3rd_Person_Camera_Y_Move_Total_Prior = AIC_FNC_CAMERA_Y_TOTAL;
};