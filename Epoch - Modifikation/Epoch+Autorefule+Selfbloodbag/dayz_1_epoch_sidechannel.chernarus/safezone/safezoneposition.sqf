/*
 Name: Safezone
 Date: 15/7/2013
 Mod: Dayz Epoch
 Map: Chernarus
*/

// Trader City Stary
_this = createTrigger ["EmptyDetector", [6325.6772, 7807.7412, 0]];
_this setTriggerArea [100, 100, 0, false];
_this setTriggerActivation ["NONE", "PRESENT", true];
_this setTriggerStatements ["(player distance trading_post1) < 100;", "inSafeZone = true; canbuild = false;", "inSafeZone = false; canbuild = true;"];
trading_post1 = _this;
_trigger_0 = _this;
[[6325.6772, 7807.7412, 0],100] execVM "safezone\SAR_nuke_zeds.sqf";

// Trader City Bash
_this = createTrigger ["EmptyDetector", [4063.4226, 11664.19, 0]];
_this setTriggerArea [100, 100, 0, false];
_this setTriggerActivation ["NONE", "PRESENT", true];
_this setTriggerStatements ["(player distance trading_post2) < 100;", "inSafeZone = true; canbuild = false;", "inSafeZone = false; canbuild = true;"];
trading_post2 = _this;
_trigger_1 = _this;
[[4063.4226, 11664.19, 0],100] execVM "safezone\SAR_nuke_zeds.sqf";

// Trader City Klen
_this = createTrigger ["EmptyDetector", [11447.472, 11364.504, 0]];
_this setTriggerArea [100, 100, 0, false];
_this setTriggerActivation ["NONE", "PRESENT", true];
_this setTriggerStatements ["(player distance trading_post3) < 100;", "inSafeZone = true; canbuild = false;", "inSafeZone = false; canbuild = true;"];
trading_post3 = _this;
_trigger_2 = _this;
[[11447.472, 11364.504, 0],100] execVM "safezone\SAR_nuke_zeds.sqf";