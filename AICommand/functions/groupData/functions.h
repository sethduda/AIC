/*
	Gets and sets the go code associated with a group (network global var)
	Data type: NUMBER - count of interactive icons
*/
#define AIC_fnc_getGroupGoCode(_groupVar) _groupVar getVariable ["AIC_Wait_For_Go_Code",nil]
#define AIC_fnc_setGroupGoCode(_groupVar,_goCodeName) _groupVar setVariable ["AIC_Wait_For_Go_Code",(_goCodeName),true]