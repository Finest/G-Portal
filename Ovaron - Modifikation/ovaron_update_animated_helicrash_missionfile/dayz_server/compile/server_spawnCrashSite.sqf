//Animated Helicrashs for DayZ 1.7.6.1
//Version 0.2
//Release Date: 05. April 2013
//Author: Grafzahl
//Thread-URL: http://opendayz.net/threads/animated-helicrashs-0-1-release.9084/

private["_useStatic","_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_safetyPoint","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName"];

//_crashModel	= _this select 0;
//_lootTable	= _this select 1;
_guaranteedLoot = _this select 0;
_randomizedLoot = _this select 1;
_frequency	= _this select 2;
_variance	= _this select 3;
_spawnChance	= _this select 4;
_spawnMarker	= _this select 5;
_spawnRadius	= _this select 6;
_spawnFire	= _this select 7;
_fadeFire	= _this select 8;

if(count _this > 9) then {
	_useStatic = _this select 9;
} else {
	_useStatic = false;
};

if(count _this > 10) then {
	_preWaypoints	= _this select 10;
} else {
	_preWaypoints = 1;
};

if(count _this > 11) then {
	_crashDamage = _this select 11;
} else {
	_crashDamage = 1;
};

diag_log(format["CRASHSPAWNER: Starting spawn logic for animated helicrashs - written by dayzforum.net / Grafzahl [SC:%1||PW:%2||CD:%3]", str(_useStatic), str(_preWaypoints), _crashDamage]);

