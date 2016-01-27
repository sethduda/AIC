![alt tag](http://s10.postimg.org/rbltoe18p/command.jpg)

This is the high level organization of the code:

<strong>Command Control</strong> -- uses --> <strong>Group Controls</strong> -- uses --> <strong>Interactive Icons</strong> -- uses --> <strong>Map Icons</strong>

<strong>Map Icon</strong>: Represents an icon that can be drawn on the map. These are local to the client only.

<strong>Interactive Icon</strong>: A collection of map icons (unselected icon, selected icon, mouse over icon, etc) and mouse/key event handlers. The mouse/key events determines the "state" of the interactive icon. (e.g. mouse over, selected, etc) The state drives which map icon from its collection of icons is shown when drawn on a map. These are local to the client only.

<strong>Group Control</strong>: A collection of interactive icons (one for the group icon, and one for each waypoint) associated to one group. Also includes a bunch of event handlers. These are local to the client only.

<strong>Command Control</strong>: A collection of groups controlled via the map. Any group in a command control will be shown + will be controllable via the map when the Command Control is drawn. These are network global.

Also, all of the waypoint creation is done on the server side. As you draw the "waypoints" on the map, it's not actually creating arma "waypoints" at the same time. The server a few seconds later will create them at the same position that you've drawn. In the case of the "go code" way point, the server only creates waypoints up to the go code waypoint and stops. Once the go code is issued, the server starts creating the rest of the waypoints.

Also, most of the data transmitted between the server/clients maintains a revision number. For example, when you draw a new waypoint, an array of waypoint positions gets updated along with a revision number. Other clients then use that revision number to figure out if they need to update their local set of drawn waypoints. Same thing happens for the collection of command control groups, colors, etc.

Overall, I want to keep this pretty high level. It's not my intention to give you unit level control over groups as it will get really complex. I'd really just like an easy way to direct and move groups around and change their behavior/combat mode.

In term of actions, I'm thinking of the following:

Group Actions:

1. Assign Vehicle - Assigns a group to a vehicle. Player chooses vehicle on map. Group gets into vehicle. If multiple vehicles assigned, group divides between vehicles evenly.

2. Unassign Vehicle - Unassigns a vehicle from a group. Player chooses vehicle on map (if assigned multiple). When vehicle is unassigned, the group gets out and will divided up remaining vehicles (if any remaining).

Waypoint Actions (also can be used as group actions):

1. Board Transport - Only for ground troops. Will board the cargo of the closest group's vehicle as long as there's space. Once on board, the group's icon is removed from the map.

2. Unload Transport - Only for groups assigned to a vehicle with other groups currently in their cargo. Will force all other groups to exit the vehicle. Once other groups exit, the other group's icons reappear on the map.

3. Wait - For all groups. Options might include, wait for amount of time, wait indefinitely, wait for go code, wait for cargo board, etc.

4. Land - For heli groups only. Will land near the waypoint marker.

<strong>Configuration</strong>:

The server creates one or more command controls when the the mission starts. Example creating two command controls - one for all east groups, and one for all west groups. Note: These "default" command controls (ALL_EAST, ALL_WEST) are created automatically. You can create new ones with specific groups assigned, or use these defaults.

```
["ALL_EAST"] call AIC_fnc_createCommandControl;
["ALL_WEST"] call AIC_fnc_createCommandControl;

{
if(side _x == east) then {
["ALL_EAST",_x] call AIC_fnc_commandControlAddGroup;
} else {
["ALL_WEST",_x] call AIC_fnc_commandControlAddGroup;
};
} forEach allGroups;
```

On the client side, you then can show/hide the command controls on the map using this function:

```
["ALL_WEST",true] call AIC_fnc_showCommandControl;
```

or

```
["ALL_EAST",true] call AIC_fnc_showCommandControl;
```

<strong>Video:</strong>

[![View Video](http://img.youtube.com/vi/irtAvbGjP8g/0.jpg)](http://www.youtube.com/watch?v=irtAvbGjP8g)

---

The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
