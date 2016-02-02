#include "..\functions.h"

/*
	Author: [SA] Duda

	Description:
	Gets the icon path for a specified vehicle class name

	Parameter(s):
	_this select 0: String - Vehicle class name

	Returns: 
	STRING: The icon path
*/
private ["_vehicleClassName"];
_vehicleClassName = param [0];
getText (configFile >> "CfgVehicles" >> _vehicleClassName >> "Icon")

/*

Create new action control - pass in the group control and optionally the waypoint.
Select Assign Vehicle Action
Find all nearby vehicles (near wp or group)
Command manager is the thing that dims all other groups and makes them non-interactive while the action control is being used.
Show and draw them on the map (as part of the group draw command - or maybe a new object called action manager?)
Draw line from wp/group to mouse. Follow Mouse (maybe..)
Dim all group controls
Disable selection of group or other waypoints
When mouse moves over vehicle, draw circle around it
when player right clicks on a vehicle, assign that vehicle to the squad or wp. 
If player presses backspace or left clicks, cancel selection.

Once selected, vehicle should remain on map



*/