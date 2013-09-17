private["_position","_veh","_num","_config","_itemType","_itemChance","_weights","_index","_iArray", "_staticcoords","_spawnFire","_fadeFire","_lootPos"];
	
//waitUntil{!isNil "BIS_fnc_selectRandom"};
if (isDedicated) then {
	//_spawnFire = false;
	//_fadeFire = false;
	_staticcoords =
		[

[1098.703, 2356.8403],
[1545.0184, 2270.2598],
[1872.4014, 2685.272],
[1716.7837, 3740.4307],
[3023.6978, 2090.0583],
[2658.1201, 2854.553],
[2407.1265, 3646.3523],
[4197.873, 2501.489],
[4422.8145, 2324.2402],
[4833.915, 2451.0315],
[5115.7383, 2284.1335],
[4948.9238, 2846.543],
[4369.8232, 3242.3611],
[3521.6038, 3934.4338],
[5874.0859, 2205.8064],
[6194.3218, 2095.5835],
[7006.7153, 2169.4822],
[7022.8501, 2834.4736],
[6423.3516, 2860.1648],
[6323.2773, 3336.78],
[4360.4644, 4686.8188],
[5836.4751, 4788.5264],
[5260.5884, 3650.377],
[7104.3936, 4522.1514],
[6930.1748, 5582.8096],
[8352.9521, 4933.8228],
[9412.7754, 2047.2803],
[9412.7754, 2047.2803],
[7873.8535, 3495.3945],
[9989.876, 1638.8992],
[10352.197, 1751.3516],
[10392.39, 2444.1929],
[10333.224, 2840.6335],
[10844.018, 2765.5823],
[10118.599, 4126.4146],
[11325.536, 5473.1396],
[10049.234, 5514.7915],
[11956.75, 3890.3896],
[11199.8, 6553.3306],
[11718.78, 9151.2432],
[13115.524, 10433.024],
[9231.1689, 8845.9248],
[5762.5288, 9270.3535],
[12303.575, 10790.627],
[11006.467, 11720.839],
[9633.0557, 13303.59],
[8426.1182, 12081.818],
[6019.1787, 10332.462],
[5131.3169, 12456.68],
[11478.739, 12999.042],
[13345.842, 12815.641],
[12745.606, 11659.411],
[1880.4556, 12170.794],
[3343.8604, 11966.131],
[4188.4385, 11620.593],
[2728.9651, 10070.233],
[2781.8804, 9856.7002],
[2862.2336, 9376.9385],
[2012.0824, 14668.589],
[1944.1124, 7434.4375],
[2657.5032, 7271.2471],
[3035.3269, 7778.7261],
[4417.2729, 6431.043],
[4842.4951, 6937.5176],
[2688.0071, 5602.4077],
[2500.4043, 5093.7871],
[4981.1138, 8165.0483],
[5996.0005, 8001.2275],
[6961.7808, 8033.9902],
[6514.3569, 6794.417],
[8271.3125, 6827.1807],
[9563.6689, 6651.5562],
[10067.996, 7057.0859],
[8649.291, 10751.47],
[7046.9775, 10883.366],
[10481.461, 10084.475],
[10366.576, 9537.4199],
[5770.4673, 11732.571],
[4882.6055, 10837.068],
[2333.6287, 6339.7568],
[9083.5928, 4078.7522],
[9136.4727, 3706.2634],
[12494.015, 6214.4468],
[12058.471, 5134.4155],
[7295.0698, 9871.9912],
[7960.7476, 8703.4063],
[9766.8555, 11012.597]];
	
	_position = _staticcoords select (floor random (count _staticcoords));
	_veh = createVehicle ["HMMWVWreck",_position, [], 0, "CAN_COLLIDE"];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];
	diag_log("DEBUG: Spawning HeliCrash at " + str(_position) + "");
	_veh setVariable ["ObjectID",1,true];
	dayzFire = [_veh,2,time,false,false];
	publicVariable "dayzFire";
	if (isServer) then {
		waitUntil{!isNil "BIS_Effects_Burn"};
		//nul=dayzFire spawn BIS_Effects_Burn;
	};

	_num = round(random 4) + 3;
	_config = 		configFile >> "CfgBuildingLoot" >> "HeliCrash";
	_itemType =
		[["FN_FAL", "weapon"],
		["bizon_silenced", "weapon"],
		["M14_EP1", "weapon"],
		["FN_FAL_ANPVS4", "weapon"],
		["M107_DZ", "weapon"],
		["BAF_AS50_scoped", "weapon"],
		
		["ItemGPS", "generic"],
		["NVGoggles", "weapon"],
		["DZ_Backpack_EP1", "object"],
		["M9SD", "weapon"],

		["Mk_48_DZ", "weapon"],
		["M240_DZ", "weapon"],
		["M249_DZ", "weapon"],

		["AmmoBoxSmall_556", "object"],
		["AmmoBoxSmall_762", "object"],
		["MedBox0", "object"],

		["Skin_Camo1_DZ", "magazine"],
		["Skin_Sniper1_DZ", "magazine"],

		["M4A1_AIM_SD_camo", "weapon"],
		["bizon_silenced", "weapon"],
		["MP5SD", "weapon"],

		["M4A1_RCO_GL", "weapon"],
		["G36A_camo", "weapon"],
		["G36K_camo", "weapon"],

		["M40A3", "weapon"],
		["DMR", "weapon"],
		
		["TrashTinCan", "magazine"],
		["TrashJackDaniels", "magazine"],
		["ItemSodaEmpty", "magazine"],
		["FoodCanPasta", "magazine"],
		["FoodCanUnlabeled", "magazine"]];

	_itemChance =
		[0.05,
		0.05,
		0.03,
		0.015,
		0.001,
		0.001,

		0.005,
		0.005,
		0.2,
		0.2,

		0.005,
		0.01,
		0.02,

		0.09,
		0.09,
		0.1,

		0.11,
		0.11,

		0.01,
		0.10,
		0.10,

		0.015,
		0.015,
		0.02,

		0.005,
		0.01,
		0.10,
		0.10,
		0.05];

	//diag_log ("DW_DEBUG: _itemType: " + str(_itemType));	
	//diag_log ("DW_DEBUG: _itemChance: " + str(_itemChance));	
	//diag_log ("DW_DEBUG: (isnil fnc_buildWeightedArray): " + str(isnil "fnc_buildWeightedArray"));	
	
	waituntil {!isnil "fnc_buildWeightedArray"};
	
	_weights = [];
	_weights = 		[_itemType,_itemChance] call fnc_buildWeightedArray;
	//diag_log ("DW_DEBUG: _weights: " + str(_weights));	
	for "_x" from 1 to _num do {
		//create loot
		_index = _weights call BIS_fnc_selectRandom;
		sleep 1;
		if (count _itemType > _index) then {
			//diag_log ("DW_DEBUG: " + str(count (_itemType)) + " select " + str(_index));
			_iArray = _itemType select _index;
			_lootPos = [_position, ((random 2) + (sizeOf("HMMWVWreck") * 0.35)), random 360] call BIS_fnc_relPos;
			_iArray set [2,_lootPos];
			_iArray set [3,0];
			_iArray call spawn_loot;
			_nearby = _position nearObjects ["WeaponHolder",20];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};
	};
};