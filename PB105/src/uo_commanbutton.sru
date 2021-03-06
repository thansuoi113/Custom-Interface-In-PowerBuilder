$PBExportHeader$uo_commanbutton.sru
forward
global type uo_commanbutton from userobject
end type
type st_text from statictext within uo_commanbutton
end type
end forward

global type uo_commanbutton from userobject
integer width = 453
integer height = 108
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_lbuttondown pbm_lbuttondown
event dd pbm_bndoubleclicked
event ue_lbuttondblclk pbm_lbuttondblclk
event clicked pbm_lbuttonup
st_text st_text
end type
global uo_commanbutton uo_commanbutton

type prototypes
//FUNCTION ulong CreateRoundRectRgn(ulong X1,ulong Y1,ulong X2,ulong Y2,ulong X3,ulong Y3) LIBRARY "gdi32.dll"
FUNCTION ulong SetWindowRgn(ulong hWnd,ulong hRgn,boolean bRedraw) LIBRARY "user32.dll" 

Function Long CreateRoundRectRgn( Long nLeftRect, Long nTopRect, Long nRightRect, Long nBottomRect , Long nWidthEllipse, Long nHeightEllipse) Library "gdi32.dll"
Function Long SetWindowRgn(Long hWnd,Long hRgn,Long bRedraw) Library "user32.dll"
end prototypes

type variables
CONSTANT long  il_number= 5.7
 
boolean ib_bold = false //400-700
boolean ib_underline = false //Underline
boolean ib_strkeout = false //Strikethrough
 
int ii_fontsize=18
string is_text = "Text"
 
long il_ClickedColor = 14589000,il_color =  14120960//il_HoveColor = 14727818,
long il_FontColor = 16777215
long il_radian = 5
 
end variables

forward prototypes
public subroutine of_draw (integer as_choose)
end prototypes

event ue_lbuttondown;of_draw(1)
end event

event ue_lbuttondblclk;of_draw(1)
end event

event clicked;of_draw(0)
 
end event

public subroutine of_draw (integer as_choose);//====================================================================
// Function: uo_commanbutton.of_draw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	as_choose	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Usage: uo_commanbutton.of_draw ( integer as_choose )
//====================================================================


String ls_err,ls_syntax
Long ll_width,ll_height
Long ll_y = 0,ll_x = 0

ll_width = This.Width
ll_height = il_number * ii_fontsize
ll_y = (10+This.Height - ll_height) / 2

Choose Case as_choose
	Case 0
		This.BackColor = il_color
		st_text.BackColor = il_color
	Case 1
		ll_x = 5
		ll_y = ll_y + 5
		This.BackColor = il_ClickedColor
		st_text.BackColor = il_ClickedColor
	Case 1
End Choose

st_text.X = ll_x
st_text.Y = ll_y
st_text.Text = is_text
st_text.TextSize = -ii_fontsize
st_text.Width = ll_width
st_text.Height = This.Height
st_text.TextColor = il_FontColor

If ib_bold Then
	st_text.Weight = 700
Else
	st_text.Weight = 400
End If

st_text.Underline = ib_underline
st_text.Italic = ib_strkeout

// arc angle
Long ll_Rgn
ll_width = UnitsToPixels(This.Width,Xunitstopixels!)
ll_height = UnitsToPixels(This.Height, Yunitstopixels!)
ll_Rgn = Createroundrectrgn(0,0,ll_width,ll_height,il_radian,il_radian)
Setwindowrgn(Handle(This),ll_Rgn,True)
end subroutine

on uo_commanbutton.create
this.st_text=create st_text
this.Control[]={this.st_text}
end on

on uo_commanbutton.destroy
destroy(this.st_text)
end on

event constructor;of_draw(0)
end event

type st_text from statictext within uo_commanbutton
integer width = 457
integer height = 76
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

