_colorBlack = [0,0,0];
_colorBlue = [0,0,1];
_colorGreen = [0,1,0];
_colorRed = [1,0,0];
_colorWhite = [1,1,1];

AIC_COLOR_RED = ["RED",_colorRed];
AIC_COLOR_GREEN = ["GREEN",_colorGreen];
AIC_COLOR_BLUE = ["BLUE",_colorBlue];
AIC_COLOR_BLACK = ["BLACK",_colorBlack];
AIC_COLOR_WHITE = ["WHITE",_colorWhite];

_colors = [AIC_COLOR_RED,AIC_COLOR_GREEN,AIC_COLOR_BLUE,AIC_COLOR_BLACK,AIC_COLOR_WHITE];
_groupIconTypes = ["inf","air"];
_wpIconTypes = ["alpha","bravo","move"];

AIC_UNSELECTED_GROUP_SELECTOR_ICON = ["AICommand\images\group_selector_dashed.paa",48,48,0,_colorBlack + [0.5]] call AIC_fnc_createMapIcon;
AIC_SELECTED_GROUP_SELECTOR_ICON = ["AICommand\images\group_selector.paa",48,48,0,_colorBlack + [1]] call AIC_fnc_createMapIcon;
AIC_MOUSE_OVER_GROUP_SELECTOR_ICON = ["AICommand\images\group_selector_dashed.paa",52,52,0,_colorBlack + [0.8]] call AIC_fnc_createMapIcon;
AIC_PICKED_UP_SELECTOR_ICON = ["AICommand\images\group_selector.paa",52,52,1,_colorBlack + [1]] call AIC_fnc_createMapIcon;

{
	_color = _x;
	{
		_iconType = _x;
		missionNamespace setVariable ["AIC_UNSELECTED_GROUP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\group_"+toLower _iconType+"_icon.paa",32,32,0,(_color select 1) + [0.5]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_SELECTED_GROUP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\group_"+toLower _iconType+"_icon.paa",32,32,0,(_color select 1) + [1]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_MOUSE_OVER_GROUP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\group_"+toLower _iconType+"_icon.paa",32,32,0,(_color select 1) + [0.8]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_PICKED_UP_GROUP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\group_"+toLower _iconType+"_icon.paa",36,36,1,(_color select 1) + [1]] call AIC_fnc_createMapIcon)];
	} forEach _groupIconTypes;
} forEach _colors;

{
	_color = _x;
	{
		_iconType = _x;
		missionNamespace setVariable ["AIC_UNSELECTED_WP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\wp_"+toLower _iconType+"_icon.paa",20,20,0,(_color select 1) + [0.5]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_SELECTED_WP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\wp_"+toLower _iconType+"_icon.paa",20,20,0,(_color select 1) + [1]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_MOUSE_OVER_WP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\wp_"+toLower _iconType+"_icon.paa",22,22,0,(_color select 1) + [0.8]] call AIC_fnc_createMapIcon)];
		missionNamespace setVariable ["AIC_PICKED_UP_WP_ICON_"+toUpper (_color select 0)+"_"+toUpper _iconType,(["AICommand\images\wp_"+toLower _iconType+"_icon.paa",22,22,1,(_color select 1) + [1]] call AIC_fnc_createMapIcon)];
	} forEach _wpIconTypes;
} forEach _colors;


