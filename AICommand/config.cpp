class CfgPatches
{
	class AICommand
	{
		units[] = {"AdvancedAICommand_Commanders","AdvancedAICommand_Groups"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
	};
};

class cfgFunctions {
	#include "\AICommand\cfgfunctions.hpp"
	#include "\AICommand\cfgfunctionsaddon.hpp"
};

class CfgNotifications
{
	#include "\AICommand\cfgnotifications.hpp"
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class AdvancedAICommand_Commanders: Module_F
	{
		author = "[SA] Duda";
		scope = 2;
		displayName = "Advanced AI Command - Commanders";
		icon = "\A3\modules_f\data\icon_HC_ca.paa";
		class Eventhandlers
		{
			init = "";
		};
		class ModuleDescription: ModuleDescription
		{
			description = "Set player(s) as commanders, giving them the ability to control groups of AI";
			sync[] = {"AdvancedAICommand_Groups","CommanderUnits"};
			class CommanderUnits: AnyBrain
			{
				description = "Player(s) to be commanders";
			};
			class AdvancedAICommand_Groups
			{
				duplicate = 1;
			};
		};
	};
	class AdvancedAICommand_Groups: Module_F
	{
		author = "[SA] Duda";
		scope = 2;
		displayName = "Advanced AI Command - Groups";
		icon = "\A3\modules_f\data\icon_HC_ca.paa";
		class Eventhandlers
		{
			init = "";
		};
		class ModuleDescription: ModuleDescription
		{
			description = "Set all units whose groups will be under command by the commander(s)";
			duplicate = 1;
			sync[] = {"AdvancedAICommand_Commanders","GroupUnits"};
			class GroupUnits: AnyBrain
			{
				description = "Unit whose group will be under command";
			};
			class AdvancedAICommand_Commanders{};
		};
	};
};
