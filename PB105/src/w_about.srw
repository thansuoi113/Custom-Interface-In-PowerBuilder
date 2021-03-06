$PBExportHeader$w_about.srw
forward
global type w_about from window
end type
type dw_1 from datawindow within w_about
end type
type p_1 from picture within w_about
end type
type str_wsadata from structure within w_about
end type
end forward

type str_wsadata from structure
	unsignedinteger		version
	unsignedinteger		highversion
	character		description[257]
	character		systemstatus[129]
	unsignedinteger		maxsockets
	unsignedinteger		maxupddg
	string		vendorinfo
end type

global type w_about from window
integer width = 1947
integer height = 1092
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 134217739
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
p_1 p_1
end type
global w_about w_about

type prototypes

Function Long CreateRoundRectRgn( Long nLeftRect, Long nTopRect, Long nRightRect, Long nBottomRect , Long nWidthEllipse, Long nHeightEllipse) Library "gdi32.dll"
Function Long SetWindowRgn(Long hWnd,Long hRgn,Long bRedraw) Library "user32.dll"
Function Boolean DeleteObject( ULong hObject ) Library "gdi32.dll"
Function Int CombineRgn( ULong hrgnDest, ULong hrgnSrc1,  ULong hrgnSrc2, Int fnCombineMode ) Library "gdi32.dll"
Function Int SetWindowRgn( ULong wHandle, ULong rgHandle, Boolean redraw ) Library "user32.dll"
Function ULong CreateEllipticRgn( Int nLeftRect, Int nTopRect,  Int nRightRect,   Int nBottomRect ) Library "gdi32.dll"


Function Int WSAStartup (UInt UIVerionrequested, Ref str_wsadata lpWSAdata) Library "wsock32.DLL" Alias For "WSAStartup;ansi"
Function Int WSACleanup() Library "wsock32.DLL"
Function Int WSAGetLastError() Library "wsock32.DLL"
Function Int gethostname(Ref String Name, Int namelen) Library "wsock32.DLL"  Alias For "gethostname;Ansi"
FUNCTION Long GetUserName (REF String lpBuffer, REF ULong lpnSize) LIBRARY "ADVAPI32.DLL" ALIAS FOR "GetUserNameA;ANSI"
Function String GetHost(String lpszhost,Ref Blob lpszaddress) Library "pbws32.dll" Alias For "GetHost;Ansi"


end prototypes

type variables

end variables

forward prototypes
public subroutine wf_load_form ()
public subroutine wf_set_data ()
public function string wf_get_windowname ()
public function string wf_computer ()
public function string wf_get_username ()
public function string wf_getip (ref string as_mac)
end prototypes

public subroutine wf_load_form ();//====================================================================
// Function: w_about.wf_load_form()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: w_about.wf_load_form ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

ULong ll_handle_w, ll_handle_rec, ll_bottom
Int li_width, li_height
li_width = UnitsToPixels(This.Width ,XUnitsToPixels! )
li_height = UnitsToPixels(This.Height ,YUnitsToPixels! )
ll_handle_rec =  CreateRoundRectRgn(0,25, li_width - 1, li_height - 1,li_height , li_height)
ll_bottom = CreateEllipticRgn(80, li_height, li_width - 80 ,li_height - 50)
ll_handle_w = Handle(This)
SetWindowRgn(ll_handle_w, ll_handle_rec,True)

//remove memory
DeleteObject(ll_handle_rec)
DeleteObject(ll_bottom)

end subroutine

public subroutine wf_set_data ();String ls_window
String ls_computer
String ls_username
String ls_ip, ls_mac

ls_window = wf_get_windowname()
ls_computer = wf_computer()
ls_username = wf_get_username()
ls_ip = wf_getip(ls_mac)

dw_1.setitem(dw_1.getrow(),'as_ip',ls_ip)
dw_1.setitem(dw_1.getrow(),'as_netcard',ls_mac)
dw_1.setitem(dw_1.getrow(),'as_window',ls_window)
dw_1.setitem(dw_1.getrow(),'as_computer',ls_computer)
dw_1.setitem(dw_1.getrow(),'as_user',ls_username)
end subroutine

public function string wf_get_windowname ();//====================================================================
// Function: w_about.wf_get_windowname()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: w_about.wf_get_windowname ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_osversion,ls_osedition,ls_csdversion
Long ll_BuildNumber
String ls_windowname
nvo_func luo_sys
luo_sys = Create nvo_func
luo_sys.of_getosversion( ls_osversion,ls_osedition,ls_csdversion,ll_BuildNumber)
Destroy luo_sys
ls_windowname = ls_osversion + ' ' + ls_osedition + ' ' + ls_csdversion + ' Build(' + String(ll_BuildNumber) + ')'
Return ls_windowname

