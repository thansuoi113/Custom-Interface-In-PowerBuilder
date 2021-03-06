$PBExportHeader$nvo_func.sru
forward
global type nvo_func from nonvisualobject
end type
type netresource from structure within nvo_func
end type
type str_wsadata from structure within nvo_func
end type
type str_osversioninfo from structure within nvo_func
end type
type ip_addr_string from structure within nvo_func
end type
type ip_adapter_info from structure within nvo_func
end type
type system_info from structure within nvo_func
end type
type osversioninfoex from structure within nvo_func
end type
end forward

type netresource from structure
	long		dwscope
	long		dwtype
	long		dwdisplaytype
	long		dwusage
	string		lplocalname
	string		lpremotename
	string		lpcomment
	string		lpprovider
end type

type str_wsadata from structure
	unsignedinteger		version
	unsignedinteger		highversion
	character		description[257]
	character		systemstatus[129]
	unsignedinteger		maxsockets
	unsignedinteger		maxupddg
	string		vendorinfo
end type

type str_osversioninfo from structure
	ulong		dwOSVersionInfoSize
	ulong		dwmajorversion
	ulong		dwminorversion
	ulong		dwbuildnumber
	ulong		dwplatformid
	CHARACTER		SZCSDVERION[128]
end type

type ip_addr_string from structure
	unsignedlong		nextptr
	character		ipaddress[16]
	character		ipmask[16]
	unsignedlong		context
end type

type ip_adapter_info from structure
	unsignedlong		nextptr
	unsignedlong		comboindex
	character		adaptername[260]
	character		description[132]
	unsignedlong		addresslength
	long		address[2]
	unsignedlong		index
	unsignedinteger		adaptertype
	unsignedinteger		dhcpenabled
	unsignedlong		currentipaddress
	unsignedlong		reserved1
	ip_addr_string		ipaddresslist
	ip_addr_string		gatewaylist
	ip_addr_string		dhcpserver
	boolean		havewins
	unsignedinteger		reserved2
	ip_addr_string		primarywinsserver
	ip_addr_string		secondarywinsserver
	unsignedlong		leaseobtained
	unsignedlong		leaseexpires
end type

type system_info from structure
	unsignedinteger		wprocessorarchitecture
	unsignedinteger		wreserved
	unsignedlong		dwpagesize
	unsignedlong		lpminimumapplicationaddress
	unsignedlong		lpmaximumapplicationaddress
	unsignedlong		dwactiveprocessormask
	unsignedlong		dwnumberofprocessors
	unsignedlong		dwprocessortype
	unsignedlong		dwallocationgranularity
	unsignedinteger		wprocessorlevel
	unsignedinteger		wprocessorrevsion
end type

type osversioninfoex from structure
	unsignedlong		dwosversioninfosize
	unsignedlong		dwmajorversion
	unsignedlong		dwminorversion
	unsignedlong		dwbuildnumber
	unsignedlong		dwplatformid
	character		szcsdversion[128]
	unsignedinteger		wservicepackmajor
	unsignedinteger		wservicepackminor
	unsignedinteger		wsuitemask
	unsignedinteger		wproducttype
end type

global type nvo_func from nonvisualobject
end type
global nvo_func nvo_func

type prototypes
Function Boolean GetComputerNameA(ref string cname,ref long nbuf) library "Kernel32.dll" ALIAS FOR "GetComputerNameA;ANSI"
Function ULONG WNetAddConnection2(NetResource lpNetResource,STRING lpPassword,STRING lpUserName,ULONG dwFlags) LIBRARY "mpr.dll" ALIAS FOR "WNetAddConnection2A;ANSI"
Function long WNetCancelConnection (String lpszName, Long bForce) Library "mpr.dll" Alias for "WNetCancelConnectionA" 
Function long WNetCancelConnection2 (String lpName , Long dwFlags, Long fForce) Library "mpr.dll" Alias for "WNetCancelConnection2A;ANSI" 
function int WSAStartup (uint UIVerionrequested, ref str_wsadata lpWSAdata) library "wsock32.DLL" alias for "WSAStartup;ansi"
function int WSACleanup() library "wsock32.DLL"
function int WSAGetLastError() library "wsock32.DLL"
function int gethostname(ref string name, int namelen) library "wsock32.DLL"  alias for "gethostname;Ansi"
function string GetHost(string lpszhost,ref blob lpszaddress) library "PBWS32.DLL" alias for "GetHost;Ansi"
Function ulong GetVersionExA( REF str_osversioninfo lpVersionInfo ) library "kernel32.dll"

