#include "..\..\functions.h"

params ["_groupControlId","_waypointId"];
_group = AIC_fnc_getGroupControlGroup(_groupControlId);
_waypoint = [_group, _waypointId] call AIC_fnc_getWaypoint;
_waypoint params ["_wpIndex","_wpPosition","_wpDisabled",["_wpType","MOVE"],["_wpActionScript",""],["_wpCondition","true"],"_wpTimeout","_wpFormation","_wpCompletionRadius",["_wpDuration",0],"_wpLoiterRadius","_wpLoiterDirection","_wpFlyInHeight"];
							
_sizeLarge = 1.0;
_sizeSmall = 0.9;
_textLarge = "<t size='%3' color='#ffffff'><t align='left'>%1:</t><t align='right'>%2</t></t><br />";
_textSmall = "<t size='%3' color='#cccccc'><t align='left'> - %1:</t><t align='right'>%2</t></t><br />";

_wpInfo = format [_textLarge,"Waypoint",_wpType,_sizeLarge];

if(!isNil "_wpFormation") then {
	_wpInfo = _wpInfo + format [_textSmall,"Formation",_wpFormation,_sizeSmall];
};

if(_wpDuration > 0) then {
	_wpInfo = _wpInfo + format [_textSmall,"Duration (mins)", (str floor (_wpDuration/60)) ,_sizeSmall];
};

if(!isNil "_wpFlyInHeight") then {
	_wpInfo = _wpInfo + format [_textSmall,"Height (meters)", _wpFlyInHeight,_sizeSmall];
};

_text = parsetext (
	"<t size='1.3' color='#ffffff' font='PuristaMedium' underline='true' align='left'>SITREP</t>" + 
	format ["<t size='0.9' align='right'>%1</t><br /><br />",[daytime] call bis_fnc_timetostring] + 
	format ["<t>%1</t>",_wpInfo] + 
	""
);
hint _text;