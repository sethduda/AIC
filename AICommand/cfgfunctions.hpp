class AICommand
{
	tag = "AIC";
	
	class MapIcon
	{
		file = "AICommand\functions\mapIcon";	
		class createMapIcon {description = ""};
		class drawMapIcon {description = ""};
		class mapIconDefinitions {description = ""; preInit=1};
	};
	
	class InteractiveIcon
	{
		file = "AICommand\functions\interactiveIcon";
		class interactiveIconManager {description = ""; postInit=1};
		class createInteractiveIcon {description = ""};
		class drawInteractiveIcon {description = ""};
		class handleInteractiveIconEvent {description = ""};
		class interactiveIconEventHandler {description = ""};
		class getInteractiveIconsByMapPosition {description = ""};
		class removeInteractiveIcon {description = ""};
	};
	
	
	class GroupControl
	{
		file = "AICommand\functions\groupControl";
		class getGroupIconType {description = ""};
		class getGroupControlIconSet {description = ""};
		class getGroupControlWpIconSet {description = ""};
		class createGroupControl {description = ""};
		class drawGroupControl {description = ""};
		class showGroupControl {description = ""};
		class groupControlEventHandler {description = ""};
		class groupControlWaypointEventHandler {description = ""};
		class groupControlManager {description = ""; postInit=1};
		class showGroupReport {description = ""};
		class removeGroupControl {description = ""};
	};
	
	class CommandControl
	{
		file = "AICommand\functions\commandControl";
		class commandControlManager {description = ""; postInit=1};
		class createCommandControl {description = ""};
		class drawCommandControl {description = ""};
		class commandControlAddGroup {description = ""};
		class commandControlRemoveGroup {description = ""};
		class commandControlEventHandler {description = ""};
		class showCommandControl {description = ""};
		class sendGoCode {description = ""};
	};
	
	class GroupData
	{
		file = "AICommand\functions\groupData";
		class addWaypoint {description = ""};	
		class getAllWaypoints {description = ""};
		class getWaypoint {description = ""};
		class setWaypoint {description = ""};
		class disableWaypoint {description = ""};
		class disableAllWaypoints {description = ""};
		class waitForWaypointGoCode { description = ""};
		class sendWaypointGoCode { description = ""};
		class setGroupColor {description = ""};
		class getGroupColor {description = ""};
		class getAllActiveWaypoints {description = ""};
	};

	class CommandMenu
	{
		file = "AICommand\functions\commandMenu";
		class commandMenuManager {description = ""; postInit=1};
		class showGroupCommandMenu {description = "";};
		class showGroupGoCodeMenu {description = "";};
		class showGroupConfirmMenu {description = "";};
		class showGroupWpCommandMenu {description = "";};
		class showGroupWpGoCodeMenu {description = "";};
		class showGroupColorMenu {description = "";};
		class showGroupCombatModeMenu {description = "";};
		class showGroupBehaviourMenu {description = "";};
	};

	class CR
	{
		file = "AICommand\functions\cr";
		class createCommandRadio {description = ""};
		class commandRadioSyncLoop {description = ""};
		class enableCommandRadioTask {description = ""};
		class takeCommandRadio {description = ""};
		class setRadioOwner {description = ""};
		class getRadioOwner {description = ""};
		class getRadioOwners {description = ""};
		class getOwnerRadio {description = ""};
		class isRadioOwner {description = ""};
		class taskDropRadio {description = ""};
		class syncCommandRadioTasksLocal {description = ""};
		class showCommandRadioMenu {description = ""};
		class showCommandRadioMenuLocal {description = ""};
		class setPublicVariable {description = ""};
		class getPublicVariable {description = ""};
	};
	
};