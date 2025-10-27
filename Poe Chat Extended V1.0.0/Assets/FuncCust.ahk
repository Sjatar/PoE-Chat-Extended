GuiFieldWhisper(iniFile)
{	
	global WhisperEnabled
	global WhisperFile
	
	IniRead, WhisperEnabled, %iniFile%, Whisper, WhisperEnabled
	IniRead, WhisperFile, %iniFile%, Whisper, WhisperFile
	if WhisperEnabled
	{
		Gui, Add, CheckBox, Checked vWhisperEnabled, Enable custom whisper sound
	}
	else 
	{
		Gui, Add, CheckBox, vWhisperEnabled, Enable custom whisper sound
	}
		
	Gui, Add, DropDownList, vWhisperFile w320
	Loop, files, Sounds\*.*
	{
		GuiControl,, WhisperFile, %A_LoopFileFullPath%
	}
	GuiControl, ChooseString, WhisperFile, %WhisperFile%
	Gui, Add, Text,,
}

GuiFieldTradeWhisper(iniFile)
{	
	global TradeWhisperEnabled
	global TradeWhisperFile
	
	IniRead, TradeWhisperEnabled, %iniFile%, Whisper, TradeWhisperEnabled
	IniRead, TradeWhisperFile, %iniFile%, Whisper, TradeWhisperFile
	if TradeWhisperEnabled
	{
		Gui, Add, CheckBox, Checked vTradeWhisperEnabled, Enable custom trade whisper sound
	}
	else 
	{
		Gui, Add, CheckBox, vTradeWhisperEnabled, Enable custom TradeWhisper sound
	}
		
	Gui, Add, DropDownList, vTradeWhisperFile w320
	Loop, files, Sounds\*.*
	{
		GuiControl,, TradeWhisperFile, %A_LoopFileFullPath%
	}
	GuiControl, ChooseString, TradeWhisperFile, %TradeWhisperFile%
	Gui, Add, Text,,
}

GuiFieldGlobal(iniFile)
{	
	global GlobalEnabled
	global GlobalFile
	
	IniRead, GlobalEnabled, %iniFile%, Global, GlobalEnabled
	IniRead, GlobalFile, %iniFile%, Global, GlobalFile
	if GlobalEnabled
	{
		Gui, Add, CheckBox, Checked vGlobalEnabled, Enable custom global sound
	}
	else 
	{
		Gui, Add, CheckBox, vGlobalEnabled, Enable custom global sound
	}
		
	Gui, Add, DropDownList, vGlobalFile w320
	Loop, files, Sounds\*.*
	{
		GuiControl,, GlobalFile, %A_LoopFileFullPath%
	}
	GuiControl, ChooseString, GlobalFile, %GlobalFile%
	Gui, Add, Text,,
}

GuiFieldGlobalMention(iniFile)
{	
	global GlobalMentionEnabled
	global GlobalMentionFile
	global GlobalMentionNicks
	
	IniRead, GlobalMentionEnabled, %iniFile%, Global, GlobalMentionEnabled
	IniRead, GlobalMentionFile, %iniFile%, Global, GlobalMentionFile
	
	if GlobalMentionEnabled
	{
		Gui, Add, CheckBox, Checked vGlobalMentionEnabled, Enable custom global nickname sound
	}
	else 
	{
		Gui, Add, CheckBox, vGlobalMentionEnabled, Enable custom global mention sound
	}
	
	Gui, Add, Text,, Edit Assets/nicknames.txt for custom nicknames
	Gui, Add, Text, YP15, Nicknames are case insensetive
	
	Gui, Add, ListBox, ReadOnly vGlobalMentionNicks w290 h80
	Loop, Read, Assets\nicknames.txt
	{
		GuiControl,, GlobalMentionNicks, %A_LoopReadLine%
	}
		
	Gui, Add, Button, XP290 YP0 Default gEditNick, Edit
		
	Gui, Add, DropDownList, vGlobalMentionFile w320 XP-290 YP75
	Loop, files, Sounds\*.*
	{
		GuiControl,, GlobalMentionFile, %A_LoopFileFullPath%
	}
	GuiControl, ChooseString, GlobalMentionFile, %GlobalMentionFile%
	
	Gui, Add, Text,,
}

GuiFieldParty(iniFile)
{	
	global PartyEnabled
	global PartyFile
	
	IniRead, PartyEnabled, %iniFile%, Party, PartyEnabled
	IniRead, PartyFile, %iniFile%, Party, PartyFile
	if PartyEnabled
	{
		Gui, Add, CheckBox, Checked vPartyEnabled, Enable custom party sound
	}
	else 
	{
		Gui, Add, CheckBox, vPartyEnabled, Enable custom party sound
	}
		
	Gui, Add, DropDownList, vPartyFile w320
	Loop, files, Sounds\*.*
	{
		GuiControl,, PartyFile, %A_LoopFileFullPath%
	}
	GuiControl, ChooseString, PartyFile, %PartyFile%
	Gui, Add, Text,,
}

