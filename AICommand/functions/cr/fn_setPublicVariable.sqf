/*
	Author: [SA] Duda
	
	Description:
	Set public variable
	
	Parameters:
		0: STRING - Public variable name
		1: ANY - Public variable value
	
	Returns:
	ARRAY - Array of playable units matching some criteria
*/

private ["_variableName","_variableValue"];
_variableName = [_this,0] call BIS_fnc_param;
_variableValue = [_this,1] call BIS_fnc_param;
missionNamespace setVariable [_variableName,_variableValue];
publicVariable _variableName;
