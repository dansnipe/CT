class BotSupportBroadcastHandler extends BroadcastHandler;

var BotSupport BotSupport;

function bool ParseCommand(out String Cmd, String Match){
	if(Left(Cmd, Len(Match)) ~= Match){
		Cmd = Mid(Cmd, Len(Match));

		return true;
	}

	return false;
}

function PostBeginPlay(){
	Super.PostBeginPlay();

	foreach AllActors(class'BotSupport', BotSupport)
		break;
}

function Broadcast(Actor Sender, coerce string Msg, optional name Type){
	local String Cmd;
	local int NumBots;
	local int i;

	if(InStr(Msg, "/") == 0){
		Cmd = Right(Msg, Len(Msg) - 1);

		if(ParseCommand(Cmd, "ADDBOT")){
			NumBots = int(Cmd);

			do{
				BotSupport.AddBot();
				++i;
			}until(i >= NumBots);
		}else if(ParseCommand(Cmd, "REMOVEBOT")){
			NumBots = int(Cmd);

			do{
				BotSupport.RemoveBot();
				++i;
			}until(i >= NumBots);
		}else if(Sender.IsA('PlayerController')){
			PlayerController(Sender).ClientMessage("Unknown command");
		}
	}else{
		Super.Broadcast(Sender, Msg, Type);
	}
}
