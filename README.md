# Advanced AI Command

SP & MP Compatible. Full replacement for high command.

This is an Alpha release. When this addon is enabled, you will be given control of all groups on your side when looking at the map. Future release will give finer grained control to limit commanders/groups. If you try this in multiplayer, all players will be commanders.

If you like this addon and want to see more, please comment here:

https://forums.bistudio.com/topic/190793-advanced-ai-command/

**Features:**

 - Control AI groups via the map. Provides intuitive interface for commanders.
 - Supports multiple commanders in multiplayer. All commanders can see in real-time as waypoints are moved.
 - Assign/unassign vehicles to an AI group using the map.
 - Waypoints can be moved around via dragging. They can be deleted using the delete key.
 - Supports remote controlling of AI group leaders (for groups without vehicles). Press delete to exit remote control.

**Installation:**

1. Subscrive via steam: http://steamcommunity.com/sharedfiles/filedetails/?id=685037021 or dowload latest release from https://github.com/sethduda/AIC/releases
2. If installing this on a server, add the addon to the -mod command line option
3. Setup command structure using editor-based modules:

![Editor Module Example Setup](http://images.akamai.steamusercontent.com/ugc/278473128263933821/3C258BB6120BEB164140B6A6D4EB48C9528A4C4A/?interpolation=lanczos-none&output-format=jpeg&output-quality=95&fit=inside|637:358&composite-to=*,*|637:358&background-color=black)

In the example above, two playable units on each side have been setup as commanders. Both units on the same side will see the same command map (and can see each other's changes). Each commander will be in control of two AI groups. Make sure all modules and units are synchronized together.

**Issues & Feature Requests**

https://github.com/sethduda/AIC/issues 

If anyone wants to help fix any of these, please let me know. You can fork the repo and create a pull request. 

**Special Thanks for Testing & Support:**

- Stay Alive Tactical Team (http://sa.clanservers.com) 

---

The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
