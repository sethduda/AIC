if(!isNil "g_my_radio_tasks") then {
	if( [player] call AIC_fnc_isRadioOwner ) then {
	
		// Sync tasks
		private ["_radioTasks","_radioTaskId","_radioTaskName","_radioTaskFunction","_radioTaskEnabled","_playerAction","_playerHasAction","_playerActionIndex","_radioTakeTask","_radioDropTask","_radioShowAsAction","_radioTaskSelectableFunc"];
		_radioTasks = ["pv_cr_radio_tasks",[]] call AIC_fnc_getPublicVariable;
		
		// Execute take tasks
		if( count g_my_radio_tasks == 0 ) then {
			{
				_radioTaskId = [_x,0] call BIS_fnc_param;
				_radioTaskName = [_x,1] call BIS_fnc_param;
				_radioTaskFunction = [_x,2] call BIS_fnc_param;
				_radioTaskEnabled = [_x,3,true] call BIS_fnc_param;
				_radioTakeTask = [_x,4,false] call BIS_fnc_param;
				if(_radioTaskEnabled && _radioTakeTask) then {
					[[player],_radioTaskFunction,false] spawn BIS_fnc_MP; 
				};
			} forEach _radioTasks;
		};

		// Add tasks to player's UI
		{
			_radioTaskId = [_x,0] call BIS_fnc_param;
			_radioTaskName = [_x,1] call BIS_fnc_param;
			_radioTaskFunction = [_x,2] call BIS_fnc_param;
			_radioTaskEnabled = [_x,3,true] call BIS_fnc_param;
			_radioTakeTask = [_x,4,false] call BIS_fnc_param;
			_radioDropTask = [_x,5,false] call BIS_fnc_param;
			_radioShowAsAction = [_x,6,false] call BIS_fnc_param;
			_radioTaskSelectableFunc = [_x,7,{true}] call BIS_fnc_param;
			_playerAction = [];
			_playerHasAction = false;
			_playerActionIndex = 0;
			
			// Determine if the player already has the task
			scopeName "arraySearchLoop";
			{
				if( (_x select 0) == _radioTaskId ) then {
					_playerAction = _x;
					_playerHasAction = true;
					breakTo "arraySearchLoop";
				};
				_playerActionIndex = _playerActionIndex + 1;
			} forEach g_my_radio_tasks;			
			
			// Task enabled and player doesn't have it (and not a take or drop task)
			if(not(_playerHasAction) && _radioTaskEnabled && not(_radioTakeTask) && not(_radioDropTask) && _radioShowAsAction) then {
				// Add action
				_actionId = player addAction [_radioTaskName, {
					private ["_player","_functionName"];
					_functionName = (_this select 3) select 0;
					_player = (_this select 3) select 1;
					[[_player],_functionName,false] spawn BIS_fnc_MP; 
				}, [_radioTaskFunction,player],0,false];
				// Add to task array
				g_my_radio_tasks = g_my_radio_tasks + [[_radioTaskId, _actionId]];
			};
			
			// Task disabled and player has it
			if(_playerHasAction && not(_radioTaskEnabled)) then {
				// Remove action
				player removeAction (_playerAction select 1);
				// Remove from task array
				g_my_radio_tasks set [_playerActionIndex,-1];
				g_my_radio_tasks = g_my_radio_tasks - [-1];
			};
			
		} forEach _radioTasks;
		
	} else {
	
		private ["_radioTasks","_radioTaskFunction","_radioTaskEnabled","_radioDropTask","_radioShowAsAction"];
		_radioTasks = ["pv_cr_radio_tasks",[]] call AIC_fnc_getPublicVariable;
		
		// Execute drop tasks
		if( count g_my_radio_tasks > 0 ) then {
			{
				_radioTaskFunction = [_x,2] call BIS_fnc_param;
				_radioTaskEnabled = [_x,3,true] call BIS_fnc_param;
				_radioDropTask = [_x,5,false] call BIS_fnc_param;
				if(_radioTaskEnabled && _radioDropTask) then {
					[[player],_radioTaskFunction,false] spawn BIS_fnc_MP; 
				};
			} forEach _radioTasks;
		};
	
		// Remove all tasks - player has no radio
		{
			player removeAction (_x select 1);
		} forEach g_my_radio_tasks;
		g_my_radio_tasks = [];
		
	};
};
