//Let Zeds know
[player,4,true,(getPosATL player)] spawn player_alertZombies;


if (isnil ("hotkey_hitme")) then {
    hotkey_hitme = 0;
};
if (hotkey_hitme == 1) then {
hotkey_hitme = 0;
titleText ["Debug Monitor Deactivated","PLAIN DOWN"];titleFadeOut 2;
} else {
hotkey_hitme = 1;
titleText ["Debug Monitor Activated","PLAIN DOWN"];titleFadeOut 2;
};


/*
Change the UID's below to match those of you and your admin(s)
Your admins will get the advanced version of your debug monitor,
while your regular users will get the cut down version.
*/


while {sleep 1;hotkey_hitme == 1} do {


hintSilent parseText format 	

    ["
    <t size='1.20' font='Bitstream' align='center' color='#00CC00'>%1</t><br/>
    <t size='0.95' font='Bitstream' align='center' >[%13]</t><br/>
    <t size='1.15' font='Bitstream' align='center' color='#FFCC00'>Survived %7 Days</t><br/><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Zombies Killed: </t><t size='1.15' font='Bitstream' align='right'>%2</t><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Headshots: </t><t size='1.15' font='Bitstream' align='right'>%3</t><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='0.95' font='Bitstream' align='right'>%5</t><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Humanity: </t><t size='1.15' font='Bitstream' align='right'>%6</t><br/><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Blood: </t><t size='1.15' font='Bitstream' align='right'>%10</t><br/>
    <t size='1.15' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='1.15' font='Bitstream' align='right'>%11</t><br/>
	<t size='1.15' font='Bitstream' align='left' color='#FFBF00'>Restart in: </t><t size='1.15' font='Bitstream' align='right'>%8 min</t><br/>
    <t size='0.95' font='Bitstream' color='#5882FA'>DE991 by Dayzforum.net</t><br/>",
    (name player),
    (player getVariable['zombieKills', 0]),
    (player getVariable['headShots', 0]),
    (player getVariable['humanKills', 0]),
    (player getVariable['banditKills', 0]),
    (player getVariable['humanity', 0]),
    dayz_Survived,
    (150-(round(serverTime/60))),
    (null),
    r_player_blood,
    (round diag_fps),
    (null),
    (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName'))
    ];};