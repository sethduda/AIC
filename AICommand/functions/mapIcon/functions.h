/*
	Gets and sets a map icon's properties	
	Data Type: ARRAY - [
		STRING - Icon image path
		NUMBER - Icon screen width
		NUMBER - Icon screen height
		NUMBER - Icon map width
		NUMBER - Icon map height 
		NUMBER - Icon shadow
		COLOR  - Icon color [R,G,B,A]
	]
*/
#define AIC_fnc_getMapIconProperties(_iconId) missionNamespace getVariable [format ["AIC_Map_Icon_%1",(_iconId)],nil]
#define AIC_fnc_setMapIconProperties(_iconId,_iconProperties) missionNamespace setVariable [format ["AIC_Map_Icon_%1",(_iconId)],_iconProperties]

/*
	Get and sets the count of map icons already created
	Data Type: NUMBER - count of map icons already created
*/
#define AIC_fnc_getMapIconCount() missionNamespace getVariable ["AIC_Map_Icon_Count",0]
#define AIC_fnc_setMapIconCount(_iconCount) missionNamespace setVariable ["AIC_Map_Icon_Count",(_iconCount)]