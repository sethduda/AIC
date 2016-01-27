This is the high level organization of the code:

Command Control -- uses --> Group Controls -- uses --> Interactive Icons -- uses --> Map Icons

Map Icon: Represents an icon that can be drawn on the map. These are local to the client only.

Interactive Icon: A collection of map icons (unselected icon, selected icon, mouse over icon, etc) and mouse/key event handlers. The mouse/key events determines the "state" of the interactive icon. (e.g. mouse over, selected, etc) The state drives which map icon from its collection of icons is shown when drawn on a map. These are local to the client only.

Group Control: A collection of interactive icons (one for the group icon, and one for each waypoint) associated to one group. Also includes a bunch of event handlers. These are local to the client only.

Command Control: A collection of groups controlled via the map. Any group in a command control will be shown + will be controllable via the map when the Command Control is drawn. These are network global.

Also, all of the waypoint creation is done on the server side. As you draw the "waypoints" on the map, it's not actually creating arma "waypoints" at the same time. The server a few seconds later will create them at the same position that you've drawn. In the case of the "go code" way point, the server only creates waypoints up to the go code waypoint and stops. Once the go code is issued, the server starts creating the rest of the waypoints.

Also, most of the data transmitted between the server/clients maintains a revision number. For example, when you draw a new waypoint, an array of waypoint positions gets updated along with a revision number. Other clients then use that revision number to figure out if they need to update their local set of drawn waypoints. Same thing happens for the collection of command control groups, colors, etc.

Overall, I want to keep this pretty high level. It's not my intention to give you unit level control over groups as it will get really complex. I'd really just like an easy way to direct and move groups around and change their behavior/combat mode.

In term of actions, I'm thinking of the following:

Group Actions:

1. Assign Vehicle - Assigns a group to a vehicle. Player chooses vehicle on map. Group gets into vehicle. If multiple vehicles assigned, group divides between vehicles evenly.

2. Unassign Vehicle - Unassigns a vehicle from a group. Player chooses vehicle on map (if assigned multiple). When vehicle is unassigned, the group gets out and will divided up remaining vehicles (if any remaining).

Waypoint Actions (also can be used as group actions):

1. Board Cargo - Only for ground troops. Will board the cargo of the closest group's vehicle as long as there's space. Once on board, the group's icon is removed from the map.

2. Unload Cargo - Only for groups assigned to a vehicle with other groups currently in their cargo. Will force all other groups to exit the vehicle. Once other groups exit, the other group's icons reappear on the map.

3. Wait - For all groups. Options might include, wait for amount of time, wait indefinitely, wait for go code, wait for cargo board, etc.

4. Land - For heli groups only. Will land near the waypoint marker.

Configuration:

The server creates one or more command controls when the the mission starts. Example creating two command controls - one for all each groups, and one for all west groups.

["ALL_EAST"] call AIC_fnc_createCommandControl;
["ALL_WEST"] call AIC_fnc_createCommandControl;

{
if(side _x == east) then {
["ALL_EAST",_x] call AIC_fnc_commandControlAddGroup;
} else {
["ALL_WEST",_x] call AIC_fnc_commandControlAddGroup;
};
} forEach allGroups;

On the client side, you then can show/hide the command controls on the map using this function:

["ALL_WEST",true] call AIC_fnc_showCommandControl;

or

["ALL_EAST",true] call AIC_fnc_showCommandControl;