//Get Computer Language
Function int GetLocaleInfoA(ulong locale,ulong lctype,REF string data,int size) library "kernel32.dll" alias for "GetLocaleInfoA;Ansi"
Function ulong GetSystemDefaultLCID() library "kernel32.dll" 

//Determine If windows's 64bit
Function Boolean IsWow64Process( &
   long hProcess, &
	ref  boolean Wow64Process &
	) library "kernel32.dll"
	
Function long GetCurrentProcess() library "kernel32.dll"

//Encryt Password
Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"

Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryW"
//NetWkstaGetInfo
//Get Adapter Info
Function ulong GetAdaptersInfo ( &
	Ref IP_ADAPTER_INFO pAdapterInfo[], &
	Ref ulong pOutBufLen &
	) Library "iphlpapi.dll" Alias For "GetAdaptersInfo;Ansi"
	
Subroutine CopyMemory ( &
	Ref blob Destination, &
	long Source[], &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory"

Subroutine CopyMemory ( &
	Ref integer Destination, &
	blob Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory"
	
//OsVersion
Function integer GetSystemMetrics ( &
	integer nIndex &
	) Library "user32.dll"
	
Subroutine GetNativeSystemInfo ( &
	Ref SYSTEM_INFO lpSystemInfo &
	) Library "kernel32.dll"

Subroutine GetSystemInfo ( &
	Ref SYSTEM_INFO lpSystemInfo &
	) Library "kernel32.dll"
	
Function Boolean GetVersionEx ( &
	Ref OSVERSIONINFOEX lpVersionInformation &
	) Library "kernel32.dll" Alias For "GetVersionExW"
	
Function ulong NetWkstaGetInfo( &
	string servername, &
	ulong level, &
	ref ulong bufptr &
	) Library "netapi32.dll" Alias for "NetWkstaGetInfo"

Function ulong NetApiBufferFree( &
	ulong Buffer &
	) Library "netapi32.dll"
	
Function ulong CopyMemory( &
	ref ulong dest, &
	ulong source, &
	ulong size &
	) Library "kernel32.dll" Alias For "RtlMoveMemory"
	
Function Boolean GetProductInfo ( &
	ulong dwOSMajorVersion, &
	ulong dwOSMinorVersion, &
	ulong dwSpMajorVersion, &
	ulong dwSpMinorVersion, &
	Ref ulong pdwReturnedProductType &
	) Library "kernel32.dll"
end prototypes

type variables
Uint 		MajorVersion, MinorVersion, BuildNumber, ServicePackMajor, ServicePackMinor, SuiteMask, ProductType





end variables

forward prototypes
public function boolean of_notspace (string as_data)
public function boolean of_notspace (integer ai_data)
public function string of_find_driver ()
public function long of_connectnetdrive (string remotesharename, string localdrive, string username, string password)
public function string of_replace_all (string as_data, string as_find, string as_replace)
public function string of_decode (string as_data)
public function string of_encode (string as_data)
public subroutine of_parsing (string as_data, string as_symbol, ref string as_out[])
public function string of_nbr2hex (unsignedlong aul_number, integer ai_digit)
public function boolean of_getadaptersinfo (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[])
public function unsignedlong of_getpointer (unsignedlong aul_baseptr, integer ai_ptrnum, integer ai_arraynum, integer ai_ptrcnt)
public subroutine of_osversion (ref unsignedlong aul_osmajor, ref unsignedlong aul_osminor)
public function unsignedinteger of_bitwiseand (unsignedinteger aui_value1, unsignedinteger aui_value2)
public function unsignedlong of_bitwiseand (unsignedlong aul_value1, unsignedlong aul_value2)
public function integer of_getosbits ()
public function string of_getproductinfo ()
public function integer of_disconnectnetdrive (string as_path)
public function integer of_connectnetdrive (string remotesharename, string username, string password)
public subroutine of_get_win_lang (ref string as_win_lang)
public function boolean of_getosversion (ref string as_osversion, ref string as_osedition, ref string as_csdversion, ref long as_buildnumber)
end prototypes

public function boolean of_notspace (string as_data);//====================================================================
// Function: nvo_func.of_notspace()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_data	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_notspace ( string as_data )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If Trim(as_data) = '' Or Len(Trim(as_data)) = 0 Or Isnull(Trim(as_data)) Then Return False

Return True
end function

public function boolean of_notspace (integer ai_data);//====================================================================
// Function: nvo_func.of_notspace()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ai_data	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_notspace ( integer ai_data )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If Isnull(ai_data) Or ai_data < 0 Then Return False

Return True
end function

public function string of_find_driver ();//====================================================================
// Function: nvo_func.of_find_driver()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_find_driver ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int i,li_end

li_end = Asc('G')
For i = Asc('Z') To li_end Step -1
	If Not DirectoryExists(Char(i) + ":") Then
		Return Char(i) + ":"
	End If
Next

Return ''

end function

public function long of_connectnetdrive (string remotesharename, string localdrive, string username, string password);//====================================================================
// Function: nvo_func.of_connectnetdrive()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	remotesharename	
// 	value	string	localdrive     	
// 	value	string	username       	
// 	value	string	password       	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_connectnetdrive ( string remotesharename, string localdrive, string username, string password )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant Long NO_ERROR = 0
Constant Long ERROR_ACCESS_DENIED = 5
Constant Long ERROR_ALREADY_ASSIGNED = 85
Constant Long ERROR_BAD_NET_NAME = 67
Constant Long ERROR_NO_NETWORK = 1222
Constant Long ERROR_SESSION_CREDENTIAL_CONFLICT = 1219
Constant Long RESOURCE_GLOBALNET = 2
Constant Long RESOURCE_REMEMBERED = 3
Constant Long RESOURCE_CONNECTED = 1
Constant Long RESOURCETYPE_DISK = 1
Constant Long RESOURCETYPE_PRINT = 2
Constant Long RESOURCETYPE_ANY = 0
Constant Long RESOURCEDISPLAYTYPE_DOMAIN = 1
Constant Long RESOURCEDISPLAYTYPE_GENERIC = 0
Constant Long RESOURCEDISPLAYTYPE_SERVER = 2
Constant Long RESOURCEDISPLAYTYPE_SHARE = 3
Constant Long RESOURCEDISPLAYTYPE_GROUP = 5
Constant Long RESOURCEDISPLAYTYPE_FILE = 4
Constant Long RESOURCEUSAGE_CONNECTABLE = 1
Constant Long RESOURCEUSAGE_CONTAINER = 2
Constant Long RESOURCEUSAGE_ALL = 0

NetResource nr
String nullstr

SetNull(nullstr)

nr.dwScope        = RESOURCE_GLOBALNET
nr.dwType         = RESOURCETYPE_DISK
nr.dwDisplayType  = RESOURCEDISPLAYTYPE_GENERIC
nr.dwUsage        = RESOURCEUSAGE_CONNECTABLE
nr.lpLocalName    = localdrive //  Z:
nr.lpRemoteName   = remotesharename // 
nr.lpComment      = ''
nr.lpProvider     = nullstr

Return WNetAddConnection2(nr,Password,username,0)


end function

public function string of_replace_all (string as_data, string as_find, string as_replace);//====================================================================
// Function: nvo_func.of_replace_all()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_data   	
// 	value	string	as_find   	
// 	value	string	as_replace	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_replace_all ( string as_data, string as_find, string as_replace )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_newstring
Long   ll_find, ll_replace, ll_pos

// get length of strings
ll_find = Len(as_find)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_data
ll_pos = Pos(ls_newstring, as_find)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_find, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_find, (ll_pos + ll_replace))
Loop

Return ls_newstring


end function

public function string of_decode (string as_data);//====================================================================
// Function: nvo_func.of_decode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_data	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_decode ( string as_data )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Constant ULong CRYPT_STRING_BASE64 = 1
Blob    lblob_data
ULong   lul_len, lul_buflen, lul_skip, lul_pflags
Boolean lb_rtn
String  ls_decode

ls_decode  = as_data // the value to be decoded

lul_len    = Len(ls_decode)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len))