while {true} do {
	private["_timeAdjust","_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	// Allows the variance to act as +/- from the spawn frequency timer
	_timeAdjust = round(random(_variance * 2) - _variance);
	_timeToSpawn = time + _frequency + _timeAdjust;

	//Random Heli-Type
	_heliModel = "UH1H_DZ";

	//Random-Startpositions, Adjust this for other Maps then Chernarus
	_heliStart = [[3461.92,5021.77,0],[8582.35,14077.7,0]] call BIS_fnc_selectRandom;

	//A Backup Waypoint, if not Chernarus, set some Coordinates far up in the north (behind all possible Crashsites)
	_safetyPoint = [8450.08,20240,0];

	//Settings for the Standard UH1H_DZ
	_crashModel = "UH1Wreck_DZ";
	_exploRange = 195;
	_lootRadius = 0.35;

	//Adjust Wreck and Range of Explosion if its a Mi17_DZ
	if(_heliModel == "Mi17_DZ") then {
		_crashModel = "Mi8Wreck";
		_exploRange = 285;
		_lootRadius = 0.3;
	};

	//Crash loot just uncomment the one you wish to use by default with 50cals is enabled.
    //Table including 50 cals
    //_lootTable = ["Military"] call BIS_fnc_selectRandom;
    //Table without 50 cals
    _lootTable = ["HeliCrash","HeliCrash_No50s","MilitarySpecial"] call BIS_fnc_selectRandom;

	_crashName	= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");

	diag_log(format["CRASHSPAWNER: %1%2 chance to start a crashing %3 with loot table '%4' at %5", round(_spawnChance * 100), '%', _crashName, _lootTable, _timeToSpawn]);

	// Apprehensive about using one giant long sleep here given server time variances over the life of the server daemon
	while {time < _timeToSpawn} do {
		sleep 5;
	};

	_spawnRoll = random 1;

	// Percentage roll
	if (_spawnRoll <= _spawnChance) then {

/*
==================================================================================================
		_staticcoords give you the possibility to organize your crashsites!

		Crashsites close to cherno or electro would be possible with that.
		Use the editor for your map, create some vehicles or triggers at points where you
		want your crashside (aprox), save it and extract all coordinates and put them in this
		2D-Array. If you dont know how to do this, dont use _staticcoords.

		I would advise you to create at least 100 positions, otherwise its too easy for your players
		to find the crash-locations after some time of playing on your server.

		!!!!!After you put in the coordinates you have to set _useStatic to true inside
		your server_monitor.sqf, default is false!!!!!
==================================================================================================
*/

		_staticcoords =	[
				[1546.0145,1189.588,0],
				[1486.5698,786.50452,0],
				[1193.8884,876.80115,0],
				[830.90356,1682.2198,0],
				[1722.1583,1611.0406,0],
				[1372.2612,2080.1411,0],
				[1900.408,2121.9849,0],
				[2179.4827,1748.6047,0],
				[2639.6287,1497.4597,0],
				[1792.6497,1839.5166,0],
				[2541.5859,1971.7047,0],
				[2540.2244,2312.3994,0],
				[2146.4614,2440.0225,0],
				[1698.3608,2561.0332,0],
				[748.81458,2988.1318,0],
				[1543.949,3033.8354,0],
				[2094.7568,3468.3447,0],
				[2373.4016,4285.4805,0],
				[2859.4089,3922.3091,0],
				[1692.9912,4363.3032,0],
				[882.97961,3948.25,0],
				[986.66083,4940.4858,0],
				[1317.1454,4895.0889,0],
				[1129.2224,5725.1963,0],
				[597.854,7061.1484,0],
				[1386.7559,6665.5205,0],
				[2358.25,6075.2197,0],
				[1755.7972,6059.4365,0],
				[2383.4836,6760.2207,0],
				[2310.937,7157.9639,0],
				[1963.9746,7038.0098,0],
				[831.61615,7363.1484,0],
				[856.84973,8916.2393,0],
				[1465.6108,8231.2383,0],
				[1932.4327,8127.0664,0],
				[2648.437,7943.979,0],
				[2367.7126,7650.4072,0],
				[2916.5439,8155.4766,0],
				[2295.166,8720.5244,0],
				[2837.689,8897.2988,0],
				[3645.1646,7378.9316,0],
				[3837.5706,8316.4688,0],
				[3033.249,7618.8403,0],
				[2711.5205,7066.4199,0],
				[4373.7847,8550.0625,0],
				[3822.0828,8983.3584,0],
				[4081.5701,8983.1699,0],
				[4060.6272,8721.623,0],
				[4247.5259,7660.4014,0],
				[5531.5601,8050.3511,0],
				[6016.7437,8744.5889,0],
				[6269.3599,8146.6611,0],
				[5916.4995,7283.8799,0],
				[6353.5649,7215.6592,0],
				[6766.5723,7645.0439,0],
				[7404.127,8331.2559,0],
				[7472.2939,8945.2354,0],
				[7736.9385,7837.665,0],
				[8414.5908,8106.5322,0],
				[8667.2061,9125.8184,0],
				[9016.0576,9402.7109,0],
				[8871.7061,8022.2598,0],
				[7712.4502,7530.4902,0],
				[7979.0474,7441.7749,0],
				[8197.1602,7381.1396,0],
				[7921.9219,7116.0786,0],
				[8567.6084,7161.1221,0],
				[8093.2979,7843.6973,0],
				[8553.7598,7684.3145,0],
				[8442.2822,6744.3887,0],
				[7462.5078,6819.1221,0],
				[7407.21,6333.2593,0],
				[7719.4756,6516.3477,0],
				[8545.877,5948.1436,0],
				[7807.7935,5657.7285,0],
				[7173.7988,5591.438,0],
				[6662.8179,6266.9688,0],
				[6211.7671,6046.001,0],
				[6394.7114,6712.0615,0],
				[5659.7822,6633.1445,0],
				[6076.1367,5733.4888,0],
				[5060.4839,6191.2085,0],
				[4820.7637,6371.1401,0],
				[4369.7134,6740.4731,0],
				[4565.2739,5736.6465,0],
				[3953.3591,6178.583,0],
				[3830.3447,6620.5186,0],
				[2969.2476,5626.1621,0],
				[3537.0039,5149.502,0],
				[5536.7529,5231.8608,0],
				[5996.1909,4872.2461,0],
				[5676.8457,4529.6016,0],
				[5689.1279,4750.8604,0],
				[5217.7861,4635.6211,0],
				[6314.001,4440.4829,0],
				[6323.2124,4010.2559,0],
				[6899.2432,4739.0405,0],
				[8690.2363,6455.478,0],
				[9315.7627,6286.9341,0],
				[8172.9746,5002.7939,0],
				[8894.7354,5375.9971,0],
				[8201.0439,4160.0776,0],
				[9119.2832,4605.5132,0],
				[9279.6738,5243.5703,0],
				[7840.1636,3742.7319,0],
				[7820.1152,4019.624,0],
				[7515.3716,3273.2178,0],
				[9672.6328,3261.1787,0],
				[9668.6221,2743.5103,0],
				[7936.3984,1491.4728,0],
				[8610.041,1993.0902,0],
				[9355.8594,1338.9813,0],
				[9315.7627,2269.9834,0],
				[9383.9287,2891.9893,0],
				[6545.0049,2839.8206,0],
				[6945.9824,2518.7854,0],
				[7342.9512,2085.3882,0],
				[5883.3926,1768.3655,0],
				[7399.0874,1318.916,0],
				[7763.9775,2578.9795,0],
				[4121.146,4494.0645,0],
				[5145.7285,3973.717,0],
				[5456.6709,3682.9346,0],
				[4289.3608,3024.8486,0],
				[3325.9473,2815.6897,0],
				[4014.0996,2040.2698,0],
				[4661.4727,2234.1255,0],
				[3993.7104,1213.8367,0],
				[2431.2437,2944.0337,0]
						];

		if(_useStatic) then {
			_position = _staticcoords call BIS_fnc_selectRandom;
		} else {
			_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
		};
		//DEFAULT: GET COORDS FROM BIS_fnc_findSafePos, COMMENT OUT IF YOU USE _STATICCOORDS

		diag_log(format["CRASHSPAWNER: %1 started flying from %2 to %3 NOW!(TIME:%4||LT:%5)", _crashName,  str(_heliStart), str(_position), round(time), _lootTable]);

		//Spawn the AI-Heli flying in the air
		_startTime = time;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];

		//Make sure its not destroyed by the Hacker-Killing-Cleanup (Thanks to Sarge for the hint)
		_crashwreck setVariable["Sarge",1];

		_crashwreck engineOn true;
		_crashwreck flyInHeight 120;
		_crashwreck forceSpeed 140;
		_crashwreck setspeedmode "LIMITED";

		//Create an Invisibile Landingpad at the Crashside-Coordinates
		_landingzone = createVehicle ["HeliHEmpty", [_position select 0, _position select 1,0], [], 0, "CAN_COLLIDE"];
		_landingzone setVariable["Sarge",1];

		//Only a Woman could crash a Heli this way...
		_aigroup = creategroup civilian;
		_helipilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		sleep 0.5;

		if(_preWaypoints > 0) then {
			for "_x" from 1 to _preWaypoints do {
				if(_useStatic) then {
					_preWaypointPos = _staticcoords call BIS_fnc_selectRandom;
				} else {
					_preWaypointPos = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
				};
				diag_log(format["CRASHSPAWNER: Adding Pre-POC-Waypoint #%1 on %2", _x,str(_preWaypointPos)]);
				_wp = _aigroup addWaypoint [_preWaypointPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			};
		};

		_wp2 = _aigroup addWaypoint [position _landingzone, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";

		//Even when the Heli flys to high, it will burn when reaching its Waypoint
		_wp2 setWaypointStatements ["true", "_crashwreck setdamage 1;"];

		//Adding a last Waypoint up in the North, so the Heli doesnt Hover at WP1 (OR2)
		//and would also come back to WP1 if somehow it doesnt explode.
		_wp3 = _aigroup addWaypoint [_safetyPoint, 0];
		_wp3 setWaypointType "CYCLE";
		_wp3 setWaypointBehaviour "CARELESS";

		//Get some more Speed when close to the Crashpoint and go on even if Heli died or hit the ground
		waituntil {(_crashwreck distance _position) <= 1000 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			_crashwreck flyInHeight 95;
			_crashwreck forceSpeed 160;
			_crashwreck setspeedmode "NORMAL";

		//BOOOOOOM!
		waituntil {(_crashwreck distance _position) <= _exploRange || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			//Taking out the Tailrotor would be more realistic, but makes the POC not controllable
			//_crashwreck setHit ["mala vrtule", 1];
			_crashwreck setdamage 1;
			_crashwreck setfuel 0;
			diag_log(format["CRASHSPAWNER: %1 just exploded at %2!, ", _crashName, str(getPosATL _crashwreck)]);

			//She cant survive this :(
			_helipilot setdamage 1;

			//Giving the crashed Heli some time to find its "Parkingposition"
			sleep 13;

		//Get position of the helis wreck, but make sure its on the ground;
		_pos = [getpos _crashwreck select 0, getpos _crashwreck select 1,0];

		//saving the direction of the wreck(not used right now)
		_dir = getdir _crashwreck; 

		//Send Public Variable so every client can delete the craters around the new Wreck (musst be added in init.sqf)
		heliCrash = _pos;
		publicVariable "heliCrash";
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		deletevehicle _landingzone;

		//Animation is done, lets create the actual Crashside
		_crash = createVehicle [_crashModel, _pos, [], 0, "CAN_COLLIDE"];
		_crash setVariable["Sarge",1];

		//If you want all Grass around the crashsite to be cutted: Uncomment the next Line (Noobmode)
		//_crashcleaner = createVehicle ["ClutterCutter_EP1", _pos, [], 0, "CAN_COLLIDE"];

		//Setting the Direction would add realism, but it sucks because of the bugged model when not on plane ground.
		//If you want it anyways, just uncomment the next line
		//_crash setDir _dir;

		// I don't think this is needed (you can't get "in" a crash), but it was in the original DayZ Crash logic
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crash];

		_crash setVariable ["ObjectID",1,true];

		//Make it burn (or not)
		if (_spawnFire) then {
			//["dayzFire",[_crash,2,time,false,_fadeFire]] call broadcastRpcCallAll;
			dayzFire = [_crash,2,time,false,_fadeFire];
			publicVariable "dayzFire";
			_crash setvariable ["fadeFire",_fadeFire,true];
		};

		_num        = round(random 4) + 4;
     
        _config = configFile >> "CfgBuildingLoot" >> _lootTable;
        _itemTypes = [["M107_DZ", "weapon"],["Binocular_Vector", "weapon"],["BAF_AS50_scoped", "weapon"], ["MG36_camo", "weapon"], ["FN_FAL","weapon"], ["M14_EP1","weapon"], ["FN_FAL_ANPVS4","weapon"], ["Mk_48_DZ","weapon"], ["M249_DZ","weapon"], ["DMR","weapon"], ["G36C","weapon"], ["G36C_camo","weapon"], ["SCAR_H_CQC_CCO", "weapon"], ["G36_C_SD_camo","weapon"], ["G36A_camo","weapon"], ["G36K_camo","weapon"], ["", "military"], ["MedBox0", "object"], ["NVGoggles", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Camo1_DZ", "magazine"], ["Skin_Sniper1_DZ", "magazine"], ["SVD_CAMO","weapon"], ["M24","weapon"], ["M4A1_AIM_SD_camo","weapon"], ["Sa58P_EP1","weapon"], ["Sa58V_CCO_EP1","weapon"], ["Sa58V_EP1","weapon"], ["Sa58V_RCO_EP1","weapon"]];
        _itemChance = [0.01, 0.05, 0.02, 0.01, 0.01, 0.02, 0.05, 0.01, 0.03, 0.05, 0.01, 0.06, 0.03, 0.02, 0.01, 0.02, 0.9, 0.09, 0.01, 0.5, 0.05, 0.05, 0.01, 0.05, 0.05, 0.04, 0.03, 0.05, 0.05, 0.05, 0.04, 0.05];
        _weights = [];
        _weights = [_itemType,_itemChance] call fnc_buildWeightedArray;
        _cntWeights = count _weights;
        _index = _weights call BIS_fnc_selectRandom;

		//Creating the Lootpiles outside of the _crashModel
				for "_x" from 1 to _num do {
			//Create loot
			_index = floor(random _cntWeights);
			_index = _weights select _index;
			_itemType = _itemTypes select _index;

			//Let the Loot spawn in a non-perfect circle around _crashModel
			_lootPos = [_pos, ((random 2) + (sizeOf(_crashModel) * _lootRadius)), random 360] call BIS_fnc_relPos;
			[_itemType select 0, _itemType select 1, _lootPos, 0] call spawn_loot;

			diag_log(format["CRASHSPAWNER: Loot spawn at '%1' with loot table '%2'", _lootPos, sizeOf(_crashModel)]); 

			// ReammoBox is preferred parent class here, as WeaponHolder wouldn't match MedBox0 and other such items.
			_nearby = _pos nearObjects ["ReammoBox", sizeOf(_crashModel)];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};

		//Adding 5 dead soldiers around the wreck, poor guys
		for "_x" from 1 to 5 do {
			_lootPos = [_pos, ((random 4)+3), random 360] call BIS_fnc_relPos;
			_deadBody = createVehicle[["Body1","Body2"] call BIS_fnc_selectRandom,_lootPos,[], 0, "CAN_COLLIDE"];
			_deadBody setDir (random 360);
		};
		_endTime = time - _startTime;
		diag_log(format["CRASHSPAWNER: Crash completed! Wreck at: %2 - Runtime: %1 Seconds || Distance from calculated POC: %3 meters", round(_endTime), str(getPos _crash), round(_position distance _crash)]); 
	};
};