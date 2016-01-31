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
		class getGroupActions {description = ""};
		class setGroupActions {description = ""};
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
	
	class VehicleIcon
	{
		file = "AICommand\functions\vehicleIcon";
		class getVehicleIconPath {description = "";};
		class getVehicleMapIconSet {description = "";};
		class createVehicleInteractiveIcon {description = "";};
	};
		
	class MapElements
	{

		file = "AICommand\functions\mapElements";
		class createMapElement {description = "";};
		class setMapElementEnabled {description = "";};
		class setMapElementVisible {description = "";};
		class setMapElementForeground {description = "";};
		class addMapElementChild {description = "";};
		class deleteMapElement {description = "";};
	};
	
	class ActionControlMapElement
	{
		file = "AICommand\functions\mapElements\actionControl";
		class actionControlEventHandler {description = "";};
		class createActionControl {description = "";};
		class drawActionControl {description = "";};
		class deleteActionControl {description = "";};
		class actionControlManager {description = ""; postInit=1};
	};
	
	class InteractiveIconMapElement
	{
		file = "AICommand\functions\mapElements\interactiveIcon";
		class interactiveIconManager {description = ""; postInit=1};
		class createInteractiveIcon {description = ""};
		class drawInteractiveIcon {description = ""};
		class handleInteractiveIconEvent {description = ""};
		class interactiveIconEventHandler {description = ""};
		class getInteractiveIconsByMapPosition {description = ""};
		class removeInteractiveIcon {description = ""};
	};
	
	
	class GroupControlMapElement
	{
		file = "AICommand\functions\mapElements\groupControl";
		class getGroupIconType {description = ""};
		class getGroupControlIconSet {description = ""};
		class getGroupControlWpIconSet {description = ""};
		class createGroupControl {description = ""};
		class drawGroupControl {description = ""};
		class groupControlEventHandler {description = ""};
		class groupControlWaypointEventHandler {description = ""};
		class groupControlManager {description = ""; postInit=1};
		class showGroupReport {description = ""};
		class removeGroupControl {description = ""};
	};
	
	class CommandControlMapElement
	{
		file = "AICommand\functions\mapElements\commandControl";
		class commandControlManager {description = ""; postInit=1};
		class createCommandControl {description = ""};
		class drawCommandControl {description = ""};
		class commandControlAddGroup {description = ""};
		class commandControlRemoveGroup {description = ""};
		class commandControlEventHandler {description = ""};
		class showCommandControl {description = ""};
		class sendGoCode {description = ""};
	};
	
	class ActionControlsGroupVehicleAssignmentAction
	{
		file = "AICommand\functions\mapElements\actionControls\groupVehicleAssignmentAction";
		class createGroupVehicleAssignmentAction {description = "";};
		class deleteGroupVehicleAssignmentAction {description = "";};
		class drawGroupVehicleAssignmentAction {description = "";};
		class groupVehicleAssignmentActionManager {description = ""; postInit=1};
		class groupVehicleAssignmentActionEventHandler {description = "";};
	};
	
	
};