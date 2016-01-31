/*
	Gets and sets the set of map icons associated with an interactive icon
	Data type: ARRAY - [
		ARRAY - [ STRING - Unselected Map Icon Ids, ... ],
		ARRAY - [ STRING - Selected Map Icon Ids, ... ],
		ARRAY - [ STRING - Mouse Over Map Icon Ids, ... ],
		ARRAY - [ STRING - Picked Up Map Icon Ids, ... ]
	]
*/
#define AIC_fnc_getInteractiveIconIconSet(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_Icons",(_interactiveIconId)],nil]
#define AIC_fnc_setInteractiveIconIconSet(_interactiveIconId,_iconSet) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_Icons",(_interactiveIconId)],_iconSet]

/*
	Gets and sets the position of the interactive icon
	Data type: POSITION - World position of interactive icon
*/
#define AIC_fnc_getInteractiveIconPosition(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_Position",(_interactiveIconId)],nil]
#define AIC_fnc_setInteractiveIconPosition(_interactiveIconId,_iconPosition) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_Position",(_interactiveIconId)],_iconPosition]

/*
	Gets and sets the state of the interactive icon
	Data type: STRING - State of the interactive icon
*/
#define AIC_fnc_getInteractiveIconState(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_State",(_interactiveIconId)],nil]
#define AIC_fnc_setInteractiveIconState(_interactiveIconId,_iconState) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_State",(_interactiveIconId)],_iconState]

/*
	Gets and sets the dimensions of the interactive icon
	Data type: ARRAY - [
		NUMBER - interactive icon map width
		NUMBER - interactive icon map height 
	]
*/
#define AIC_fnc_getInteractiveIconDimensions(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_Dimensions",(_interactiveIconId)],nil]
#define AIC_fnc_setInteractiveIconDimensions(_interactiveIconId,_iconDimensions) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_Dimensions",(_interactiveIconId)],_iconDimensions]

/*
	Gets and sets if the interactive icon event handler script
	Data type: SCRIPT - event handler script
*/
#define AIC_fnc_getInteractiveIconEventHandlerScript(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_Event_Handler",(_interactiveIconId)],{}]
#define AIC_fnc_setInteractiveIconEventHandlerScript(_interactiveIconId,_script) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_Event_Handler",(_interactiveIconId)],_script]

/*
	Gets and sets if the interactive icon event handler script params
	Data type: ANY - event handler script params
*/
#define AIC_fnc_getInteractiveIconEventHandlerScriptParams(_interactiveIconId) missionNamespace getVariable [format ["AIC_Interactive_Icon_%1_Event_Handler_Params",(_interactiveIconId)],[]]
#define AIC_fnc_setInteractiveIconEventHandlerScriptParams(_interactiveIconId,_scriptParams) missionNamespace setVariable [format ["AIC_Interactive_Icon_%1_Event_Handler_Params",(_interactiveIconId)],_scriptParams]

/*
	Gets and sets all of the interactive icons
	Data type: ARRAY - [
		STRING - Interactive icon id, ...
	]
*/
#define AIC_fnc_getInteractiveIcons() missionNamespace getVariable ["AIC_Interactive_Icons",[]]
#define AIC_fnc_setInteractiveIcons(_interactiveIcons) missionNamespace setVariable ["AIC_Interactive_Icons",_interactiveIcons]