A_GO_CODE_ICON = ["AICommand\images\wp_alpha_icon.paa",15,15,0,_colorWhite + [1]] call AIC_fnc_createMapIcon;
B_GO_CODE_ICON = ["AICommand\images\wp_bravo_icon.paa",15,15,0,_colorWhite + [1]] call AIC_fnc_createMapIcon;
/*
AIC_BLACK_UNSELECTED_GROUP_ICON = ["s1.paa",48,48,0,_colorBlack + [0.5]] call AIC_fnc_createMapIcon;
AIC_BLACK_SELECTED_GROUP_ICON = ["s2.paa",48,48,0,_colorBlack + [1]] call AIC_fnc_createMapIcon;
AIC_BLACK_MOUSE_OVER_GROUP_ICON = ["s1.paa",52,52,0,_colorBlack + [0.8]] call AIC_fnc_createMapIcon;
AIC_BLACK_PICKED_UP_GROUP_ICON = ["s2.paa",52,52,1,_colorBlack + [1]] call AIC_fnc_createMapIcon;

AIC_BLACK_UNSELECTED_INFANTRY_ICON = ["n_inf",32,32,0,_colorBlue + [0.5]] call AIC_fnc_createMapIcon;
AIC_BLACK_SELECTED_INFANTRY_ICON = ["n_inf",32,32,0,_colorBlue + [1]] call AIC_fnc_createMapIcon;
AIC_BLACK_MOUSE_OVER_INFANTRY_ICON = ["n_inf",32,32,0,_colorBlue + [0.8]] call AIC_fnc_createMapIcon;
AIC_BLACK_PICKED_UP_INFANTRY_ICON = ["n_inf",36,36,1,_colorBlue + [1]] call AIC_fnc_createMapIcon;

AIC_BLACK_GROUP_ICON_SET = [];
AIC_BLACK_GROUP_ICON_SET pushBack [AIC_BLACK_UNSELECTED_GROUP_ICON,AIC_BLACK_UNSELECTED_INFANTRY_ICON];
AIC_BLACK_GROUP_ICON_SET pushBack [AIC_BLACK_SELECTED_GROUP_ICON,AIC_BLACK_SELECTED_INFANTRY_ICON];
AIC_BLACK_GROUP_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_GROUP_ICON,AIC_BLACK_MOUSE_OVER_INFANTRY_ICON];
AIC_BLACK_GROUP_ICON_SET pushBack [AIC_BLACK_PICKED_UP_GROUP_ICON,AIC_BLACK_PICKED_UP_INFANTRY_ICON];

AIC_BLACK_GROUP_A_ICON_SET = [];
AIC_BLACK_GROUP_A_ICON_SET pushBack [AIC_BLACK_UNSELECTED_GROUP_ICON,AIC_BLACK_UNSELECTED_INFANTRY_ICON,A_GO_CODE_ICON];
AIC_BLACK_GROUP_A_ICON_SET pushBack [AIC_BLACK_SELECTED_GROUP_ICON,AIC_BLACK_SELECTED_INFANTRY_ICON,A_GO_CODE_ICON];
AIC_BLACK_GROUP_A_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_GROUP_ICON,AIC_BLACK_MOUSE_OVER_INFANTRY_ICON,A_GO_CODE_ICON];
AIC_BLACK_GROUP_A_ICON_SET pushBack [AIC_BLACK_PICKED_UP_GROUP_ICON,AIC_BLACK_PICKED_UP_INFANTRY_ICON,A_GO_CODE_ICON];

AIC_BLACK_GROUP_B_ICON_SET = [];
AIC_BLACK_GROUP_B_ICON_SET pushBack [AIC_BLACK_UNSELECTED_GROUP_ICON,AIC_BLACK_UNSELECTED_INFANTRY_ICON,B_GO_CODE_ICON];
AIC_BLACK_GROUP_B_ICON_SET pushBack [AIC_BLACK_SELECTED_GROUP_ICON,AIC_BLACK_SELECTED_INFANTRY_ICON,B_GO_CODE_ICON];
AIC_BLACK_GROUP_B_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_GROUP_ICON,AIC_BLACK_MOUSE_OVER_INFANTRY_ICON,B_GO_CODE_ICON];
AIC_BLACK_GROUP_B_ICON_SET pushBack [AIC_BLACK_PICKED_UP_GROUP_ICON,AIC_BLACK_PICKED_UP_INFANTRY_ICON,B_GO_CODE_ICON];

AIC_BLACK_UNSELECTED_WP_ICON = ["wp_icon.paa",20,20,0,_colorRed + [0.5]] call AIC_fnc_createMapIcon;
AIC_BLACK_SELECTED_WP_ICON = ["wp_icon.paa",20,20,0,_colorRed + [1]] call AIC_fnc_createMapIcon;
AIC_BLACK_MOUSE_OVER_WP_ICON = ["wp_icon.paa",22,22,0,_colorRed + [0.8]] call AIC_fnc_createMapIcon;
AIC_BLACK_PICKED_UP_WP_ICON = ["wp_icon.paa",22,22,1,_colorRed + [1]] call AIC_fnc_createMapIcon;

AIC_BLACK_WP_ICON_SET = [];
AIC_BLACK_WP_ICON_SET pushBack [AIC_BLACK_UNSELECTED_WP_ICON];
AIC_BLACK_WP_ICON_SET pushBack [AIC_BLACK_SELECTED_WP_ICON];
AIC_BLACK_WP_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_WP_ICON];
AIC_BLACK_WP_ICON_SET pushBack [AIC_BLACK_PICKED_UP_WP_ICON];

AIC_BLACK_UNSELECTED_A_WP_ICON = ["wp_icon_a.paa",20,20,0,_colorRed + [0.5]] call AIC_fnc_createMapIcon;
AIC_BLACK_SELECTED_A_WP_ICON = ["wp_icon_a.paa",20,20,0,_colorRed + [1]] call AIC_fnc_createMapIcon;
AIC_BLACK_MOUSE_OVER_A_WP_ICON = ["wp_icon_a.paa",22,22,0,_colorRed + [0.8]] call AIC_fnc_createMapIcon;
AIC_BLACK_PICKED_UP_A_WP_ICON = ["wp_icon_a.paa",22,22,1,_colorRed + [1]] call AIC_fnc_createMapIcon;

AIC_BLACK_WP_A_ICON_SET = [];
AIC_BLACK_WP_A_ICON_SET pushBack [AIC_BLACK_UNSELECTED_A_WP_ICON];
AIC_BLACK_WP_A_ICON_SET pushBack [AIC_BLACK_SELECTED_A_WP_ICON];
AIC_BLACK_WP_A_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_A_WP_ICON];
AIC_BLACK_WP_A_ICON_SET pushBack [AIC_BLACK_PICKED_UP_A_WP_ICON];

AIC_BLACK_UNSELECTED_B_WP_ICON = ["wp_icon_b.paa",20,20,0,_colorRed + [0.5]] call AIC_fnc_createMapIcon;
AIC_BLACK_SELECTED_B_WP_ICON = ["wp_icon_b.paa",20,20,0,_colorRed + [1]] call AIC_fnc_createMapIcon;
AIC_BLACK_MOUSE_OVER_B_WP_ICON = ["wp_icon_b.paa",22,22,0,_colorRed + [0.8]] call AIC_fnc_createMapIcon;
AIC_BLACK_PICKED_UP_B_WP_ICON = ["wp_icon_b.paa",22,22,1,_colorRed + [1]] call AIC_fnc_createMapIcon;

AIC_BLACK_WP_B_ICON_SET = [];
AIC_BLACK_WP_B_ICON_SET pushBack [AIC_BLACK_UNSELECTED_B_WP_ICON];
AIC_BLACK_WP_B_ICON_SET pushBack [AIC_BLACK_SELECTED_B_WP_ICON];
AIC_BLACK_WP_B_ICON_SET pushBack [AIC_BLACK_MOUSE_OVER_B_WP_ICON];
AIC_BLACK_WP_B_ICON_SET pushBack [AIC_BLACK_PICKED_UP_B_WP_ICON];
*/