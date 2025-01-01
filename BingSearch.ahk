; AutoHotkey v2 script to download word list from github and then start bing searches from ten randomly choosen words
; Remove the comment symbol depending on which list you want to use

Run "msedge.exe --no-startup-window"

SetKeyDelay 50

FileDelete "twords*.txt" ;Delete temporary word lists
ReDownload := MsgBox("Would you like to re-download all the word lists? (words.txt will be deleted!)",, "YesNo")

if ReDownload = "Yes"
{
	FileDelete "words*.txt" ;Delete before downloading new files

	;German word list
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Adjektive/Adjektive.txt" , "twords1.txt"
	FileAppend FileRead("twords1.txt"), "words.txt"
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Substantive/substantiv_singular_das.txt" , "twords2.txt"
	FileAppend FileRead("twords2.txt"), "words.txt"
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Substantive/substantiv_singular_der.txt" , "twords3.txt"
	FileAppend FileRead("twords3.txt"), "words.txt"
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Substantive/substantiv_singular_die.txt" , "twords4.txt"
	FileAppend FileRead("twords4.txt"), "words.txt"
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Verben/Verben_regelmaesig.txt" , "twords5.txt"
	FileAppend FileRead("twords5.txt"), "words.txt"
	Download "https://raw.githubusercontent.com/cpos/AlleDeutschenWoerter/main/Verben/Verben_unregelmae%C3%9Fig_Infinitiv.txt" , "twords6.txt"
	FileAppend FileRead("twords6.txt"), "words.txt"

	;English word list
	Download "https://raw.githubusercontent.com/dwyl/english-words/master/words.txt" , "twords7.txt"
	FileAppend FileRead("twords7.txt"), "words.txt"
	FileDelete "twords*.txt" ;Delete temporary word lists
}

LoopUsr := InputBox("How often do you want to repeat the search? (Enter number between 1 and 100)", "Amount of searches", "W300 H125", "30")
LoopInt := Integer(LoopUsr.Value)

TimeoutUsr := InputBox("What is the timeout in sec? (Enter number between 1 and 999)", "Timeout", "W300 H125", "30")
TimeoutInt := Integer(TimeoutUsr.Value)*1000

if LoopUsr.Result = "OK" && TimeoutUsr.Result = "OK"
{
	Text := FileRead("words.txt")

	oText := StrSplit(Text, "`n")

	oMaxItems := oText.Length

	RunWait "microsoft-edge:" . "https://rewards.bing.com/pointsbreakdown"

	Loop LoopInt
	{
		oRandom := Random(1, oMaxItems)
		oOutput := oText.Get(oRandom)
		Sleep TimeoutInt
		Sleep Random(500,1000)
		;Variation1 with RunWait
		;RunWait "microsoft-edge:" . "https://www.bing.com/search?q=" . oOutput
		;Variation2 with RunWait and Form
		oForm := Chr(Random(65,90)) . Chr(Random(65,90)) . Chr(Random(65,90)) . Chr(Random(65,90)) . Random(0,9)
		RunWait "microsoft-edge:" . "https://www.bing.com/search?q=" . oOutput . "&FORM=" . oForm
		;Variation3 manual Input
		;WinExist("ahk_exe msedge.exe")
		;WinActivate("ahk_exe msedge.exe")
		;Send "^t"
		;Send "{Text}" oOutput
		;Send "{Enter}"
		;Sleep Random(1000,2000)
		;Send "{PgDn 4}{PgUp 1}{End 4}"
	}
}
