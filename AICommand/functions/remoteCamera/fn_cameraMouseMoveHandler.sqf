#include "..\functions.h"
private ["_cam","_distance","_target"];
AIC_3rd_Person_Camera_X_Move_Total = AIC_FNC_CAMERA_X_TOTAL + (-(_this select 1)*0.16);
AIC_3rd_Person_Camera_Y_Move_Total = AIC_FNC_CAMERA_Y_TOTAL + (-(_this select 2)*0.16);
AIC_3rd_Person_Camera_Y_Move_Total = AIC_FNC_CAMERA_Y_TOTAL max 20 min 160;
[] spawn AIC_fnc_cameraUpdatePosition;