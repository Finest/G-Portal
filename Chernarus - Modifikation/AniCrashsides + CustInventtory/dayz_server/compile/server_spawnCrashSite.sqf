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

diag_log(format["CRASHSPAWNER: Starting spawn logic for animated helicrashs - written by Grafzahl [SC:%1||PW:%2||CD:%3]", str(_useStatic), str(_preWaypoints), _crashDamage]);

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
    _lootTable = ["HeliCrashWEST","HeliCrash","HeliCrashEAST","MilitarySpecial"] call BIS_fnc_selectRandom;

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
		/*
											[14462.881,8436.5811,-0.0010375977],	
											[14656.824,8575.6816,0.00015258789],	
											[15929.735,8305.1143,-6.8664551e-005],
											[15624.432,8724.3574,-0.0002784729],
											[16351.484,8960.6992,0.0018539429],
											[16380.191,8202.1182,-0.00016784668],
											[16995.379,8591.4746,0.00018310547],
											[17564.381,8692.748,-0.0017089844],
											[17493.182,8969.4824,0.00085449219],
											[17207.734,9183.6846,-0.0079956055],
											[17543.805,9397.291,-0.0013427734],
											[17387.52,9707.082,-6.1035156e-005],
											[17552.055,10878.121,0.0024108887],
											[16493.992,9853.3027,-1.5258789e-005],
											[16615.383,10234.422,4.5776367e-005],
											[16438.795,11297.799,-0.00019836426],
											[16647.074,11653.172,-0.0030250549],
											[15782.02,9833.0605,3.4332275e-005],
											[15600.346,10103.724,-0.00010681152],
											[17142.385,12776.574,0.00028240681],
											[17290.934,12511.171,5.8174133e-005],
											[17517.137,11902.354,0],
											[16419.703,13333.862,6.6757202e-005],
											[16070.212,13407.104,5.3405762e-005],
											[16442.404,12576.911,-0.0018172264],
											[15279.252,13331.896,0.0027160645],
											[14954.937,13741.839,-0.006072998],
											[16090.981,13987.742,-6.1035156e-005],
											[14625.482,14489.256,0],
											[15687.388,14270.348,-2.6702881e-005],
											[15232.625,14329.199,4.196167e-005],
											[15668.359,14823.523,4.5776367e-005],
											[16388.004,14672.826,-9.727478e-005],
											[16878.008,14944.274,-0.00045871735],
											[16235.282,15899.664,-9.8228455e-005],
											[16082.123,16473.443,-0.00020599365],
											[16066.748,15578.649,-0.00012493134],
											[15589.345,15484.541,0.0021514893],
											[15652.773,16206.569,-3.8146973e-006],
											[14647.629,15309.688,0.00032043457],
											[14201.698,15389.142,0],
											[13743.408,16750.561,-0.0048217773],
											[15319.507,16831.957,0],
											[13894.82,17823.234,-0.00091552734],
											[15075.685,17406.863,-0.00019836426],
											[15153.826,18195.441,1.335144e-005],
											[14753.992,18245.164,-0.00026321411],
											[12874.416,17519.75,0],
											[12627.547,18311.908,0],
											[14059.896,19132.578,0.00021362305],
											[13496.322,19245.686,0.00049591064],
											[10442.094,17804.732,-0.00012207031],
											[9955.3223,18536.211,3.0517578e-005],
											[10557.997,18595.754,0.00024795532],
											[10101.941,19468.684,-0.00051116943],
											[9754.5293,16913.883,0.0010375977],
											[9983.2373,17683.225,0.00059509277],
											[9582.3242,17560.066,0.0046081543],
											[12205.125,17223.713,0],
											[12830.528,16176.641,0],
											[9127.4834,18215.965,0],
											[8940.959,17421.066,0],
											[8924.5576,16557.58,0.00020027161],
											[8461.5371,17434.553,0.00023651123],
											[8925.7236,19535.973,-1.5258789e-005],
											[8529.8213,19637.93,0],
											[8165.4009,21370.047,-4.5776367e-005],
											[9487.832,14953.486,-8.2015991e-005],
											[9791.3398,14200.095,-0.00031089783],
											[10734.399,14458.267,-0.002199173],
											[13605.25,15161.754,0.013519287],
											[12433.201,15085.622,3.0517578e-005],
											[11972.195,15037.143,-3.0517578e-005],
											[11882.107,14234.03,-0.002822876],
											[12841.114,14576.897,7.6293945e-006],
											[13954.352,14221.402,0],
											[12998.982,13413.468,-1.9073486e-005],
											[12685.861,13001.497,0.00012588501],	
											[13185.389,13171.09,-5.7220459e-005],
											[12153.033,13794.89,0.0014801025],
											[11945.582,13090.161,-0.0017700195],
											[12092.078,12544.881,9.1552734e-005],
											[13401.143,11917.628,-4.5776367e-005],
											[13514.381,11367.668,-0.001373291],
											[13150.486,11065.189,0.003112793],
											[12582.098,11223.386,-0.00064086914],
											[12109.959,11181.399,0.0014038086],
											[12128.953,12081.538,0.001663208],
											[11208.894,13857.324,-9.1552734e-005],
											[10817.817,14188.646,-0.00060653687],
											[11142.624,13363.823,3.0517578e-005],
											[11391.622,13316.264,0.00030517578],	
											[10099.973,12993.546,5.7220459e-005],
											[10461.569,12208.365,-0.0018634796],
											[10732.77,12759.334,0.00018310547],
											[11221.755,12802.51,0.0015869141],
											[10989.816,12396.012,-0.0021362305],
											[12402.173,10025.783,0.0016784668],
											[12413.129,10550.087,-0.0010070801],
											[12942.833,10401.931,0.00091552734],
											[11772.638,12594.938,0.0084838867],
											[12625.17,10735.71,6.1035156e-005],
											[13240.198,10081.159,0.00042724609],
											[13581.503,9082.7939,-0.0023803711],
											[12997.587,9925.4697,0],
											[13908.983,9367.3672,-0.00012207031],
											[9846.5703,7453.3447,0],
											[10289.112,7139.771,8.392334e-005],
											[10398.396,6539.2036,-8.392334e-005],
											[10312.519,6838.4414,2.2888184e-005],
											[9666.9707,7754.873,-1.5258789e-005],
											[10697.239,6171.6392,0.00012207031],
											[10096.959,5659.8516,0.0011348724],
											[9391.0459,5720.2832,0.00022125244],
											[9435.4863,5378.3877,-4.5776367e-005],
											[9140.2705,5528.5259,-0.00076293945],
											[9012.9297,5190.9746,-0.00028991699],
											[7957.0547,6476.1094,7.6293945e-005],
											[7744.7227,6756.4688,3.8146973e-005],
											[8709.541,7670.6646,-0.00017547607],
											[8303.9941,7773.4399,-0.0005645752],
											[9143.4551,7183.0298,3.0517578e-005],
											[7623.2139,7830.1226,-0.0001449585],
											[6866.8184,8149.499,2.2888184e-005],
											[7672.9858,8768.3906,0.0004119873],
											[7859.4541,9025.8418,7.6293945e-006],
											[7097.0215,9104.7666,-4.5776367e-005],
											[7448.5342,9029.415,-0.00047302246],
											[6793.8325,9917.8203,2.2888184e-005],
											[6337.0142,9939.9287,-7.6293945e-006],
											[6033.8804,9701.2158,5.3405762e-005],
											[5903.4194,9562.9355,3.4332275e-005],
											[5463.5356,9205.3232,0.00014686584],
											[6239.1499,9395.1084,0.00032043457],
											[6393.5938,8597.9248,0.00045776367],
											[5535.9248,8257.4795,-7.6293945e-005],
											[5099.7886,8499.332,0.0001335144],
											[4899.2832,8062.0972,-7.6293945e-006],
											[5994.5889,7905.5459,-0.0020141602],
											[5548.9868,7893.3115,-0.00039672852],
											[5323.5361,7578.3618,-0.00064086914],
											[4491.2563,8168.02,-0.00023651123],
											[4144.3096,7657.624,-1.1444092e-005],
											[6380.1753,7257.4526,-0.00024414063],
											[5716.5586,7112.7871,0.00015258789],
											[6599.9551,6443.3457,0.00012207031],
											[7098.1587,6339.2695,-0.00036621094],
											[7109.7539,5865.957,-0.00018310547],
											[7445.1401,7339.4575,-6.8664551e-005],
											[8626.0088,5641.6797,0],
											[2480.8457,6970.0913,-1.9073486e-005],
											[2198.0732,6687.9199,-1.9073486e-005],
											[1890.1681,6907.9849,2.6702881e-005],
											[1518.172,7188.7827,0.00038909912],
											[1497.6733,7680.127,-2.2888184e-005],
											[2214.7898,7604.498,3.8146973e-006],
											[2478.8013,7555.6494,-1.1444092e-005],
											[2760.1814,7399.4717,1.9073486e-005],	
											[3640.293,7435.4639,-3.8146973e-006],
											[4110.5176,6742.1387,-1.5258789e-005],
											[4207.8262,6434.6831,-5.3405762e-005],
											[4517.4556,6371.332,-1.5258789e-005],
											[4875.062,6267.3711,3.4332275e-005],
											[4769.1958,6905.646,0.00016784668],
											[6003.3848,6449.2783,0.00085449219],
											[5560.5449,5911.498,7.6293945e-006],
											[6314.0742,5720.5889,2.2888184e-005],
											[7524.7383,4804.3521,-7.2479248e-005],
											[7479.7832,4678.6133,-7.6293945e-006],
											[7734.3384,4305.8535,7.6293945e-006],
											[9005.0537,4630.5239,0.00013923645],
											[8235.0273,4750.9678,-0.00026130676],
											[8413.0283,4128.8354,-0.00024414063],
											[8126.958,3298.9043,1.6212463e-005],
											[8376.1777,2732.1941,8.5830688e-006],
											[8632.5645,2860.8882,1.4305115e-005],
											[8959.9482,3289.1672,-0.0010070801],
											[9159.5176,2303.6553,-0.00015258789],
											[9756.9121,1796.3113,0.00039482117],
											[10255.164,2082.53,-0.0002746582],
											[10276.592,1314.4053,-0.00024986267],
											[9940.8584,1540.3037,9.4413757e-005],
											[10579.21,735.18445,9.059906e-005],
											[10634.752,1132.2856,-0.00026321411],
											[10591.179,1754.5161,-9.1552734e-005],
											[11332.326,947.21503,4.0054321e-005],
											[11270.107,466.76169,-1.7166138e-005],
											[11872.971,685.77899,-5.3405762e-005],
											[11400.898,1385.5233,-0.00012207031],
											[10619.795,2486.0061,-7.6293945e-006],
											[9963.0049,3164.5801,0.00012207031],
											[9606.4395,4456.7241,1.5258789e-005],
											[9792.1777,4531.4897,7.6293945e-005],
											[9456.5088,4939.0806,1.5258789e-005],
											[9293.0693,20816.717,0],
											[6382.396,4819.936,2.0027161e-005],
											[10855.823,2832.8794,9.2506409e-005]
											*/
											
											[1119.5856,2477.1587,0],
