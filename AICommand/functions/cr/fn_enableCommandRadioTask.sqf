private ["_taskId","_enable","_radioTasks","_newRadioTasks"];
_taskId = [_this,0] call BIS_fnc_param;
_enable = [_this,1,true] call BIS_fnc_param;
_newRadioTasks = [];
if(isServer) then {
	_radioTasks = ["pv_cr_radio_tasks",[]] call AIC_fnc_getPublicVariable;
	{
		if( _x select 0 == _taskId ) then {
			_newRadioTasks = _newRadioTasks + [[_x select 0, _x select 1, _x select 2, _enable]];
		} else {
			_newRadioTasks = _newRadioTasks + [_x];
		};
	} forEach _radioTasks;
};
["pv_cr_radio_tasks",_newRadioTasks] call AIC_fnc_setPublicVariable;
[[],"AIC_fnc_syncCommandRadioTasksLocal",true] spawn BIS_fnc_MP; 