end function

public function string wf_computer ();//====================================================================
// Function: w_about.wf_computer()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: w_about.wf_computer ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_host
Blob{4} lb_host
Integer li_version, li_rc
str_wsadata lstr_wsadata

ls_host = Space(128)
li_version = 257

If WSAStartup(li_version, lstr_wsadata) = 0 Then
	GetHostName(ls_host, Len(ls_host))
	li_rc = WSAGetLastError()
End If
WSACleanup()
Return ls_host

end function

public function string wf_get_username ();//====================================================================
// Function: w_about.wf_get_username()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: w_about.wf_get_username ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_UserName
ULong ll_NameLength
Long ll_ret
ll_NameLength = 255
ls_UserName = Space (ll_NameLength)
ll_ret = GetUserName(ls_UserName, ll_NameLength)
Return ls_UserName

end function

public function string wf_getip (ref string as_mac);String ls_ip
String ls_macaddress[],ls_description[],ls_adaptername[],ls_ipaddress[]
Long ll_array

nvo_func luo_func
luo_func = Create nvo_func
luo_func.of_getadaptersinfo(ls_macaddress,ls_description,ls_adaptername,ls_ipaddress)
If UpperBound(ls_ipaddress) > 0 Then
	For ll_array = 1 To UpperBound(ls_ipaddress)
		ls_ip = ls_ipaddress[ll_array]
		If Pos(ls_ip, ';') > 0 Then ls_ip = Mid(ls_ip, 1, Pos(ls_ip, ';') - 1)
		If long(mid(ls_ip,1,1)) <> 0 Then
			//return  ls_ip
			Exit;
		Else
			//return ls_ip
		End IF
	Next
End IF
destroy luo_func

If UpperBound(ls_macaddress) > 0 Then
	as_mac = ls_macaddress[1]
End If
return ls_ip

end function

on w_about.create
this.dw_1=create dw_1
this.p_1=create p_1
this.Control[]={this.dw_1,&
this.p_1}
end on

on w_about.destroy
destroy(this.dw_1)
destroy(this.p_1)
end on

event open;String ls_file
Boolean lb_flag

dw_1.InsertRow(0)
wf_load_form()
wf_set_data()


end event

type dw_1 from datawindow within w_about
event ue_dwmousemove pbm_dwnmousemove
integer x = 251
integer y = 184
integer width = 1413
integer height = 620
integer taborder = 20
string title = "none"
string dataobject = "d_about"
boolean border = false
boolean livescroll = true
end type

event ue_dwmousemove;String ls_dwoname_pic1,ls_dwoname_pic2
String ls_modify_1, ls_modify_2,ls_modify_3, ls_modify_4,ls_modify_5,ls_modify_6,ls_modify_7
Integer li_pos
Long i, ll_rowcount,il_MoveCursor
String ls_chk_safe,ls_favourite
String ls_dwoname_pat1,ls_dwoname_pat2,ls_dwoname,ls_dwoname_label
Long ll_buttonface,ll_navy
//==
ls_dwoname = String(dwo.name)
li_pos = Pos(ls_dwoname, 'b_close1')
If li_pos = 0 Then
	li_pos = Pos(ls_dwoname, 'b_close')
End If  
If li_pos > 0 Then 
	//For i = 1 To ll_rowcount
		If ls_dwoname = 'b_close1' Then
			ls_modify_1 = "b_close1.visible = False"
			ls_modify_2 = "b_close.visible = True"
		Else
			If ls_dwoname = 'b_close' Then
				ls_modify_1 = "b_close1.visible = False"
				ls_modify_2 = "b_close.visible = True"
			Else
				ls_modify_1 = "b_close1.visible = True"
				ls_modify_2 = "b_close.visible = False"
			End If
		End If
		This.Modify(ls_modify_1)
		This.Modify(ls_modify_2)
Else
	ls_modify_1 = "b_close1.visible = True"
	ls_modify_2 = "b_close.visible = False"
	This.Modify(ls_modify_1)
	This.Modify(ls_modify_2)
End If
end event

event buttonclicked;Choose Case dwo.name
	Case 'b_close','b_close1'
		Close(parent)
End Choose
end event

event clicked;Choose Case dwo.name
	Case 'b_close'
		Close(parent)
End Choose
end event

type p_1 from picture within w_about
integer width = 1929
integer height = 1008
string picturename = "about.gif"
boolean focusrectangle = false
end type

