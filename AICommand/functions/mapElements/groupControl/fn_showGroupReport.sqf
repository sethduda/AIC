#include "..\..\functions.h"

	_selected = param [0];
	if (count _selected == 0) exitwith {};

	//--- Loading
	_loading = [] spawn {
		_n = 0;
		while {true} do {
			_dots = "";
			for "_i" from 0 to (_n % 3) do {_dots = _dots + "."};
			_text = parsetext (
				"<t size='1.3' color='#ffffff' font='PuristaMedium' underline='true' align='left'>SITREP</t>      " + 
				format ["<t size='0.9'>Preparing %1</t><br /> ",_dots] + 
				""
			);
			hintsilent _text;
			_n = _n + 1;
			sleep 0.2;
		};
	};

	_showlimit = 5;

	_allunits = [];
	_textIcons = "";
	{
		_group = _x;
		_allunits = _allunits + units _group;

		//--- Group icon
		/*
		_grpIconId = _group getvariable "BIS_MARTA_ICON_TYPE";
		_grpIcon = _group getgroupicon _grpIconId;
		_grpIconClass = _grpIcon select 0;
		_grpIconPath = gettext (configfile >> "cfggroupicons" >> _grpIconClass >> "icon");
		_grpIconName = gettext (configfile >> "cfggroupicons" >> _grpIconClass >> "displayName");
		_grpIconParams = getgroupiconparams _group;
		_grpIconColor = _grpIconParams select 0;
		_grpIconColorHTML = _grpIconColor call bis_fnc_colorRGBtoHTML;
		_textIcons = _textIcons + format ["<t size='1.6' color='%2' shadow='0'><img image='%1'/></t>",_grpIconPath,_grpIconColorHTML];
*/
	} foreach _selected;


	//--- Initial lists of living units
	_units = [];
	_sizeLarge = 1.0;
	_sizeSmall = 0.9;
	_textLarge = "<t size='%3' color='#ffffff'><t align='left'>%1:</t><t align='right'>%2x</t></t><br />";
	_textSmall = "<t size='%3' color='#cccccc'><t align='left'> - %1:</t><t align='right'>%2x</t></t><br />";
	_lineCount = 0;

	//--- Filter living units
	_units = [];
	{if (alive _x) then {_units = _units + [_x]}} foreach _allunits;

	//--- Get list of vehicles
	_vehicles = [];
	{_veh = vehicle _x; if (_veh != _x && !(_veh in _vehicles) && alive _x) then {_vehicles = _vehicles + [_veh]}} foreach _units;
	_all = _units + _vehicles;

	//--- Count units
	_unitTypes = [];
	_unitInfo = "";
	{_type = typeof _x; if !(_type in _unitTypes) then {_unitTypes = _unitTypes + [_type]}} foreach _units;
	_unitCount = count _unitTypes;

	//--- General types
	_displayname = gettext (configfile >> "cfgvehicles" >> "Man" >> "displayname");
	_unitInfo = _unitInfo + format [_textLarge,_displayname,count _units,_sizeLarge];
	_lineCount = _lineCount + _sizeLarge;

	if (_unitCount <= _showlimit) then {

		//--- Detail types
		{
			_class = _x;
			_displayname = gettext (configfile >> "cfgvehicles" >> _x >> "displayname");
			_typeCount = {typeof _x == _class && alive _x} count _units;
			_unitInfo = _unitInfo + format [_textSmall,_displayname,_typeCount,_sizeSmall];
		} foreach _unitTypes;
	};

	//--- Count vehicles
	_vehTypes = [];
	_vehInfo = "";
	_vehCount = 0;
	_result = [];
	if (count _vehicles > 0) then {
		//_vehInfo = "<t size='0.5' align='center' color='#ffffff'>----------------------------------------------------------------</t><br />";
		_vehInfo = "";
		{
			_type = typeof _x;
			if !(_type in _vehTypes) then {_vehTypes = _vehTypes + [_type]};
		} foreach _vehicles;
		_vehCount = count _vehTypes;

		//--- General types (CASE SENSITIVE!)
		_classes = ["Wheeled_APC","Tracked_APC","Car","Tank","Helicopter","Plane","Ship","StaticCannon","StaticMortar"];
		_names = [localize "STR_DN_APC" + " (Wheeled)",localize "STR_DN_APC" + " (Tracked)","","","","","","",""];
		_db = [];
		{
			_class = _x;
			_id = _classes find _class;

			_typeCount = {
				_veh = _x;
				_parents = ([configfile >> "cfgvehicles" >> typeof _veh,true] call bis_fnc_returnParents) - [_class];

				if (_veh iskindof _class) then {
					_limitValue = {_class iskindof _x} count (_classes - [_class]);
					if ({_x in _parents} count _classes == _limitvalue) then {true} else {false};
				} else {false};

			} count _vehicles;

			if (_typeCount > 0) then {

				_displaynameCategory = gettext (configfile >> "cfgvehicles" >> _class >> "displayname");
				if ((_names select _id) != "") then {_displaynameCategory = _names select _id};
				_vehInfo = _vehInfo + format [_textLarge,_displaynameCategory,_typeCount,_sizeLarge];
				_lineCount = _lineCount + _sizeLarge + 0.5;
				if (_typeCount > _showlimit) exitwith {};


				_tempArray = [];
				//--- Detail types
				{
					_type = _x;
					_displayname = gettext (configfile >> "cfgvehicles" >> _x >> "displayname");
					_typeCountSub = {typeof _x == _type && _x iskindof _class} count _vehicles;

					if (_typeCountSub > 0) then {
						_tempArray = _tempArray + [[_displayname,_typeCountSub]];
						_vehInfo = _vehInfo + format [_textSmall,_displayname,_typeCountSub,_sizeSmall];
						_vehTypes = _vehTypes - [_type]
					};
				} foreach _vehTypes;
				_result set [_id,[_displaynameCategory,_typeCount,_tempArray]];
			};
		} foreach _classes;
	};
/*
	{
		_categoryName = _x select 0;
		_categoryCount = _x select 1;
		_items = _x select 2;

		_vehInfo = _vehInfo + format [_textLarge,_categoryName,_categoryCount,_sizeLarge];
		{
			_itemName = _x select 0;
			_itemCount = _x select 1;
			_vehInfo = _vehInfo + format [_textSmall,_itemName,_itemCount,_sizeSmall];
			
		} foreach _items;
		
	} foreach _result;
*/




	//--- Display text
	terminate _loading;
	_text = parsetext (
		"<t size='1.3' color='#ffffff' font='PuristaMedium' underline='true' align='left'>SITREP</t>" + 
		format ["<t size='0.9' align='right'>%1</t><br />",[daytime] call bis_fnc_timetostring] + 
	 	_textIcons + "<br />" + 
		format ["<t>%1</t>",_unitInfo] + 
		format ["<t>%1</t>",_vehInfo] + 
		""
	);
	hint _text;