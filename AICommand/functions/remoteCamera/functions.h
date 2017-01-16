#define AIC_FNC_CAMERA_DISTANCE (missionNamespace getVariable ["AIC_3rd_Person_Camera_Distance",8])
#define AIC_FNC_CAMERA (missionNamespace getVariable ["AIC_3rd_Person_Camera",objNull])
#define AIC_FNC_CAMERA_TARGET (missionNamespace getVariable ["AIC_3rd_Person_Camera_Target",objNull])
#define AIC_FNC_CAMERA_X_TOTAL (missionNamespace getVariable ["AIC_3rd_Person_Camera_X_Move_Total",-90])
#define AIC_FNC_CAMERA_Y_TOTAL (missionNamespace getVariable ["AIC_3rd_Person_Camera_Y_Move_Total",60])
#define AIC_FNC_CAMERA_Y_TOTAL_PRIOR (missionNamespace getVariable ["AIC_3rd_Person_Camera_Y_Move_Total_Prior",AIC_FNC_CAMERA_Y_TOTAL])
#define AIC_FNC_CAMERA_REL_POSITION [AIC_FNC_CAMERA_DISTANCE * (cos AIC_FNC_CAMERA_X_TOTAL) * (sin AIC_FNC_CAMERA_Y_TOTAL), AIC_FNC_CAMERA_DISTANCE * (sin AIC_FNC_CAMERA_X_TOTAL) * (sin AIC_FNC_CAMERA_Y_TOTAL), AIC_FNC_CAMERA_DISTANCE * (cos AIC_FNC_CAMERA_Y_TOTAL)]