[2049.4011,4157.042,0],
[2417.7498,5415.9614,0],
[2069.3408,7501.646,0],
[2544.0464,10062.705,0],
[1217.4396,12906.027,0],
[2151.439,14969.227,0],
[4077.5103,14397.729,0],
[5357.3696,12729.261,0],
[9544.4023,13755.705,0],
[13260.243,12955.309,0],
[11709.926,12899.897,0],
[8867.6768,11847.066,0],
[11383.867,12037.931,0],
[12398.957,10911.218,0],
[10702.244,10132.81,0],
[6213.3643,10589.182,0],
[7068.3892,11744.375,0],
[12483.547,9277.1104,0],
[13112.597,10388.799,0],
[12956.182,8103.3271,0],
[9491.5674,8925.1572,7.8262024],
[5456.0376,8721.6582,0],
[4618.7578,11916.813,0],
[4228.1733,10764.493,0],
[4853.8369,9770.4697,0],
[3766.7463,9050.3887,0],
[6871.6016,9167.793,0],
[3422.6311,7962.4419,0],
[4885.1196,6968.4189,0],
[4408.0513,6561.417,0],
[2322.5613,6456.8984,0],
[6590.2856,7638.0596,0],
[7228.6685,7957.4414,0],
[8482.6855,6999.7275,0],
[8121.1787,9119.6113,0],
[4376.8423,7801.8071,0],
[3260.1011,4798.7295,0],
[1667.0132,2137.4954,0],
[2676.1685,2080.5552,0],
[3541.5867,2305.3208,0],
[2834.8782,3417.1665,0],
[4781.3203,2212.4167,0],
[4712.4463,2512.1064,0],
[4981.9536,2362.261,0],
[7179.7217,2637.1555,0],
[6292.5845,2858.1133,0],
[7295.5264,3438.1301,0],
[8284.8447,2882.7969,0],
[9757.4404,1913.0979,0],
[10258.862,2190.3423,0],
[10047.912,2426.1528,0],
[11825.01,3491.3479,0],
[13484.899,4042.1584,0],
[13629.885,2866.4932,0],
[13312.51,6524.9927,0],
[11539.966,5576.0742,0],
[11471.443,6707.582,0],
[6700.0488,5935.1724,0],
[7873.6177,5153.9512,0],
[11349.682,7592.9326,0],
[11119.914,8121.4434,0],
[10471.377,8449.6768,0],
[9546.748,8527.5625,0],
[11881.921,10033.177,0],
[9242.2539,11218.743,0],
[9237.958,4064.0278,0],
[8765.4844,6120.1685,0],
[9997.4512,6730.7456,0],
[9983.3184,7173.9434,0],
[12323.812,6905.1079,0],
[12483.35,8423.291,0],
[11432.563,9560.1191,0],
[2730.4912,11887.858,0],
[3210.8567,8751.46,0],
[5260.6831,7636.314,0],
[6243.1836,8435.3086,0],
[4655.3706,4455.2158,0],
[1088.7483,4188.8389,0],
[6994.6992,14189.774,0]

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
        _itemTypes = [["Binocular_Vector", "weapon"], ["MG36_camo", "weapon"], ["FN_FAL","weapon"], ["M14_EP1","weapon"], ["FN_FAL_ANPVS4","weapon"], ["Mk_48_DZ","weapon"], ["M249_DZ","weapon"], ["DMR","weapon"], ["G36C","weapon"], ["G36C_camo","weapon"], ["SCAR_H_CQC_CCO", "weapon"], ["G36_C_SD_camo","weapon"], ["G36A_camo","weapon"], ["G36K_camo","weapon"], ["", "military"], ["MedBox0", "object"], ["NVGoggles", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Camo1_DZ", "magazine"], ["Skin_Sniper1_DZ", "magazine"], ["SVD_CAMO","weapon"], ["M24","weapon"], ["M4A1_AIM_SD_camo","weapon"], ["Sa58P_EP1","weapon"], ["Sa58V_CCO_EP1","weapon"], ["Sa58V_EP1","weapon"], ["Sa58V_RCO_EP1","weapon"]];
        _itemChance = [ 0.05, 0.01, 0.01, 0.02, 0.05, 0.01, 0.03, 0.05, 0.01, 0.06, 0.03, 0.02, 0.01, 0.02, 0.9, 0.09, 0.01, 0.5, 0.05, 0.05, 0.01, 0.05, 0.05, 0.04, 0.03, 0.05, 0.05, 0.05, 0.04, 0.05];
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