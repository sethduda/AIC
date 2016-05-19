class AICommand
{
	tag = "AIC";
	
	class Main
	{
		file = "AICommand\functions";	
		class initAICommand {description = ""};
		class initAICommandClient {description = ""};
	};
	
	class MapIcon
	{
		file = "AICommand\functions\mapIcon";	
		class createMapIcon {description = ""};
		class drawMapIcon {description = ""};
		class mapIconDefinitions {description = ""};
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
		class getGroupAssignedVehicles {description = ""};
		class setGroupAssignedVehicles {description = ""};
	};

	class CommandMenu
	{
		file = "AICommand\functions\commandMenu";
		class commandMenuManager {description = "";};
		class showGroupCommandMenu {description = "";};
		class showGroupWpCommandMenu {description = "";};
		class showGroupWpGoCodeMenu {description = "";};
		class addCommandMenuAction {description = "";};
		class executeCommandMenuAction {description = "";};
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

	class InputControlMapElement
	{
		file = "AICommand\functions\mapElements\inputControl";
		class inputControlEventHandler {description = "";};
		class createInputControl {description = "";};
		class drawInputControl {description = "";};
		class deleteInputControl {description = "";};
		class inputControlManager {description = "";};
	};
	
	class InteractiveIconMapElement
	{
		file = "AICommand\functions\mapElements\interactiveIcon";
		class interactiveIconManager {description = ""};
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
		class groupControlManager {description = ""};
		class showGroupReport {description = ""};
		class removeGroupControl {description = ""};
	};
	
	class CommandControlMapElement
	{
		file = "AICommand\functions\mapElements\commandControl";
		class commandControlManager {description = ""};
		class createCommandControl {description = ""};
		class drawCommandControl {description = ""};
		class commandControlAddGroup {description = ""};
		class commandControlRemoveGroup {description = ""};
		class commandControlEventHandler {description = ""};
		class showCommandControl {description = ""};
		class sendGoCode {description = ""};
	};
	
	class Util
	{
		file = "AICommand\functions\util";
		class getInVehicle {description = "";};
	};
	
};