#include "commandControl\functions.h"
#include "groupControl\functions.h"
#include "interactiveIcon\functions.h"
#include "inputControl\functions.h"

/*
	Get and sets the count of elements created
	Data Type: NUMBER - count of elements already created
*/
#define AIC_fnc_getMapElementCount() missionNamespace getVariable ["AIC_Map_Element_Count",0]
#define AIC_fnc_setMapElementCount(_elementCount) missionNamespace setVariable ["AIC_Map_Element_Count",(_elementCount)]

/*
	Get and sets the visibility of a map element (self)
	Data Type: BOOLEAN - is visible
*/
#define AIC_fnc_getMapElementSelfVisible(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Self_Visible",(_elementId)],true]
#define AIC_private_fnc_setMapElementSelfVisible(_elementId,_isShown) missionNamespace setVariable [format ["AIC_Map_Element_%1_Self_Visible",(_elementId)],(_isShown)]

/*
	Get and sets the visibility of a map element (inherited)
	Data Type: BOOLEAN - is visible
*/
#define AIC_fnc_getMapElementInheritedVisible(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Inh_Visible",(_elementId)],true]
#define AIC_private_fnc_setMapElementInheritedVisible(_elementId,_isShown) missionNamespace setVariable [format ["AIC_Map_Element_%1_Inh_Visible",(_elementId)],(_isShown)]

/*
	Get the visibility of a map element, taking into account inherited visibility
	Data Type: BOOLEAN - is visible
*/
#define AIC_fnc_getMapElementVisible(_elementId) ((AIC_fnc_getMapElementInheritedVisible(_elementId)) && (AIC_fnc_getMapElementSelfVisible(_elementId)))

/*
	Get and sets if the map element is enabled (self)
	Data Type: BOOLEAN - is enabled
*/
#define AIC_fnc_getMapElementSelfEnabled(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Self_Enabled",(_elementId)],true]
#define AIC_private_fnc_setMapElementSelfEnabled(_elementId,_isEnabled) missionNamespace setVariable [format ["AIC_Map_Element_%1_Self_Enabled",(_elementId)],(_isEnabled)]

/*
	Get and sets if the map element is enabled (inherited)
	Data Type: BOOLEAN - is enabled
*/
#define AIC_fnc_getMapElementInheritedEnabled(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Inh_Enabled",(_elementId)],true]
#define AIC_private_fnc_setMapElementInheritedEnabled(_elementId,_isEnabled) missionNamespace setVariable [format ["AIC_Map_Element_%1_Inh_Enabled",(_elementId)],(_isEnabled)]

/*
	Get if map element is enabled, taking into account inherited enabled field
	Data Type: BOOLEAN - is visible
*/
#define AIC_fnc_getMapElementEnabled(_elementId) ((AIC_fnc_getMapElementInheritedEnabled(_elementId)) && (AIC_fnc_getMapElementSelfEnabled(_elementId)))

/*
	Get and sets if the map element is in foreground (self)
	Data Type: BOOLEAN - is in foreground
*/
#define AIC_fnc_getMapElementSelfForeground(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Self_In_Foreground",(_elementId)],true]
#define AIC_private_fnc_setMapElementSelfForeground(_elementId,_isInForeground) missionNamespace setVariable [format ["AIC_Map_Element_%1_Self_In_Foreground",(_elementId)],(_isInForeground)]

/*
	Get and sets if the map element is in foreground (inherited)
	Data Type: BOOLEAN - is in foreground
*/
#define AIC_fnc_getMapElementInheritedForeground(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Inh_In_Foreground",(_elementId)],true]
#define AIC_private_fnc_setMapElementInheritedForeground(_elementId,_isInForeground) missionNamespace setVariable [format ["AIC_Map_Element_%1_Inh_In_Foreground",(_elementId)],(_isInForeground)]

/*
	Get and sets if the map element is in foreground, taking into account inherited foreground field
	Data Type: BOOLEAN - is in foreground
*/
#define AIC_fnc_getMapElementForeground(_elementId) ((AIC_fnc_getMapElementSelfForeground(_elementId)) && (AIC_fnc_getMapElementInheritedForeground(_elementId)))

/*
	Get and sets if the map element children
	Data Type: ARRAY - [ STRING - Map element id, ... ]
*/
#define AIC_fnc_getMapElementChildren(_elementId) missionNamespace getVariable [format ["AIC_Map_Element_%1_Children",(_elementId)],[]]
#define AIC_fnc_setMapElementChildren(_elementId,_elementChildren) missionNamespace setVariable [format ["AIC_Map_Element_%1_Children",(_elementId)],(_elementChildren)]