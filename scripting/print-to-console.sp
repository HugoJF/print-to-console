#pragma semicolon 1

#include <sourcemod>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "Print to client console",
	author = "AlliedModders LLC, de_nerd",
	description = "Simple command to print to client console",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_consay", Command_SmConsay, "sm_consay <target> <message> - send private console message");
}

public Action Command_SmConsay(int client, int args)
{
	if (args < 2)
	{
		ReplyToCommand(client, "[SM] Usage: sm_psay <name or #userid> <message>");
		return Plugin_Handled;	
	}	
	
	char text[1024], arg[64], message[1024];
	GetCmdArgString(text, sizeof(text));

	int len = BreakString(text, arg, sizeof(arg)); 
	BreakString(text[len], message, sizeof(message));
	
	int target = FindTarget(client, arg, true, false);
		
	if (target == -1)
		return Plugin_Handled;	
	
	SendConsoleMessage(target, message);
	
	return Plugin_Handled;	
}

void SendConsoleMessage(int target, const char[] message)
{
	PrintToConsole(target, message);
}
