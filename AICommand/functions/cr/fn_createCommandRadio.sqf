if(isServer) then {
	private ["_radios","_startPos","_tasks","_showArrow"];
	_startPos = [_this,0] call BIS_fnc_param;
	_tasks = [_this,1] call BIS_fnc_param;
	_showArrow = [_this,2,false] call BIS_fnc_param;
	_radioCount = [_this,3,1] call BIS_fnc_param;
	_radios = [];
	_tasks = [[-1,"Command Radio","AIC_fnc_showCommandRadioMenu",true,false,false,true]] + _tasks + [[-2,"Drop Command Radio","AIC_fnc_taskDropRadio",true,false,false,false,{ not(surfaceIsWater (getPos _x) || ((getPos _x) select 2) > 1 || vehicle _x != _x) }]];
	// Create all of the radios
	for "_i" from 1 to _radioCount do
	{
		private ["_radio"];
		_radio = createVehicle ["Land_SatellitePhone_F", _startPos, [], 0, "CAN_COLLIDE"];
		_startPos = getPos _radio;
		if(_showArrow) then {
			private ["_startPosArrow","_arrow"];
			_startPosArrow = [_startPos select 0, _startPos select 1, (_startPos select 2) + 0.2];
			_arrow = createVehicle ["Sign_Arrow_Green_F", _startPosArrow, [], 0, "CAN_COLLIDE"];
			_arrow attachTo [_radio];
		};
		[_radio,objNull] call AIC_fnc_setRadioOwner;
		
		_radioMarker = createMarker [format ["cr_radio_marker_%1", _i],getPos _radio];
		_radioMarker setMarkerShape "ICON";
		_radioMarker setMarkerType "mil_dot";
		_radioMarker setMarkerText "Command Radio";
		_radio setVariable ["radio_marker",_radioMarker];

		_radios = _radios + [_radio];
	};
	["pv_cr_radios",_radios] call AIC_fnc_setPublicVariable;
	["pv_cr_radio_tasks",_tasks] call AIC_fnc_setPublicVariable;
	[_startPos] spawn AIC_fnc_commandRadioSyncLoop;
};

if(!isDedicated) then {
	waitUntil { !isNil "pv_cr_radios" };
	g_my_radio = objNull;
	g_my_radio_tasks = [];
	{
		_x addAction ["Take Command Radio", { 
			private ["_radio","_caller"];
			_radio = _this select 0;
			_caller = _this select 1;
			[[_radio,_caller],"AIC_fnc_takeCommandRadio",false] spawn BIS_fnc_MP; 
		}];
	} forEach pv_cr_radios;		
};

