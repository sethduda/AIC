This is the high level organization of the code:

Command Control -- uses --> Group Controls -- uses --> Interactive Icons -- uses --> Map Icons

Map Icon: Represents an icon that can be drawn on the map. These are local to the client only.

Interactive Icon: A collection of map icons (unselected icon, selected icon, mouse over icon, etc) and mouse/key event handlers. The mouse/key events determines the "state" of the interactive icon. (e.g. mouse over, selected, etc) The state drives which map icon from its collection of icons is shown when drawn on a map. These are local to the client only.

Group Control: A collection of interactive icons (one for the group icon, and one for each waypoint) associated to one group. Also includes a bunch of event handlers. These are local to the client only.

Command Control: A collection of groups controlled via the map. Any group in a command control will be shown + will be controllable via the map when the Command Control is drawn. These are network global.
