
[markerPos "hc1", [[1,"Take High Command","FUNC_takeHC",true,true,false],[2,"Release High Command","FUNC_releaseHC",true,false,true],[3,"Alpha Go","FUNC_alphaGo",true],[4,"Bravo Go","FUNC_bravoGo",true]], false, 1] call AIC_fnc_createCommandRadio;

FUNC_takeHC = {
	{["ALL_WEST",true] call AIC_fnc_showCommandControl;} remoteExec ["bis_fnc_call", _this select 0]; 
};

FUNC_releaseHC = {
	{["ALL_WEST",false] call AIC_fnc_showCommandControl;} remoteExec ["bis_fnc_call", _this select 0]; 
};

FUNC_alphaGo = {
	{ ["ALPHA"] call AIC_fnc_sendGoCode; } remoteExec ["bis_fnc_call", _this select 0]; 
};

FUNC_bravoGo = {
	{ ["BRAVO"] call AIC_fnc_sendGoCode; } remoteExec ["bis_fnc_call", _this select 0]; 
};