lb_rtn    = CryptStringToBinary(ls_decode, lul_len, CRYPT_STRING_BASE64, lblob_data, lul_buflen, lul_skip, lul_pflags)

ls_decode = String(BlobMid(lblob_data, 1, lul_buflen))

Return ls_decode

end function

public function string of_encode (string as_data);//====================================================================
// Function: nvo_func.of_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_data	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_encode ( string as_data )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant ULong CRYPT_STRING_BASE64 = 1
String  ls_encode
ULong   lul_len, lul_buflen
Boolean lb_rtn
Blob    Value

// the value to be encoded, needs to be 3 char or more (but not 4?)
//value = blob(as_data,  EncodingANSI!)
Value = Blob(as_data)

lul_len    = Len(Value)
lul_buflen = lul_len * 2
ls_encode = Space(lul_buflen)

lb_rtn = CryptBinaryToString(Value, lul_len, CRYPT_STRING_BASE64, ls_encode, lul_buflen)

//If lb_rtn Then 
ls_encode = Left(ls_encode, Len(ls_encode) - 2 )

Return ls_encode




end function

public subroutine of_parsing (string as_data, string as_symbol, ref string as_out[]);//====================================================================
// Function: nvo_func.of_parsing()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	string	as_data  	
// 	value    	string	as_symbol	
// 	reference	string	as_out[] 	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_parsing ( string as_data, string as_symbol, ref string as_out[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long   ll_find, ll_array

