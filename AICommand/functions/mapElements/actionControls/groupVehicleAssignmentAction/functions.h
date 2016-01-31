/*
	Gets and sets group control id
	Data type: STRING - group control id
*/
#define AIC_fnc_getGroupVehicleAssignmentActionGroupControlId(_mapElementId) missionNamespace getVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Group_Control",(_mapElementId)],""]
#define AIC_fnc_setGroupVehicleAssignmentActionGroupControlId(_mapElementId,_groupControl) missionNamespace setVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Group_Control",(_mapElementId)],(_groupControl)]

/*
	Gets and sets group
	Data type: GROUP - group
*/
#define AIC_fnc_getGroupVehicleAssignmentActionGroup(_mapElementId) missionNamespace getVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Group",(_mapElementId)],[]]
#define AIC_fnc_setGroupVehicleAssignmentActionGroup(_mapElementId,_groupRef) missionNamespace setVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Group",(_mapElementId)],(_groupRef)]

/*
	Gets and sets vehicles
	Data type: ARRAY - [ OBJECT - Vehicle, ... ]
*/
#define AIC_fnc_getGroupVehicleAssignmentActionVehicles(_mapElementId) missionNamespace getVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Vehicles",(_mapElementId)],[]]
#define AIC_fnc_setGroupVehicleAssignmentActionVehicles(_mapElementId,_vehicleArray) missionNamespace setVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Vehicles",(_mapElementId)],(_vehicleArray)]

/*
	Gets and sets vehicle icons
	Data type: ARRAY - [ STRING - Interactive Icon, .... ]
*/
#define AIC_fnc_getGroupVehicleAssignmentActionVehicleIcons(_mapElementId) missionNamespace getVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Vehicle_Icons",(_mapElementId)],[]]
#define AIC_fnc_setGroupVehicleAssignmentActionVehicleIcons(_mapElementId,_iconIdArray) missionNamespace setVariable [format ["AIC_Group_Vehicle_Assignment_Action_%1_Vehicle_Icons",(_mapElementId)],(_iconIdArray)]

/*
	Gets and sets a list of all group vehicle assignment actions
	Data type: ARRAY - [
		STRING - Map Element Id, ...
	]
*/
#define AIC_fnc_getGroupVehicleAssignmentActions() missionNamespace getVariable ["AIC_Group_Vehicle_Assignment_Actions",[]]
#define AIC_fnc_setGroupVehicleAssignmentActions(_actionArray) missionNamespace setVariable ["AIC_Group_Vehicle_Assignment_Actions",(_actionArray)]
