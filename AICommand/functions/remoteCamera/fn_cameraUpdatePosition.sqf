#include "..\functions.h"
private ["_cam"];
_cam = AIC_FNC_CAMERA;
if(!isNil "_cam") then {

	private _targetObject = vehicle AIC_FNC_CAMERA_TARGET;
	private _targetPosition = getPosASLVisual _targetObject;
	private _bbr = boundingBoxReal _targetObject;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;
	private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	_targetPosition = _targetPosition vectorAdd [0,0,_maxHeight * 0.5];
	private _cameraPosition = AIC_FNC_CAMERA_REL_POSITION vectorAdd _targetPosition;
	if((ASLToATL _cameraPosition) select 2 < 0) then {
		AIC_3rd_Person_Camera_Y_Move_Total = AIC_FNC_CAMERA_Y_TOTAL min AIC_FNC_CAMERA_Y_TOTAL_PRIOR;
		_cameraPosition = AIC_FNC_CAMERA_REL_POSITION vectorAdd _targetPosition;
	};
	private _lookVector = _cameraPosition vectorFromTo _targetPosition;
	private _cameraUpVector = (_lookVector vectorCrossProduct [0,0,1]) vectorCrossProduct _lookVector;
	_cam setPosASL _cameraPosition;
	_cam setVectorDirAndUp [_lookVector,_cameraUpVector];
	AIC_3rd_Person_Camera_Y_Move_Total_Prior = AIC_FNC_CAMERA_Y_TOTAL;
	AIC_3rd_Person_Camera_Last_Position = _cameraPosition;
};