If Not of_notspace(as_symbol) Then as_symbol = '|'

ll_find   = Pos(as_data, as_symbol)
ll_array = 0
Do While ll_find > 0
	ll_array ++
	
	as_out[ll_array] = Mid(as_data, 1, ll_find - 1)
	as_data  = Mid(as_data, ll_find + Len(as_symbol)) //
	
	ll_find   = Pos(as_data, as_symbol)
Loop

If of_notspace(as_data) Then as_out[ll_array + 1] = as_data

end subroutine

public function string of_nbr2hex (unsignedlong aul_number, integer ai_digit);//====================================================================
// Function: nvo_func.of_nbr2hex()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	unsignedlong	aul_number	
// 	value	integer     	ai_digit  	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_nbr2hex ( unsignedlong aul_number, integer ai_digit )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


ULong lul_temp0, lul_temp1
Char lc_ret

If ai_digit > 0 Then
	lul_temp0 = Abs(aul_number / (16 ^ (ai_digit - 1)))
	lul_temp1 = lul_temp0 * (16 ^ (ai_digit - 1))
	If lul_temp0 > 9 Then
		lc_ret = Char(lul_temp0 + 55)
	Else
		lc_ret = Char(lul_temp0 + 48)
	End If
	Return lc_ret + of_Nbr2Hex(aul_number - lul_temp1, ai_digit - 1)
End If

Return ""


end function

public function boolean of_getadaptersinfo (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[]);//====================================================================
// Function: nvo_func.of_getadaptersinfo()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	string	as_macaddress[] 	
// 	reference	string	as_description[]	
// 	reference	string	as_adaptername[]	
// 	reference	string	as_ipaddress[]  	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_getadaptersinfo ( ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant ULong ERROR_SUCCESS = 0
Constant ULong ERROR_BUFFER_OVERFLOW = 111
IP_ADAPTER_INFO lstr_Adapter[]
ULong   lul_OutBufLen
Integer li_idx, li_max, li_macidx, li_macmax, li_byte
Blob    lblob_address

// call function to get buffer size
If GetAdaptersInfo(lstr_Adapter, lul_OutBufLen) = ERROR_BUFFER_OVERFLOW Then
	// how many adapters?
	li_max = lul_OutBufLen / 640
	// allocate structure
	lstr_Adapter[li_max].NextPtr = 0
	// call function to get data
	If GetAdaptersInfo(lstr_Adapter, lul_OutBufLen) = ERROR_SUCCESS Then
		For li_idx = 1 To li_max
			// get adapter information
			as_description[li_idx] = String(lstr_Adapter[li_idx].Description)
			as_adaptername[li_idx] = String(lstr_Adapter[li_idx].AdapterName)
			as_ipaddress[li_idx]   = String(lstr_Adapter[li_idx].IpAddressList.IpAddress)
			// convert MAC address from blob data
			li_macmax = lstr_Adapter[li_idx].AddressLength
			lblob_address = Blob(Space(li_macmax))
			CopyMemory(lblob_address, lstr_Adapter[li_idx].Address, li_macmax)
			For li_macidx = 1 To li_macmax
				CopyMemory(li_byte, BlobMid(lblob_address, li_macidx, 1), 1)
				as_macaddress[li_idx] += of_Nbr2Hex(li_byte, 2)
				If li_macidx < li_macmax Then
					as_macaddress[li_idx] += "-"
				End If
			Next
		Next
		Return True
	End If
End If

Return False

end function

public function unsignedlong of_getpointer (unsignedlong aul_baseptr, integer ai_ptrnum, integer ai_arraynum, integer ai_ptrcnt);//====================================================================
// Function: nvo_func.of_getpointer()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	unsignedlong	aul_baseptr	
// 	value	integer     	ai_ptrnum  	
// 	value	integer     	ai_arraynum	
// 	value	integer     	ai_ptrcnt  	
//--------------------------------------------------------------------
// Returns:  unsignedlong
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_getpointer ( unsignedlong aul_baseptr, integer ai_ptrnum, integer ai_arraynum, integer ai_ptrcnt )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

ULong lul_bufptr, lul_strptr

// calculate memory location
lul_bufptr = aul_baseptr + ((ai_arraynum - 1) * (ai_ptrcnt * 4)) + ((ai_ptrnum - 1) * 4)

