$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type uo_1 from uo_commanbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2395
integer height = 1416
boolean titlebar = true
string title = "Custom Interface"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 134217739
string icon = "AppIcon!"
boolean center = true
uo_1 uo_1
cb_2 cb_2
cb_1 cb_1
end type
global w_main w_main

type prototypes
Function Long CreateRoundRectRgn( Long nLeftRect, Long nTopRect, Long nRightRect, Long nBottomRect , Long nWidthEllipse, Long nHeightEllipse) Library "gdi32.dll"
Function Long SetWindowRgn(Long hWnd,Long hRgn,Long bRedraw) Library "user32.dll"
Function Boolean deleteobject( ULong hobject ) Library "gdi32.dll"


end prototypes
on w_main.create
this.uo_1=create uo_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.uo_1,&
this.cb_2,&
this.cb_1}
end on

on w_main.destroy
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type uo_1 from uo_commanbutton within w_main
integer x = 183
integer y = 640
integer width = 987
integer height = 256
integer taborder = 30
boolean ib_bold = true
long il_clickedcolor = 11823615
long il_color = 16777184
long il_fontcolor = 128
long il_radian = 15
end type

on uo_1.destroy
call uo_commanbutton::destroy
end on

event clicked;call super::clicked;//open(w_about)
end event

type cb_2 from commandbutton within w_main
integer x = 1499
integer y = 128
integer width = 622
integer height = 208
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Window"
end type

event clicked;open(w_about)
end event

event constructor;
ULong hWnd
Long li_newRgn

Long nLeftRect // X-coordinate of upper-left corner
Long nTopRect // Y-coordinate of upper-left corner
Long nRightRect // X-coordinate of lower-right corner
Long nBottomRect // Y-coordinate of lower-right corner

ULong nWidthEllipse // width of ellipse
ULong nHeightEllipse // height of ellipse

nLeftRect = 3
nTopRect = 3

nRightRect = UnitsToPixels( This.Width, XUnitsToPixels! ) - 6
nBottomRect = UnitsToPixels( This.Height, YUnitsToPixels! ) - 6

nWidthEllipse = 20
nHeightEllipse = 20

hWnd = Handle( This )

li_newRgn = CreateRoundRectRgn(nLeftRect, nTopRect, nRightRect, nBottomRect, nWidthEllipse, nHeightEllipse)

SetWindowRgn( hWnd, li_newRgn, 1 )


end event

type cb_1 from commandbutton within w_main
integer x = 183
integer y = 128
integer width = 622
integer height = 224
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Button"
end type

event constructor;ULong hWnd
Long il_newRgn

long nLeftRect // x-coordinate of upper-left corner
long nTopRect // y-coordinate of upper-left corner
long nRightRect // x-coordinate of lower-right corner
long nBottomRect // y-coordinate of lower-right corner

ULong nWidthEllipse // width of ellipse
ULong nHeightEllipse // height of ellipse

nLeftRect = 3
nTopRect = 3

nRightRect = UnitsToPixels( This.Width, XUnitsToPixels! )-6
nBottomRect = UnitsToPixels( This.Height, YUnitsToPixels! )-6

nWidthEllipse = 20
nHeightEllipse = 20

hWnd = Handle( This )

il_newRgn = CreateRoundRectRgn(nLeftRect, nTopRect, nRightRect, nBottomRect, nWidthEllipse, nHeightEllipse)

SetWindowRgn( hWnd, il_newRgn, 1 )

end event

