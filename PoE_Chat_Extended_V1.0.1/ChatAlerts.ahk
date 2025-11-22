#SingleInstance force
#Persistent
#Include Assets/FuncCust.ahk

SetWorkingDir %A_ScriptDir%
iniFile = config.ini

Gui, New,, Poe Chat Alerts
Gui, +hwndhGui

Menu, Tray, Tip, PoE Chat Alerts
Menu, Tray, Icon, Assets/Social.ico

GuiFieldWhisper(iniFile)
GuiFieldTradeWhisper(iniFile)

GuiFieldGlobal(iniFile)
GuiFieldGlobalMention(iniFile)

Global RegexString := "i)INFO Client [0-9]*\] #.*: .*("

Loop, Read, Assets/nicknames.txt
{
	RegexString := RegexString . A_LoopReadLine . "|"
}
StringTrimRight, RegexString, RegexString, 1
RegexString := RegexString . ")"

GuiFieldParty(iniFile)

GuiGameEvents(iniFile)

IniRead, PoEInstallDir, %iniFile%, Install, PoEInstallDir

Gui, Add, Text, YP10, PoE installation directory:
Gui, Add, ListBox, ReadOnly vInstallDir w290 h25
Gui, Add, Button, XP290 YP-3 Default gEditDir, Edit
GuiControl,, InstallDir, %PoEInstallDir%

Gui, Add, Button, Default xm, Save
OnMessage(0x404, Func("AHK_NOTIFYICON").Bind(hGUI))

Global WhisperEnabled = WhisperEnabled
Global WhisperFile = WhisperFile

Global TradeWhisperFile = TradeWhisperFile
Global TradeWhisperEnabled = TradeWhisperEnabled

Global GlobalEnabled = GlobalEnabled
Global GlobalFile = GLobalFile

Global GlobalMentionEnabled = GlobalMentionEnabled
Global GlobalMentionFile = GlobalMentionFile

Global PartyEnabled = PartyEnabled
Global PartyFile = PartyFile

Global EventEnabled = EventEnabled
Global EventFile = EventFile

lt := new CLogTailer(PoEInstallDir . "\logs\Client.txt", Func("NewLine"))
return

ButtonSave:
Gui, Submit, NoHide
IniWrite, %WhisperEnabled%, %iniFile%, Whisper, WhisperEnabled
IniWrite, %WhisperFile%, %iniFile%, Whisper, WhisperFile

IniWrite, %TradeWhisperEnabled%, %iniFile%, Whisper, TradeWhisperEnabled
IniWrite, %TradeWhisperFile%, %iniFile%, Whisper, TradeWhisperFile

IniWrite, %GlobalEnabled%, %iniFile%, Global, GlobalEnabled
IniWrite, %GlobalFile%, %iniFile%, Global, GlobalFile

IniWrite, %GlobalMentionEnabled%, %iniFile%, Global, GlobalMentionEnabled
IniWrite, %GlobalMentionFile%, %iniFile%, Global, GlobalMentionFile

IniWrite, %PartyEnabled%, %iniFile%, Party, PartyEnabled
IniWrite, %PartyFile%, %iniFile%, Party, PartyFile

IniWrite, %EventEnabled%, %iniFile%, Event, EventEnabled
IniWrite, %EventFile%, %iniFile%, Event, EventFile

IniWrite, %PoEInstallDir%, %iniFile%, Install, PoEInstallDir

GuiControl,, GlobalMentionNicks, |
Loop, Read, Assets\nicknames.txt
{
	GuiControl,, GlobalMentionNicks, %A_LoopReadLine%
}

Global RegexString := "i)INFO Client [0-9]*\] #.*: .*("

Loop, Read, Assets/nicknames.txt
{
	RegexString := RegexString . A_LoopReadLine . "|"
}
StringTrimRight, RegexString, RegexString, 1
RegexString := RegexString . ")"

MsgBox,, PoE Chat Alerts, Saved!,
return

EditNick:
file := "Assets\nicknames.txt"
if !FileExist(file)
{
	FileAppend,, %file%
}
Run, %file%
return

EditDir:
FileSelectFolder, PoEInstallDir,,, Select the 'Path of exile' installation folder: `n`nFor steam Install: Steam/steamapps/common/Path of Exile
IniWrite, %PoEInstallDir%, %iniFile%, Install, PoEInstallDir
GuiControl,, InstallDir, |
GuiControl,, InstallDir, %PoEInstallDir%
lt := new CLogTailer(PoEInstallDir . "\logs\Client.txt", Func("NewLine"))
return

AHK_NOTIFYICON(hGui, wp, lp)
{
	static WM_LBUTTONDOWN := 0x201
	if (lp = WM_LBUTTONDOWN)
	{
		Gui, %hGui%: Show
	}
}

NewLine(line){
	IsTradeWhisper = 0
	if RegExMatch(line, "INFO Client [0-9]*\] @From .*: Hi, (I'd like to buy your|I would like to buy your)")
	{
		if TradeWhisperEnabled
		{
			IsTradeWhisper = 1
			SoundPlay, %TradeWhisperFile%
		}
	}	
	else if (RegExMatch(line, "INFO Client [0-9]*\] @From .*: ") and not isTradeWhisper)
	{
		if WhisperEnabled
		{
			SoundPlay, %WhisperFile%
		}
	}
	else if RegExMatch(line, "INFO Client [0-9]*\] %.*: ")
	{	
		if PartyEnabled
		{
			SoundPlay, %PartyFile%
		}
	}
	else if RegExMatch(line, RegexString)
	{
		if GlobalMentionEnabled
		{
			SoundPlay, %GlobalMentionFile%
		}
	}
	else if RegExMatch(line, "INFO Client [0-9]*\] #.*: ")
	{	
		if GlobalEnabled
		{
			SoundPlay, %GlobalFile%
		}
	}
	else if RegExMatch(line, "INFO Client [0-9]*\] : (Your Menagerie was full so an older Beast|Your Menagerie only has room for one more Beast of this type.|<brequelwarning>{Equipped Grafts are almost full!}|The past shall serve the present.|A Reflecting Mist has manifested nearby.|The Nameless Seer has appeared nearby.|<brequelwarning>{Equipped Grafts cannot gain more Blood as they are full})")
	{
		if EventEnabled
		{
			SoundPlay, %EventFile%
		}
	}
	
}

class CLogTailer {
	__New(logfile, callback){
		this.file := FileOpen(logfile, "r-d")
		this.callback := callback
		; Move seek to end of file
		this.file.Seek(0, 2)
		fn := this.WatchLog.Bind(this)
		SetTimer, % fn, 100
	}
	
	WatchLog(){
		Loop {
			p := this.file.Tell()
			l := this.file.Length
			line := this.file.ReadLine(), "`r`n"
			len := StrLen(line)
			if (len){
				RegExMatch(line, "[\r\n]+", matches)
				if (line == matches)
					continue
				this.callback.Call(Trim(line, "`r`n"))
			}
		} until (p == l)
	}
}
