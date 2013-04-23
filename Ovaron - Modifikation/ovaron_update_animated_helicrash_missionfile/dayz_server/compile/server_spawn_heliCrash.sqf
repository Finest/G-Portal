private["_position","_veh","_num","_config","_itemType","_itemChance","_weights","_index","_iArray", "_staticcoords","_spawnFire","_fadeFire"];
	
waitUntil{!isNil "BIS_fnc_selectRandom"};
if (isDedicated) then {
	_spawnFire = true;
	_fadeFire = false;
	_staticcoords =
		[

[1499.3953, 4273.0962],
[1499.3953, 4273.0962],
[1656.6931, 3972.688],
[1276.3408, 3258.3906],
[1931.4675, 3471.8267],
[2354.9221, 3594.6667],
[1970.3217, 3111.0864],
[1682.486, 2350.4993],
[2815.6802, 2083.0732],
[1584.2495, 1675.6866],
[1350.2794, 784.57556],
[1276.9048, 822.65509],
[1982.9723, 1697.3888],
[2474.1721, 1689.3657],
[3346.6992, 1951.8677],
[3425.2402, 2377.4546],
[4074.925, 2167.8142],
[1814.3822, 534.46167],
[4102.752, 1446.1444],
[4550.3394, 1972.9639],
[3619.5681, 2794.0752],
[4080.3738, 3207.1357],
[3707.7224, 3548.0098],
[3347.0913, 3668.3184],
[2826.1804, 3692.3804],
[4917.8398, 3548.0098],
[3984.2068, 4562.6133],
[3363.1206, 5288.4761],
[2898.3076, 5140.0952],
[4120.4448, 5408.7852],
[3827.9336, 6102.5659],
[3427.2327, 6491.5645],
[2838.2029, 6266.9878],
[1427.7357, 4887.4473],
[1547.9458, 5412.7954],
[1796.3806, 5833.876],
[2277.2217, 5364.6719],
[574.24316, 7417.9404],
[574.24316, 7213.417],
[570.23615, 6956.7578],
[922.85284, 7020.9219],
[1395.6799, 6748.2227],
[1748.2966, 7245.4985],
[1211.3574, 8015.4746],
[2116.9414, 8187.9175],
[2738.0276, 8035.5264],
[2911.8794, 7425.7056],
[2735.6816, 6738.4238],
[2189.0171, 6892.1582],
[3282.3464, 8881.6592],
[4018.7622, 8944.9609],
[3670.8848, 9035.3926],
[3960.0295, 9107.7383],
[3341.0786, 8031.5991],
[4136.2275, 8212.4629],
[4050.3872, 8081.3369],
[3367.7144, 7147.6621],
[3471.0864, 7210.127],
[3746.0957, 7327.2485],
[3605.6653, 6663.562],
[4052.3115, 7538.0664],
[4364.3784, 6671.3711],
[4598.4287, 7356.5288],
[5576.8169, 4210.0825],
[4709.0835, 4935.9463],
[5809.9395, 5272.9551],
[4961.6333, 6083.0713],
[5395.5, 2661.1406],
[6230.855, 2188.0317],
[6237.3311, 1228.8544],
[6574.0635, 1319.588],
[7072.686, 1676.0394],
[7500.0771, 1591.7859],
[7266.9541, 2440.7886],
[6289.1357, 2842.6062],
[5499.1104, 3315.7141],
[7312.2847, 3205.5383],
[6768.3325, 3432.3706],
[7234.5771, 3762.8984],
[7700.8213, 3937.8838],
[8121.7373, 3224.981],
[9662.9355, 3257.3857],
[9675.8867, 2952.7813],
[9669.4111, 2700.0256],
[8970.0449, 3477.7373],
[8516.75, 2991.6675],
[8089.3594, 2058.4136],
[7908.042, 4385.0684],
[8743.3965, 4767.4434],
[8872.9102, 5655.3301],
[7098.5884, 4845.2144],
[6820.1372, 6167.3242],
[5680.4272, 6303.4238],
[8804.627, 6274.812],
[7555.542, 6816.2329],
[7597.3247, 6177.9731],
[9116.8984, 5709.1821],
[7564.3389, 5308.6191],
[8257.0527, 7016.5146],
[8098.7188, 7386.2656],
[7722.6738, 7544.7305],
[7805.3555, 8119.8335],
[8455.7188, 7909.9814],
[8648.5742, 8489.1484],
[7838.6421, 8504.4414],
[5811.2686, 8208.7529],
[6157.6538, 8738.9531],
[6957.3965, 8009.9277],
[6121.9961, 6918.9395],
[5199.999, 7795.8096],
[6269.7192, 5664.8115]];
	
	_position = _staticcoords select (floor random (count _staticcoords));
	_veh = createVehicle ["HMMWVWreck",_position, [], 0, "CAN_COLLIDE"];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];
	diag_log("DEBUG: Spawning HeliCrash at " + str(_position) + "");
	_veh setVariable ["ObjectID",1,true];
	dayzFire = [_veh,2,time,false,false];
	publicVariable "dayzFire";
	if (isServer) then {
		//waitUntil{!isNil "BIS_Effects_Burn"};
		nul=dayzFire spawn BIS_Effects_Burn;
	};

	_num = round(random 4) + 3;
	_config = 		configFile >> "CfgBuildingLoot" >> "HeliCrash";
	_itemType =
		[["FN_FAL", "weapon"],
		["M14_EP1", "weapon"],

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
		["FoodBox1", "object"],

		["Skin_Camo1_DZ", "magazine"],
		["Skin_Sniper1_DZ", "magazine"],

		["M4A1_AIM_SD_camo", "weapon"],
		["bizon_silenced", "weapon"],
		["MP5SD", "weapon"],

		["AK_107_pso", "weapon"],
		["M4A1_RCO_GL", "weapon"],
		["M4SPR", "weapon"],
		["G36K_camo", "weapon"],

		["M40A3", "weapon"],
		["DMR", "weapon"],
		["SVD_des_EP1", "weapon"],
		["KPFS_MG1", "weapon"],
		["KPFS_MP5A3SD", "weapon"],
		["SVD", "weapon"]];

	_itemChance =
		[0.02,
		0.015,

		0.015,
		0.005,
		0.01,
		0.02,

		0.005,
		0.01,
		0.02,

		0.015,
		0.015,
		0.02,
		0.005,

		0.005,
		0.02,

		0.01,
		0.02,
		0.02,

		0.02,
		0.015,
		0.015,
		0.02,

		0.005,
		0.01,
		0.01,
		0.01,
		0.03,
		0.01];

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
			_iArray set [2,_position];
			_iArray set [3,5];
			_iArray call spawn_loot;
			_nearby = _position nearObjects ["WeaponHolder",20];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};
	};
};