// copy pointer into local variable
CopyMemory(lul_strptr, lul_bufptr, 4)

Return lul_strptr


end function

public subroutine of_osversion (ref unsignedlong aul_osmajor, ref unsignedlong aul_osminor);//====================================================================
// Function: nvo_func.of_osversion()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	unsignedlong	aul_osmajor	
// 	reference	unsignedlong	aul_osminor	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_osversion ( ref unsignedlong aul_osmajor, ref unsignedlong aul_osminor )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Constant ULong NERR_Success = 0
ULong lul_Return, lul_BufPtr
String ls_ServerName

SetNull(ls_ServerName)

lul_Return = NetWkstaGetInfo(ls_ServerName, 100, lul_BufPtr)
If lul_Return = NERR_Success Then
	// get operating system version
	aul_osmajor = of_GetPointer(lul_BufPtr, 4, 1, 5)
	aul_osminor = of_GetPointer(lul_BufPtr, 5, 1, 5)
Else
	/*MessageBox("NetWkstaGetInfo", &
	"A system error has occurred: " + String(lul_Return), StopSign!)*/
End If
	
// free buffer
If lul_BufPtr > 0 Then
	NetAPIBufferFree(lul_BufPtr)
End If
	

end subroutine

public function unsignedinteger of_bitwiseand (unsignedinteger aui_value1, unsignedinteger aui_value2);//====================================================================
// Function: nvo_func.of_bitwiseand()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	unsignedinteger	aui_value1	
// 	value	unsignedinteger	aui_value2	
//--------------------------------------------------------------------
// Returns:  unsignedinteger
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_bitwiseand ( unsignedinteger aui_value1, unsignedinteger aui_value2 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_i
UInt    lui_result, lui_factor

If IsNull( aui_value1) Or IsNull( aui_value2) Then
	SetNull( lui_result)
	Return lui_result
End If

lui_result = 0
For li_i = 1 To 16
	If aui_value1 = 0 Or aui_value2 = 0 Then Exit
	If li_i = 1 Then
		lui_factor = 1
	Else
		lui_factor = lui_factor * 2
	End If
	If Mod( aui_value1, 2) = 1 And Mod( aui_value2, 2) = 1 Then
		lui_result += lui_factor
	End If
	aui_value1 = aui_value1 / 2
	aui_value2 = aui_value2 / 2
Next

Return lui_result

end function

public function unsignedlong of_bitwiseand (unsignedlong aul_value1, unsignedlong aul_value2);//====================================================================
// Function: nvo_func.of_bitwiseand()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	unsignedlong	aul_value1	
// 	value	unsignedlong	aul_value2	
//--------------------------------------------------------------------
// Returns:  unsignedlong
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_bitwiseand ( unsignedlong aul_value1, unsignedlong aul_value2 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_i
ULong   lul_result, lul_factor

If IsNull( aul_value1) Or IsNull( aul_value2) Then
	SetNull( lul_result)
	Return lul_result
End If

lul_result = 0
For li_i = 1 To 32
	If aul_value1 = 0 Or aul_value2 = 0 Then Exit
	If li_i = 1 Then
		lul_factor = 1
	Else
		lul_factor = lul_factor * 2
	End If
	If Mod( aul_value1, 2) = 1 And Mod( aul_value2, 2) = 1 Then
		lul_result += lul_factor
	End If
	aul_value1 = aul_value1 / 2
	aul_value2 = aul_value2 / 2
Next

Return lul_result

end function

public function integer of_getosbits ();//====================================================================
// Function: nvo_func.of_getosbits()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_getosbits ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant Long PROCESSOR_ARCHITECTURE_INTEL = 0 // x86
Constant Long PROCESSOR_ARCHITECTURE_IA64  = 6 // Intel Itanium-based
Constant Long PROCESSOR_ARCHITECTURE_AMD64 = 9 // x64 (AMD or Intel)
SYSTEM_INFO lstr_si
Integer li_bits
Boolean lb_IsWow64

IsWOW64Process(GetCurrentProcess(), lb_IsWow64)

If lb_IsWow64 Then
	GetNativeSystemInfo(lstr_si)
Else
	GetSystemInfo(lstr_si)
End If

Choose Case lstr_si.wProcessorArchitecture
	Case PROCESSOR_ARCHITECTURE_IA64
		li_bits = 64
	Case PROCESSOR_ARCHITECTURE_AMD64
		li_bits = 64
	Case Else
		li_bits = 32
End Choose

Return li_bits


end function

public function string of_getproductinfo ();//====================================================================
// Function: nvo_func.of_getproductinfo()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_getproductinfo ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_info
ULong lul_ProductType
Boolean lb_rtn

lb_rtn = GetProductInfo(MajorVersion, MinorVersion, &
	ServicePackMajor, ServicePackMinor, lul_ProductType)

// this is just a few of the types
Choose Case lul_ProductType
	Case 1 // 0x00000001 - PRODUCT_ULTIMATE
		ls_info = "Ultimate"
	Case 48 // 0x00000030 - PRODUCT_PROFESSIONAL
		ls_info = "Professional"
	Case 3 // 0x00000003 - PRODUCT_HOME_PREMIUM
		ls_info = "Home Premium"
	Case 2 // 0x00000002 - PRODUCT_HOME_BASIC
		ls_info = "Home Basic"
	Case 4 // 0x00000004 - PRODUCT_ENTERPRISE
		ls_info = "Enterprise"
	Case 6 // 0x00000006 - PRODUCT_BUSINESS
		ls_info = "Business"
	Case 11 // 0x0000000B - PRODUCT_STARTER
		ls_info = "Starter"
	Case 18 // 0x00000012 - PRODUCT_CLUSTER_SERVER
		ls_info = "Cluster Server"
	Case 8 // 0x00000008 - PRODUCT_DATACENTER_SERVER
		ls_info = "Datacenter (full installation)"
	Case 12 // 0x0000000C - PRODUCT_DATACENTER_SERVER_CORE
		ls_info = "Datacenter (core installation)"
	Case 72 // 0x00000048 - PRODUCT_ENTERPRISE_EVALUATION
		ls_info = "Enterprise (evaluation installation)"
	Case 10 // 0x0000000A - PRODUCT_ENTERPRISE_SERVER
		ls_info = "Enterprise (full installation)"
	Case 14 // 0x0000000E - PRODUCT_ENTERPRISE_SERVER_CORE
		ls_info = "Enterprise (core installation)"
	Case 15 // 0x0000000F - PRODUCT_ENTERPRISE_SERVER_IA64
		ls_info = "Enterprise for Itanium-based Systems"
	Case 9 // 0x00000009 - PRODUCT_SMALLBUSINESS_SERVER
		ls_info = "Small Business"
	Case 25 // 0x00000019 - PRODUCT_SMALLBUSINESS_SERVER_PREMIUM
		ls_info = "Small Business Premium"
	Case 7 // 0x00000007 - PRODUCT_STANDARD_SERVER
		ls_info = "Standard"
	Case 13 // 0x0000000D - PRODUCT_STANDARD_SERVER_CORE
		ls_info = "Standard (core installation)"
	Case 17 // 0x00000011 - PRODUCT_WEB_SERVER
		ls_info = "Web Server (full installation)"
	Case 29 // 0x0000001D - PRODUCT_WEB_SERVER
		ls_info = "Web Server (core installation)"
	Case 101 // 0x00000065 - PRODUCT_CORE
		ls_info = ""
	Case 100 // 0x00000064 - PRODUCT_CORE_SINGLELANGUAGE
		ls_info = "Single Language"
	Case Else
		ls_info = "lul_ProductType: " + String(lul_ProductType)
End Choose

Return ls_info


end function

public function integer of_disconnectnetdrive (string as_path);

If of_notspace(as_path) Then Return WNetCancelConnection2(as_path,1,1)

end function

public function integer of_connectnetdrive (string remotesharename, string username, string password);//====================================================================
// Function: nvo_func.of_connectnetdrive()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	remotesharename	
// 	value	string	username       	
// 	value	string	password       	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_connectnetdrive ( string remotesharename, string username, string password )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant Long NO_ERROR = 0
Constant Long ERROR_ACCESS_DENIED = 5
Constant Long ERROR_ALREADY_ASSIGNED = 85
Constant Long ERROR_BAD_NET_NAME = 67
Constant Long ERROR_NO_NETWORK = 1222
Constant Long ERROR_SESSION_CREDENTIAL_CONFLICT = 1219
Constant Long RESOURCE_GLOBALNET = 2
Constant Long RESOURCE_REMEMBERED = 3
Constant Long RESOURCE_CONNECTED = 1
Constant Long RESOURCETYPE_DISK = 1
Constant Long RESOURCETYPE_PRINT = 2
Constant Long RESOURCETYPE_ANY = 0
Constant Long RESOURCEDISPLAYTYPE_DOMAIN = 1
Constant Long RESOURCEDISPLAYTYPE_GENERIC = 0
Constant Long RESOURCEDISPLAYTYPE_SERVER = 2
Constant Long RESOURCEDISPLAYTYPE_SHARE = 3
Constant Long RESOURCEDISPLAYTYPE_GROUP = 5
Constant Long RESOURCEDISPLAYTYPE_FILE = 4
Constant Long RESOURCEUSAGE_CONNECTABLE = 1
Constant Long RESOURCEUSAGE_CONTAINER = 2
Constant Long RESOURCEUSAGE_ALL = 0

NetResource nr
String nullstr

SetNull(nullstr)

nr.dwScope        = RESOURCE_GLOBALNET
nr.dwType         = RESOURCETYPE_DISK
nr.dwDisplayType  = RESOURCEDISPLAYTYPE_GENERIC
nr.dwUsage        = RESOURCEUSAGE_CONNECTABLE
nr.lpLocalName    = nullstr //  Z:
nr.lpRemoteName   = remotesharename // 
nr.lpComment      = ''
nr.lpProvider     = nullstr

Return WNetAddConnection2(nr,Password,username,0)


end function

public subroutine of_get_win_lang (ref string as_win_lang);//====================================================================
// Function: nvo_func.of_get_win_lang()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	string	as_win_lang	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_get_win_lang ( ref string as_win_lang )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Constant Long LOCALE_ILANGUAGE = 1 //LANGID  in hexadecimal digits
Constant Long LOCALE_SLANGUAGE = 2 //Full localized name of the language
Constant Long LOCALE_SENGLANGUAGE = 4097 //Full English U.S. name of the language ISO Standard 639
Constant Long LOCALE_SABBREVLANGNAME = 3 //Abbreviated name of the language, ISO Standard 639
Constant Long LOCALE_SNATIVELANGNAME = 4 //Native name of the language
Constant Long LOCALE_ICOUNTRY = 5 //Country code, based on international phone codes
Constant Long LOCALE_SCOUNTRY = 6 //The full localized name of the country.

String ls_buffer, ls_str
ULong  lul_size

ls_str = Space(128)
/*
Abbreviated name of the language. In most cases, the name is created by taking the two-letter 
language abbreviation from ISO Standard 639 and adding a third letter, as appropriate, 
to indicate the sublanguage. For example, the abbreviated name for the language corresponding
to the English (United States) locale is ENU.
*/
GetLocaleInfoA( GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, as_win_lang,128)



end subroutine

public function boolean of_getosversion (ref string as_osversion, ref string as_osedition, ref string as_csdversion, ref long as_buildnumber);//====================================================================
// Function: nvo_func.of_getosversion()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	string	as_osversion  	
// 	reference	string	as_osedition  	
// 	reference	string	as_csdversion 	
// 	reference	long  	as_buildnumber	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/04/03
//--------------------------------------------------------------------
// Usage: nvo_func.of_getosversion ( ref string as_osversion, ref string as_osedition, ref string as_csdversion, ref long as_buildnumber )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


OSVERSIONINFOEX lstr_ovi
Constant Integer SM_TABLETPC = 86
Constant Integer SM_MEDIACENTER = 87
Constant Integer SM_STARTER = 88
Constant Integer SM_SERVERR2 = 89
Constant UInt VER_NT_SERVER = 3
Constant UInt VER_NT_WORKSTATION = 1
Constant UInt VER_SUITE_SMALLBUSINESS = 1
Constant UInt VER_SUITE_ENTERPRISE = 2
Constant UInt VER_SUITE_TERMINAL = 16
Constant UInt VER_SUITE_EMBEDDEDNT = 64
Constant UInt VER_SUITE_DATACENTER = 128
Constant UInt VER_SUITE_SINGLEUSERRTS = 256
Constant UInt VER_SUITE_PERSONAL = 512
Constant UInt VER_SUITE_BLADE = 1024
Constant UInt VER_SUITE_STORAGE_SERVER = 8192
Constant UInt VER_SUITE_COMPUTE_SERVER = 16384
Constant UInt VER_SUITE_WH_SERVER = 32768

as_osversion  = ""
as_osedition  = ""
as_csdversion = ""

lstr_ovi.dwOSVersionInfoSize = 284 // for Ansi use 156

// call function
If Not GetVersionEx(lstr_ovi) Then Return False

// use NetWkstaGetInfo to get true OS Version
of_OSVersion(lstr_ovi.dwMajorVersion, lstr_ovi.dwMinorVersion)

// save values to instance variables
MajorVersion		 = lstr_ovi.dwMajorVersion
MinorVersion		 = lstr_ovi.dwMinorVersion
BuildNumber			 = lstr_ovi.dwBuildNumber
ServicePackMajor	 = lstr_ovi.wServicePackMajor
ServicePackMinor	 = lstr_ovi.wServicePackMinor
SuiteMask			 = lstr_ovi.wSuiteMask
ProductType			 = lstr_ovi.wProductType
as_BuildNumber = BuildNumber
// populate by ref string arguments
Choose Case lstr_ovi.dwMajorVersion
	Case 3
		as_osversion = "Windows NT 3.51"
	Case 4
		as_osversion = "Windows NT 4"
		Choose Case lstr_ovi.wProductType
			Case 1
				as_osedition = "Workstation"
			Case 3
				If lstr_ovi.wSuiteMask = 2 Then
					as_osedition = "Server Enterprise"
				Else
					as_osedition = "Server Standard"
				End If
		End Choose
	Case 5
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		Choose Case lstr_ovi.dwMinorVersion
			Case 0
				as_osversion = "Windows 2000"
				Choose Case lstr_ovi.wProductType
					Case VER_NT_WORKSTATION
						as_osedition = "Professional"
					Case VER_NT_SERVER
						as_osedition = "Server"
				End Choose
			Case 1
				as_osversion = "Windows XP"
				If lstr_ovi.wSuiteMask = 0 Or &
					of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_TERMINAL + VER_SUITE_SINGLEUSERRTS) <> 0 Then
					as_osedition = "Professional"
				ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_EMBEDDEDNT) <> 0 Then
					as_osedition = "Embedded"
				ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_PERSONAL) <> 0 Then
					as_osedition = "Home Edition"
				ElseIf GetSystemMetrics(SM_MEDIACENTER) > 0 Then
					as_osedition = "Media Center Edition"
				ElseIf GetSystemMetrics(SM_STARTER) > 0 Then
					as_osedition = "Starter Edition"
				ElseIf GetSystemMetrics(SM_TABLETPC) > 0 Then
					as_osedition = "Tablet PC Edition"
				Else
					as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
				End If
			Case 2
				If GetSystemMetrics(SM_SERVERR2) > 0 Then
					as_osversion = "Windows Server 2003 R2"
				ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_STORAGE_SERVER) <> 0 Then
					as_osversion = "Windows Storage Server 2003"
				ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_WH_SERVER) <> 0 Then
					as_osversion = "Windows Home Server"
				ElseIf lstr_ovi.wProductType = VER_NT_WORKSTATION And of_GetOSBits() = 64 Then
					as_osversion = "Windows XP"
					as_osedition = "Professional x64 Edition"
				Else
					as_osversion = "Windows Server 2003"
				End If
				If as_osedition = "" Then
					If of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_COMPUTE_SERVER) <> 0 Then
						as_osedition = "Compute Cluster Edition"
					ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_DATACENTER) <> 0 Then
						as_osedition = "Datacenter Edition"
					ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_ENTERPRISE) <> 0 Then
						as_osedition = "Enterprise Edition"
					ElseIf of_BitwiseAnd(lstr_ovi.wSuiteMask, VER_SUITE_BLADE) <> 0 Then
						as_osedition = "Web Edition"
					Else
						as_osedition = "Standard Edition"
					End If
				End If
			Case Else
				as_osversion = "Windows " + &
					String(lstr_ovi.dwMajorVersion) + String(lstr_ovi.dwMinorVersion)
				as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
		End Choose
	Case 6
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		Choose Case lstr_ovi.dwMinorVersion
			Case 0
				Choose Case lstr_ovi.wProductType
					Case VER_NT_SERVER
						as_osversion = "Windows Server 2008"
						as_osedition = of_GetProductInfo()
					Case Else
						as_osversion = "Windows Vista"
						as_osedition = of_GetProductInfo()
				End Choose
			Case 1
				Choose Case lstr_ovi.wProductType
					Case VER_NT_SERVER
						as_osversion = "Windows Server 2008 R2"
						as_osedition = of_GetProductInfo()
					Case Else
						as_osversion = "Windows 7"
						as_osedition = of_GetProductInfo()
				End Choose
			Case 2
				Choose Case lstr_ovi.wProductType
					Case VER_NT_SERVER
						as_osversion = "Windows Server 2012"
						as_osedition = of_GetProductInfo()
					Case Else
						as_osversion = "Windows 8"
						as_osedition = of_GetProductInfo()
				End Choose
			Case 3
				as_osversion = "Windows 8.1"
				as_osedition = of_GetProductInfo()
		End Choose
	Case Else
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		as_osversion = "Windows " + String(lstr_ovi.dwMajorVersion) + String(lstr_ovi.dwMinorVersion)
		as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
End Choose

Return True


end function

on nvo_func.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_func.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

