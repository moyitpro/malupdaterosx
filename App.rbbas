#tag ClassProtected Class AppInherits Application	#tag Event		Sub Close()		  window1.stopscrobble		End Sub	#tag EndEvent	#tag MenuHandler		Function FileAboutMALUpdaterOSX() As Boolean Handles FileAboutMALUpdaterOSX.Action						Carbon.ShowAboutBox kAppName,  "Version " + app.shortVersion, "", kAppCopyrightPrefix + kAppAuthorName			return true					End Function	#tag EndMenuHandler	#tag MenuHandler		Function HelpMALClientOSXMALClub() As Boolean Handles HelpMALClientOSXMALClub.Action			showurl "http://myanimelist.net/clubs.php?cid=16059"			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function HelpMALUpdaterOSXMALClub() As Boolean Handles HelpMALUpdaterOSXMALClub.Action			showurl "http://myanimelist.net/clubs.php?cid=8948"			Return True					End Function	#tag EndMenuHandler	#tag Method, Flags = &h0		Sub errboxshow(errtitle as string, errmsg as string)		  Dim b as MessageDialogButton //for handling the result		  // no search term error		  Dim d as New MessageDialog //declare the MessageDialog object		  d.icon=MessageDialog.GraphicCaution //display warning icon		  d.ActionButton.Caption="OK"		  d.Message=errtitle		  d.Explanation=errmsg		  b=d.ShowModal		End Sub	#tag EndMethod	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"	#tag EndConstant	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"	#tag EndConstant	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"	#tag EndConstant	#tag ViewBehavior	#tag EndViewBehaviorEnd Class#tag EndClass