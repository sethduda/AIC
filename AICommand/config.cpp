class CfgPatches
{
	class AICommand
	{
		units[] = {"AICommand"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
	};
};

class cfgFunctions {
	#include "\AICommand\cfgfunctions.hpp"
};

class CfgNotifications
{
	#include "\AICommand\cfgnotifications.hpp"
};