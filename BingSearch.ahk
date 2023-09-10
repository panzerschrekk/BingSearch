; AutoHotkey v2 script to download word list from github and then start bing searches from ten randomly choosen words
; Remove the comment symbol depending on which list you want to use

FileDelete "twords*.txt" ;Delete temporary word lists
Result := MsgBox("Would you like to re-download all the word lists? (words.txt will be deleted!)",, "YesNo")
if Result = "Yes"
{
	FileDelete "words.txt" ;Delete before downloading new files

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

	Text := FileRead("words.txt")

	oText := StrSplit(Text, "`n")

	oMaxItems := oText.Length
}

Loop 11
{
	oRandom := Random(1, oMaxItems)
	Sleep Random(250,990)
	oOutput := oText.Get(oRandom)
	RunWait "microsoft-edge:" . "https://www.bing.com/search?q=" . oOutput
}
