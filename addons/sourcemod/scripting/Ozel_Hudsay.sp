#include <sourcemod>
/*
#include <multicolors>
#include <hgr>
#include <cstrike>
#include <sdktools>
#include <sdkhooks>
#include <warden>
#include <devzones>
#include <clientprefs>
#include <customplayerskins>
#include <overlays>
#include <store>
#include <emitsoundany>
*/

// ----- HookEvent ----- //

/*
HookEvent("round_start", RoundStart);   
HookEvent("round_end", RoundEnd);
HookEvent("player_spawn", OnClientSpawn);
HookEvent("player_death", OnClientDead);
HookEvent("bomb_planted", C4Planted);
HookEvent("weapon_fire", WeaponFire);
*/

// ----- Semboller ----- //
/*
	✪ 
	⛧ 
	★ 
	⍟ 
	✦
*/

#pragma semicolon 1
#pragma newdecls required
bool Kontrol[MAXPLAYERS];
public Plugin myinfo = 
{
	name = "...", 
	author = "phiso", 
	description = "...", 
	version = "1.0", 
	url = "phiso#3331"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_ohudsay", OzelHudsay);
	RegConsoleCmd("sm_omhudsay", Ozel_Hudsay);
}
public Action Ozel_Hudsay(int client, int args)
{
	if (Kontrol[client])
	{
		Kontrol[client] = false;
		PrintToChat(client, "[SM] \x02Özel Hudsay \x04lerin kapandı.");
	}
	else
	{
		Kontrol[client] = true;
		PrintToChat(client, "[SM] \x02Özel Hudsay \x04lerin açıldı.");
	}
}
public Action OzelHudsay(int client, int args)
{
	if (args < 2)
	{
		PrintToChat(client, "[SM] \x0BKullanım: !ohudsay <kisi> <mesaj>.");
	}
	
	char hedef[32];
	char mesaj[128];
	GetCmdArg(1, hedef, sizeof(hedef));
	GetCmdArg(2, mesaj, sizeof(mesaj));
	int Target = FindTarget(client, hedef);
	if (Target == -1)
	{
		PrintToChat(client, "[SM] \x0BHedef Bulunamadı.");
	}
	else
	{
		if (Kontrol[Target])
		{
			char isim[32], name[32], buffer2[32], buffer3[32];
			GetClientName(Target, isim, sizeof(isim));
			GetClientName(client, name, sizeof(name));
			GetCmdArgString(mesaj, sizeof(mesaj));
			ReplaceStringEx(mesaj, sizeof(mesaj), hedef, "");
			Format(buffer2, sizeof(buffer2), "%s Kişisinden:", name);
			Format(buffer3, sizeof(buffer3), "%s Kişisine:", isim);
			Handle hHudText = CreateHudSynchronizer();
			SetHudTextParams(-1.0, -0.5, 5.0, GetRandomInt(0, 255), GetRandomInt(0, 255), GetRandomInt(0, 255), 0, 2, 1.0, 0.1, 0.2);
			ShowSyncHudText(Target, hHudText, "%s: %s", buffer2, mesaj);
			ShowSyncHudText(client, hHudText, "%s: %s", buffer3, mesaj);
		}
		else
		{
			PrintToChat(client, "[SM] \x02Hudsay \x04atmak istediğin kişi \x02Özel Hudsayleri \x04kapatmış.");
		}
	}
} 