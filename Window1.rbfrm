#tag WindowBegin Window Window1   BackColor       =   16777215   Backdrop        =   ""   CloseButton     =   False   Composite       =   False   Frame           =   3   FullScreen      =   False   HasBackColor    =   False   Height          =   1.32e+2   ImplicitInstance=   True   LiveResize      =   True   MacProcID       =   0   MaxHeight       =   32000   MaximizeButton  =   True   MaxWidth        =   32000   MenuBar         =   1105278886   MenuBarVisible  =   True   MinHeight       =   64   MinimizeButton  =   True   MinWidth        =   64   Placement       =   0   Resizeable      =   False   Title           =   "MAL Scrobbling"   Visible         =   True   Width           =   1.35e+2   Begin BevelButton Settings      AcceptFocus     =   False      AutoDeactivate  =   True      BackColor       =   0      Bevel           =   0      Bold            =   False      ButtonType      =   0      Caption         =   "Setup Scrobbling"      CaptionAlign    =   3      CaptionDelta    =   0      CaptionPlacement=   1      Enabled         =   True      HasBackColor    =   False      HasMenu         =   0      Height          =   30      HelpTag         =   ""      Icon            =   ""      IconAlign       =   0      IconDX          =   0      IconDY          =   0      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   True      LockRight       =   ""      LockTop         =   True      MenuValue       =   0      Scope           =   0      TabIndex        =   0      TabPanelIndex   =   0      TabStop         =   True      TextColor       =   0      TextFont        =   "System"      TextSize        =   ""      TextUnit        =   0      Top             =   0      Underline       =   False      Value           =   False      Visible         =   True      Width           =   135   End   Begin BevelButton Scrobble      AcceptFocus     =   False      AutoDeactivate  =   True      BackColor       =   0      Bevel           =   0      Bold            =   False      ButtonType      =   0      Caption         =   "Start Scrobbling"      CaptionAlign    =   3      CaptionDelta    =   0      CaptionPlacement=   1      Enabled         =   True      HasBackColor    =   False      HasMenu         =   0      Height          =   30      HelpTag         =   ""      Icon            =   ""      IconAlign       =   0      IconDX          =   0      IconDY          =   0      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   True      LockRight       =   ""      LockTop         =   True      MenuValue       =   0      Scope           =   0      TabIndex        =   1      TabPanelIndex   =   0      TabStop         =   True      TextColor       =   0      TextFont        =   "System"      TextSize        =   ""      TextUnit        =   0      Top             =   33      Underline       =   False      Value           =   False      Visible         =   True      Width           =   135   End   Begin Timer Timer1      Height          =   32      Index           =   -2147483648      Left            =   179      LockedInPosition=   False      Mode            =   0      Period          =   300000      Scope           =   0      TabPanelIndex   =   0      Top             =   8      Width           =   32   End   Begin TextArea TextArea1      AcceptTabs      =   ""      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   16777215      Bold            =   ""      Border          =   False      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   68      HelpTag         =   ""      HideSelection   =   True      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   0      LimitText       =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   True      LockRight       =   ""      LockTop         =   True      Mask            =   ""      Multiline       =   True      ReadOnly        =   True      Scope           =   0      ScrollbarHorizontal=   ""      ScrollbarVertical=   True      Styled          =   True      TabIndex        =   2      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   0      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   64      Underline       =   ""      UseFocusRing    =   False      Visible         =   True      Width           =   135   EndEnd#tag EndWindow#tag WindowCode	#tag Event		Sub Open()		  checkcred		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub addtitle(id as string)		  Dim socket1 as new httpsocket		  socket1.yield = true		  Dim form as Dictionary		  // create and populate the form object		  form = New Dictionary		  form.value("anime_id") = id		  form.value("episodes") = episode		  form.value("status") = "watching"		  form.value("score") = "0"		  // setup the socket to POST the form		  socket1.setFormData form		  socket1.setrequestheader "Authorization","Basic " + encodebase64(stringusername + ":" + decodebase64(stringpassword))		  socket1.post ("http://mal-api.com/animelist/anime" )		  If socket1.httpstatuscode = 200 or socket1.httpstatuscode = 0 then		    textarea1.text = "Adding of " + title + " " + episode +  " Successful..." + endofline + textarea1.text		  else		    textarea1.text = "Adding of " + title+ " " + episode +  " Unsuccessful..." + endofline + textarea1.text		  end if		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub checkcred()		  If Prefs.stringpassword = "" then		    scrobble.enabled = false		  else		    scrobble.enabled = true		  end if		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function checkstatus(id as string) As integer		  // Return value: 0 - No Update, 1 - Update, 2 - Add Title to List		  dim socket1 as new httpsocket		  // perform search		  socket1.yield = true		  dim data as string		  dim s as string		  // retrieve results		  socket1.setrequestheader "Authorization","Basic " + encodebase64(stringusername + ":" + decodebase64(stringpassword))		  data= socket1.get( "http://mal-api.com/anime/" + id+ "?format=xml&mine=1",10)		  If socket1.httpstatuscode = 200 then		    // Populate Search Results		    dim XML as new XMLDocument		    dim r as new XMLNode		    dim p as new XMLNodeList		    dim c, i as integer		    dim d as new dictionary		    XML.LoadXML(Data)		    r = getXMLroot(xml)		    p = getSearchList(r)		    d = parseAnime(p.Item(0))		    If d.value("watched_status") = "" then		      // Add the Title		      return 2		    else		      If val(episode) > val(d.value("watched_episodes")) then		        // Do the update		        return 1		      else		        // Update Unnecessary		        return 0		      end if		    end if		  else		  end if		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub cleanoutput(input as string)		  Dim rg as New RegEx		  Dim myMatch as RegExMatch		  Dim tempstring as string		  rg.SearchPattern="^.+(avi|mkv|mp4|ogm)$"		  myMatch=rg.search(input)		  // Find the video file		  if myMatch <> Nil then		    tempstring = mymatch.SubExpressionString(0)		    rg.options.ReplaceAllMatches = true		    //perform cleanup		    rg.SearchPattern = "^.+/"		    rg.ReplacementPattern = ""		    tempstring = rg.replace(tempstring)		    rg.searchpattern = "\.\w+"		    tempstring = rg.replace(tempstring)		    rg.searchpattern = "\s*\[[^\]]+\]\s*"		    tempstring = rg.replace(tempstring)		    rg.searchpattern = "\s*\([^\)]+\)$"		    tempstring = rg.replace(tempstring)		    rg.SearchPattern = "_"		    rg.ReplacementPattern = " "		    tempstring = rg.replace(tempstring)		    //Set Title and Episode Number		    rg.SearchPattern = "( \-)? (episode |ep |ep|e)?(\d+)([\w\-! ]*)"		    rg.ReplacementPattern = ""		    title = rg.replace(tempstring)		    rg.SearchPattern = title + " - "		    rg.ReplacementPattern = ""		    episode = rg.replace(tempstring)		    title = trim(title)		  else		    		  End if		exception err as RegExException		  MsgBox err.message		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function SearchTitle() As string		  dim socket1 as new httpsocket		  // perform search		  socket1.yield = true		  dim data as string		  dim s as string		  // retrieve results		  socket1.setrequestheader "Authorization","Basic " + encodebase64(stringusername + ":" + decodebase64(stringpassword))		  s = EncodeURLComponent(title)		  data= socket1.get( "http://mal-api.com/anime/search?q=" + s+ "&format=xml",10)		  If socket1.httpstatuscode = 200 then		    // Populate Search Results		    dim XML as new XMLDocument		    dim r as new XMLNode		    dim p as new XMLNodeList		    dim c, i as integer		    dim d as new dictionary		    XML.LoadXML(Data)		    r = getXMLroot(xml)		    p = getSearchList(r)		    c = p.Length - 1		    for i = 0 to c		      d = parseAnime(p.Item(i))		      try		        Dim rg as New RegEx		        Dim myMatch as RegExMatch		        rg.SearchPattern=title		        myMatch=rg.search(d.value("title"))		        if myMatch <> Nil then		          return d.value("id")		          exit		        else		        End if		        myMatch=rg.search(d.value("title"))		      catch ex as regexexception		      end try		    next		  else		  end if		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub startscrobble()		  timer1.Mode = Timer.Modemultiple		  Scrobble.caption = "Stop Scrobbling"		  Scrobblingmode = true		  textarea1.text = "Scrobbling have been started" + endofline + textarea1.text		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub stopscrobble()		  timer1.Mode = Timer.ModeOff		  scrobble.caption = "Start Scrobbling"		  Scrobblingmode = false		  textarea1.text = "Scrobbling have been stopped" + endofline + textarea1.text		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Update(ID as String)		  Dim socket1 as new httpsocket		  socket1.yield = true		  Dim form as Dictionary		  // create and populate the form object		  form = New Dictionary		  form.value("_method") = "PUT"		  form.value("episodes") = episode		  // setup the socket to POST the form		  socket1.setFormData form		  socket1.setrequestheader "Authorization","Basic " + encodebase64(stringusername + ":" + decodebase64(stringpassword))		  socket1.post ("http://mal-api.com/animelist/anime/" + ID )		  If socket1.httpstatuscode = 200 or socket1.httpstatuscode = 0 then		    textarea1.text = "Update of " + title + " " + episode +  "Successful..." + endofline + textarea1.text		  else		    textarea1.text = "Update of " + title+ " " + episode +  "Unsuccessful..." + endofline + textarea1.text		  end if		End Sub	#tag EndMethod	#tag Property, Flags = &h0		episode As string	#tag EndProperty	#tag Property, Flags = &h0		scrobblingmode As boolean = false	#tag EndProperty	#tag Property, Flags = &h0		title As string	#tag EndProperty#tag EndWindowCode#tag Events Settings	#tag Event		Sub Action()		  Window2.show		End Sub	#tag EndEvent#tag EndEvents#tag Events Scrobble	#tag Event		Sub Action()		  If  scrobblingmode = false then		    startscrobble		  elseif Scrobblingmode = true then		    stopscrobble		  end if		End Sub	#tag EndEvent#tag EndEvents#tag Events Timer1	#tag Event		Sub Action()		  //Execute Command		  dim sh as shell		  sh = new shell		  sh.Execute "/usr/sbin/lsof -c 'mplayer' -Fn"		  If sh.result = "" then		  else		    //clean up output		    cleanoutput(sh.result)		    dim id as string		    // Find the ID to update		    id = searchtitle		    msgbox  id		    textarea1.text = "Found " + title + " ID: " +  id + endofline + "----" + endofline + textarea1.text		    // Check Status		    dim returnvalue as integer		    returnvalue = checkstatus(id)		    // Do the Update		    If returnvalue = 1 then		      update(id)		    elseif returnvalue = 2 then		      addtitle(id)		    else		      textarea1.text = "Update for " + title + " " + episode +  " is not necessary..." + endofline + textarea1.text		    end if 		  end if		End Sub	#tag EndEvent#tag EndEvents