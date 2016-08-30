#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\2609\电脑硬件桌面图标下载0.ico
#AutoIt3Wrapper_outfile=Smart_Driver_V1.0.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Smart_Driver
#AutoIt3Wrapper_Res_Description=Smart_Driver
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Smart_Driver_V1.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#cs================================================================
自定义变量的声明：
$zcxtj ;主程序所有的文件放置的途径
$initj ;ini文件所在的途径
$zdm ;先打开ini文件读取全部字符，之后在用正则表达式匹配[]，返回得到一个数组。
$gjz ;先打开ini文件读取全部字符，之后在用正则表达式匹配=，返回得到一个数组。
$fx[?][2] ;从$zdm数组中读取数组的数字大小，在设置这个2维数组的大小，使这个数组定义不被浪费,在树状图中做父项，读取的是ini文件的字段字。
$zx[?][2] ;从$zdm数组中读取数组的数字大小，在设置这个2维数组的大小，使这个数组定义不被浪费，在树状图中做子项，读取的是ini文件的关键字。
$a1 , $a3 ;定义循环用的常量，没什么意义。
#ce================================================================
;==================================================================
;程序中所用到的变量，在此进行定义
Opt("TrayMenuMode",1)
Dim $a1 = -1 , $a3 = -1
Global $zcxtj = "C:\WINDOWS\temp\Smart_Driver.Temp"
Global $initj = @ScriptDir & "\Ini\Drivers.ini"
Global $zdm = StringRegExp(FileRead($initj),"\[.+\]",3) ,$gjz = StringRegExp(FileRead($initj),"=",3)
Global $fx[UBound($zdm)][2] , $zx[UBound($gjz)][2]
Global $CPU = "" , $beiqiao = "" , $nanqiao = "" , $Audio = "" , $Vidao = "" , $Network = "" ,$str , $DPInstcs , $Dll;====>应和下面的函数外部调用造成的变量没定义，基本没什么意义
Dim $time = 10 ;应和下面begin_time()函数的倒计时，没什么太大意义
;==================================================================
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
;==================================================================
;定义函数，自行添加的头文件
#Include <GuiListView.au3>;此头文件为调用_GUICtrlListView_SetColumnWidth函数所必须的
#Include <GuiTreeView.au3>;此头文件为调用_GUICtrlTreeView_GetChildCount函数所必须的
#include <ProgressConstants.au3>;此头文件为调用进度条所必须的
#Include <WinAPIEx.au3>;此头文件为调用_WinAPI_SetDriverSigning()所必须的
;==================================================================
#Region ### START Koda GUI section ### 
DirCreate($zcxtj)
;==================================================================
;程序打包的软件
FileInstall("Tools1\7za.exe",$zcxtj & "\7za.exe",1)
FileInstall("Tools1\DPInst.exe",$zcxtj & "\DPInst.exe",1)
FileInstall("Skin\Skin.dll",$zcxtj & "\Skin.dll",1)
FileInstall("Skin\aero.she",$zcxtj & "\aero.she",1)
;==================================================================
Pifu();调用皮肤函数，使程序能运用皮肤
_WinAPI_SetDriverSigning(0);设置Microsoft Windows操作系统的驱动程序签名策略
pdDPIhj();调用判断DPI环境的函数
$Form1 = GUICreate("Smart_Driver_V1.0", 496, 380, 250, 169)
$TreeView1 = GUICtrlCreateTreeView(4, 4, 153, 289,BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES),$WS_EX_CLIENTEDGE)
$ListView1 = GUICtrlCreateListView("硬件|型号", 162, 4, 329, 161)
_GUICtrlListView_SetColumnWidth($ListView1,0,40);设置项目的宽度
_GUICtrlListView_SetColumnWidth($ListView1,1,280);设置项目的宽度
$ListView2 = GUICtrlCreateListView("序号|途径", 162, 168, 329, 125)
_GUICtrlListView_SetColumnWidth($ListView2,0,40);设置项目的宽度
_GUICtrlListView_SetColumnWidth($ListView2,1,260);设置项目的宽度
$Input1 = GUICtrlCreateInput("C:\Drivers", 140, 312, 170, 21)
$Input2 = GUICtrlCreateInput("D:\Drivers", 140, 344, 170, 21)
$Label1 = GUICtrlCreateLabel("选择驱动释放途径：", 24, 316, 116, 25)
$Label2 = GUICtrlCreateLabel("使用本机备份驱动：", 24, 348, 116, 25)
$Button1 = GUICtrlCreateButton("解压并安装", 320, 310, 89, 25)
$Button2 = GUICtrlCreateButton("搜索并安装", 320, 342, 89, 25)
$Group1 = GUICtrlCreateGroup("", 8, 296, 481, 78)
$Button3 = GUICtrlCreateButton("退出", 416, 310, 65, 57)
Duquini_ShezhiTreeView();调用读取ini文件并且输出到父项和子项中去的函数
GUISetState(@SW_SHOW)
yingjianjiance();调用硬件检测的函数
duquyingjianini_shuchuliebiao();调用读取AIDA64检测的INI，并输出到LISTBIEW中去的函数
xuanzeTreeView();调用选择TreeView的函数
shuchujieyatujing();调用输出解压途径的函数
AdlibRegister("begin_time",1000);注册倒计时函数，并另该函数多长时间运行一次
#EndRegion ### END Koda GUI section ###
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			$MsgBox1 = MsgBox(4+48+8192,"严重警告","貌似你要退出程序！")
			If $MsgBox1 = 6 Then
				Exit_()
			EndIf
			AdlibUnRegister("begin_time");反注册时间函数，结束函数运行
			GUICtrlSetData($Button1,"解压并安装")
		Case $fx[0][0] To $fx[UBound($zdm) - 1][0] , $zx[0][0] To $zx[UBound($gjz) - 1][0]
			AdlibUnRegister("begin_time");反注册时间函数，结束函数运行
			GUICtrlSetData($Button1,"解压并安装")
		 	For $b = 0 To UBound($zdm) - 1
				If $nMsg = $fx[$b][0] And BitAND(GUICtrlRead($fx[$b][0]), $GUI_CHECKED) Then ;如果父项选中，那么其子项全部选种
						$Number = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$fx[$b][0]))
					For $b1 = $fx[$b][0] To $fx[$b][0] + $Number
						 GUICtrlSetState($b1, $GUI_CHECKED)
					Next
					ElseIf $nMsg = $fx[$b][0] And BitAND(GUICtrlRead($fx[$b][0]), $GUI_UNCHECKED) Then;如果父项选空，那么其子项全部选空
						$Number = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$fx[$b][0]))
					For $b1 = $fx[$b][0] To $fx[$b][0] + $Number
						 GUICtrlSetState($b1, $GUI_UNCHECKED)
					Next
				EndIf
			Next			
			For $b2 = 0 To UBound($gjz) - 1
				If $nMsg = $zx[$b2][0] And BitAND(GUICtrlRead($zx[$b2][0]), $GUI_CHECKED) Then;如果子项中其中一个被选中，那么其父项也被选中
					$Handle = _GUICtrlTreeView_GetParentParam($TreeView1,$zx[$b2][0])
					GUICtrlSetState($Handle,$GUI_CHECKED)
				ElseIf $nMsg = $zx[$b2][0] And BitAND(GUICtrlRead($zx[$b2][0]), $GUI_UNCHECKED) Then;如果子项全部选空，那么其父项也被选空
					$Handle = _GUICtrlTreeView_GetParentParam($TreeView1,$zx[$b2][0])
					$Number1 = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$Handle))
					For $b3 = $Handle To $Handle + $Number1
						If GUICtrlRead($b3) = $GUI_CHECKED Then ExitLoop
						If $b3 = $Handle + $Number1 Then
							GUICtrlSetState($Handle, $GUI_UNCHECKED)
						EndIf
					Next
				EndIf
			Next
			shuchujieyatujing();调用输出解压途径的函数
		Case $Button1
			AdlibUnRegister("begin_time");反注册时间函数，结束函数运行
			GUICtrlSetData($Button1,"解压并安装")
			jieya();调用解压函数
			sousuoinftj();调用搜索inf文件的途径函数
			$MsgBox = MsgBox(8192+32+4,"驱动安装提示",@TAB & "驱动解压完毕！" & @CRLF & @CRLF & "要立刻开始安装驱动吗？(10秒后自动开始)"& @CRLF & @CRLF & "点击 是(Y) 的按钮进行驱动安装。" & @CRLF & @CRLF & "点击 否(N) 的按钮不进行驱动安装。",10)			
			If $MsgBox = 7 Then
				Exit_()
			Else
				anzhuang();调用安装驱动函数
				Exit_()
			EndIf
		Case $Button2
			AdlibUnRegister("begin_time");反注册时间函数，结束函数运行
			GUICtrlSetData($Button1,"解压并安装")
			sousuoinftj();调用搜索inf文件的途径函数
			anzhuang();调用安装驱动函数
			Exit_()
		Case $Button3
			$MsgBox1 = MsgBox(8192+4+48,"严重警告","貌似你要退出程序！")
			If $MsgBox1 = 6 Then
				Exit_()
			EndIf
			AdlibUnRegister("begin_time");反注册时间函数，结束函数运行
			GUICtrlSetData($Button1,"解压并安装")
	EndSwitch
WEnd
;==================================================================
;自定义的函数定义

Func Pifu();定义皮肤的函数
	$skins = $zcxtj & "\aero.she"
	$Dll = DllOpen($zcxtj & "\Skin.dll")
	DllCall($Dll, "int", "SkinH_AttachEx", "str", $skins, "str", "mhgd")
	DllCall($Dll, "int", "SkinH_SetAero", "int", 1)
EndFunc

Func Duquini_ShezhiTreeView();定义读取ini文件并且输出到父项和子项中去的函数
	$zdm1 = IniReadSectionNames($initj)
	For $a = 1 To $zdm1[0]
		$a1 += 1
		$fx[$a1][0] = GUICtrlCreateTreeViewItem($zdm1[$a],$TreeView1)
		$sz = IniReadSection($initj,$zdm1[$a])
		For $a2 = 1 To $sz[0][0]
			$a3 += 1
			$zx[$a3][0] = GUICtrlCreateTreeViewItem($sz[$a2][0],$fx[$a1][0])
			$zx[$a3][1] = $sz[$a2][1]
		Next
	Next
EndFunc

Func shuchujieyatujing();定义输出解压途径的函数
	$c = 1
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView2))
	For $c1 = 0 To UBound($gjz) - 1 
		If _GUICtrlTreeView_GetChecked($TreeView1, $zx[$c1][0]) Then
			$Number = _GUICtrlListView_GetItemCount($ListView2)
			_GUICtrlListView_AddItem($ListView2,StringFormat("[%03d]",$c))
		    _GUICtrlListView_AddSubItem($ListView2, $Number,$zx[$c1][1], 1)
			$c += 1
		EndIf
	Next
EndFunc

Func yingjianjiance();定义硬件检测的函数
	GUISetState(@SW_DISABLE,$Form1)
	$Form2 = GUICreate("进度条", 314, 50, 336, 320,$WS_POPUP,-1,$Form1)
	GUISetState(@SW_SHOW);创建子GUI必不可少的
	WinSetTrans($Form2, "", 220) ;设置透明读，这里没有调用API，目的是为了方便
	$Progress1 = GUICtrlCreateProgress(9, 27, 294, 11)
	$Label = GUICtrlCreateLabel("解压应用软件...",20,9,"",14)
	For $h = 1 To 50 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\Tools\Aida64.7z" & " -y -o" & $zcxtj & " -r","",@SW_HIDE)
	$Label2 = GUICtrlCreateLabel("扫描硬件型号...",20,9,"",14)
	For $h = 51 To 80 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	ShellExecuteWait($zcxtj & "\aida64\aida64.exe",' /r /custom aida64.rpf /ini report.ini /silent',$zcxtj & "\Aida64")
	For $h = 81 To 90 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	$Label3 = GUICtrlCreateLabel("扫描完毕，加载列表...",20,9,"",14)
	For $h = 91 To 100 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	GUISetState(@SW_ENABLE,$Form1)
	GUIDelete($Form2)
	
EndFunc

Func duquyingjianini_shuchuliebiao();定义读取AIDA64检测的INI，并输出到LISTBIEW中去的函数
	Global $yjinitj = $zcxtj & "\Aida64\Reports\Report.ini" ;定义用AIDA64读取的硬件INI途径
	$CPU = IniRead($yjinitj,"CPU","CPU Properties|CPU Type","")
	GUICtrlCreateListViewItem("CPU|" & $CPU,$ListView1)
	$beiqiao = IniRead($yjinitj,"Chipset","Chipset1|North Bridge Properties|North Bridge","")
	GUICtrlCreateListViewItem("主板|[北桥] " & $beiqiao,$ListView1)
	$nanqiao = IniRead($yjinitj,"Chipset","Chipset2|South Bridge Properties|South Bridge","")
	GUICtrlCreateListViewItem("|[南桥] " & $nanqiao,$ListView1)
	$Vidao = IniRead($yjinitj,"PCI / AGP Video","PCI / AGP Video1","")
	GUICtrlCreateListViewItem("显卡|" & $Vidao,$ListView1)
	$Audio = IniRead($yjinitj,"PCI / PnP Audio","PCI / PnP Audio1","")
	GUICtrlCreateListViewItem("声卡|" & $Audio,$ListView1)
	$Network = IniRead($yjinitj,"PCI / PnP Network","PCI / PnP Network1","")
	GUICtrlCreateListViewItem("网卡|" & $Network,$ListView1)	
EndFunc

Func xuanzeTreeView();定义选择TreeView的函数
	_GUICtrlTreeView_SetChecked($TreeView1,16)
	_GUICtrlTreeView_SetChecked($TreeView1,24)
	_GUICtrlTreeView_SetChecked($TreeView1,25)
	_GUICtrlTreeView_SetChecked($TreeView1,32)
	_GUICtrlTreeView_SetChecked($TreeView1,33)
	_GUICtrlTreeView_SetChecked($TreeView1,45)
	_GUICtrlTreeView_SetChecked($TreeView1,46)
	_GUICtrlTreeView_SetChecked($TreeView1,60)
	_GUICtrlTreeView_SetChecked($TreeView1,61)
	For $d = 61 To 75
		_GUICtrlTreeView_SetChecked($TreeView1,$d)
	Next
	_GUICtrlTreeView_SetChecked($TreeView1,85)
	_GUICtrlTreeView_SetChecked($TreeView1,86)
	_GUICtrlTreeView_SetChecked($TreeView1,88)
	_GUICtrlTreeView_SetChecked($TreeView1,89)
	
;~ 	判断CPU类型并选择
	If StringInStr($CPU,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,14)
		_GUICtrlTreeView_SetChecked($TreeView1,15)
	EndIf
;~ 	判断结束

;~ 判断主板芯片类型并选择
	If StringInStr($beiqiao&$nanqiao,"ALi") Or StringInStr($beiqiao&$nanqiao,"ULi") Then
		_GUICtrlTreeView_SetChecked($TreeView1,17)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"AMD") Or StringInStr($beiqiao&$nanqiao,"ATi") Then
		_GUICtrlTreeView_SetChecked($TreeView1,18)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,19)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,20)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,21)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,22)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"NoteBook") Then
		_GUICtrlTreeView_SetChecked($TreeView1,23)
	EndIf
;~ 	判断结束

;~ 判断显卡类型并选择
	If StringInStr($Vidao,"AMD") Or StringInStr($beiqiao&$nanqiao,"ATi") Then
		_GUICtrlTreeView_SetChecked($TreeView1,26)
	EndIf
	If StringInStr($Vidao,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,27)
	EndIf
	If StringInStr($Vidao,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,28)
	EndIf
	If StringInStr($Vidao,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,29)
	EndIf
	If StringInStr($Vidao,"VIA") Or StringInStr($beiqiao&$nanqiao,"S3") Then
		_GUICtrlTreeView_SetChecked($TreeView1,30)
	EndIf
	If StringInStr($Vidao,"VMware") Then
		_GUICtrlTreeView_SetChecked($TreeView1,31)
	EndIf
;~ 	判断结束
	
;~ 	判断声卡类型并选择
	If StringInStr($Audio,"AD") Or StringInStr($Audio,"Inte") Then
		_GUICtrlTreeView_SetChecked($TreeView1,34)
	EndIf
	If StringInStr($Audio,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,35)
	EndIf
	If StringInStr($Audio,"C-Media") Then
		_GUICtrlTreeView_SetChecked($TreeView1,36)
	EndIf
	If StringInStr($Audio,"Conexant") Then
		_GUICtrlTreeView_SetChecked($TreeView1,37)
	EndIf
	If StringInStr($Audio,"Creative") Then
		_GUICtrlTreeView_SetChecked($TreeView1,38)
	EndIf
	If StringInStr($Audio,"High Definition") Then
		_GUICtrlTreeView_SetChecked($TreeView1,39)
	EndIf
	If StringInStr($Audio,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,40)
	EndIf
	If StringInStr($Audio,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,41)
	EndIf
	If StringInStr($Audio,"Sigmatel") Or StringInStr($Audio,"IDT") Then
		_GUICtrlTreeView_SetChecked($TreeView1,42)
	EndIf
	If StringInStr($Audio,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,43)
	EndIf
	If StringInStr($Audio,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,44)
	EndIf
;~ 	判断结束
	
;~ 	判断网卡类型并选择
	If StringInStr($Network,"3Com") Then
		_GUICtrlTreeView_SetChecked($TreeView1,47)
	EndIf
	If StringInStr($Network,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,48)
	EndIf
	If StringInStr($Network,"Atheros") Then
		_GUICtrlTreeView_SetChecked($TreeView1,49)
	EndIf
	If StringInStr($Network,"Broadcom") Then
		_GUICtrlTreeView_SetChecked($TreeView1,50)
	EndIf
	If StringInStr($Network,"D-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,51)
	EndIf
	If StringInStr($Network,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,52)
	EndIf
	If StringInStr($Network,"Marvell") Then
		_GUICtrlTreeView_SetChecked($TreeView1,53)
	EndIf
	If StringInStr($Network,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,54)
	EndIf
	If StringInStr($Network,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,55)
	EndIf
	If StringInStr($Network,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,56)
	EndIf
	If StringInStr($Network,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,57)
	EndIf
	If StringInStr($Network,"TP-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,58)
	EndIf
	If StringInStr($Network,"ULI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,59)
	EndIf
	If StringInStr($Network,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,60)
	EndIf
;~ 	判断结束
	
;~ 	判断笔记本的类型并选择
	$_SYSTEM_POWER_STATUS=DllStructCreate('byte[4];dword[2]')
    DllCall('Kernel32.dll','bool','GetSystemPowerStatus','ptr',DllStructGetPtr($_SYSTEM_POWER_STATUS))
	$j = DllStructGetData($_SYSTEM_POWER_STATUS,1,2);具体判断是通过笔记本的电源类型判断，只能到80%，不一定全面
	If $j <> 128 Then
		For $j1 = 76 To 84
			_GUICtrlTreeView_SetChecked($TreeView1,$j1)
		Next
		_GUICtrlTreeView_SetChecked($TreeView1,87)
	EndIf
;~ 	判断结束
EndFunc

Func jieya();定义解压函数
	GUICtrlSetState($TreeView1,$GUI_DISABLE)
	GUICtrlSetState($Input1,$GUI_DISABLE)
	GUICtrlSetState($Input2,$GUI_DISABLE)
	GUICtrlSetState($Button1,$GUI_DISABLE)
	GUICtrlSetState($Button2,$GUI_DISABLE)
	GUICtrlSetState($Button3,$GUI_DISABLE)
	$e = GUICtrlRead($Input1);读取解压途径的输入框信息
	DirCreate($e)
	$e1 = _GUICtrlListView_GetItemCount($ListView2)
	For 	$e2 = 0 To $e1
		_GUICtrlListView_ClickItem($ListView2, $e2)
		$e3=_GUICtrlListView_GetItemTexT($ListView2,$e2,1)
		_GUICtrlListView_SetItemText($ListView2,$e2,"-->")
		_GUICtrlListView_ClickItem($ListView2, $e2)
		RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & " -r","",@SW_HIDE)
		_GUICtrlListView_SetItemText($ListView2,$e2,"√")
	Next 
EndFunc

Func sousuoinftj();定义搜索inf文件的途径函数
	GUICtrlSetState($TreeView1,$GUI_DISABLE)
	GUICtrlSetState($Input1,$GUI_DISABLE)
	GUICtrlSetState($Input2,$GUI_DISABLE)
	GUICtrlSetState($Button1,$GUI_DISABLE)
	GUICtrlSetState($Button2,$GUI_DISABLE)
	GUICtrlSetState($Button3,$GUI_DISABLE)
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView2))
	_GUICtrlListView_BeginUpdate($ListView2)
		If $nMsg = 10 Then 
			$f1 = GUICtrlRead($Input1)
		ElseIf $nMsg = 11 Then
			$f1 = GUICtrlRead($Input2)
		EndIf
	_filelist($f1)
	$pathArray=StringRegExp($str,'.+(?=\\)',3)
	$Path = _ArrayUnique($pathArray)
	$f3 = 0
	For $f2 = 1 To $path[0]
		_GUICtrlListView_AddItem($ListView2,StringFormat("[%03d]",$f2))
		_GUICtrlListView_AddSubItem($ListView2, $f3,$path[$f2], 1)
		$f3 +=1
	Next
	_GUICtrlListView_EndUpdate($ListView2)
EndFunc													

Func _filelist($searchdir);定义查找INF途径的函数
        $search = FileFindFirstFile($searchdir & "\*.*") ;;;;查指定目录下的文件
        If $search = -1 Then Return -1 ;;;;如果找不到,返回值 -1
        While 1
                $file = FileFindNextFile($search) ;;;查找下一个文件
                If @error Then ;;;如果找不到文件
                        FileClose($search) ;;;则关闭此句柄
                        Return ;;;返回
                ElseIf $file = "." Or $file = ".." Then ;;如果找到的文件名为.或..则ContinueLoop
                        ContinueLoop ;;;在某些版本的AU3里面可以不需要上行和这行。
                ElseIf StringInStr(FileGetAttrib($searchdir & "\" & $file), "D") Then;;如果找到的是一个文件夹,则
                    _filelist($searchdir & "\" & $file) ;;递归调用filelist函数,并传参数  "$searchdir & "\" & $file"
                EndIf ;;;$file为查找到的文件夹名称,上一行意思就是进入此文件夹继续查找文件.如此循环
                If StringInStr($file, '.inf') Then $str &= $searchdir & "\" & $file & @CRLF;_ArrayAdd($filelist,$searchdir & "\" & $file );MsgBox( 0,0,$searchdir & "\" & $file & @crlf )
        WEnd
EndFunc   ;==>_filelist

Func anzhuang();定义安装驱动函数
	$g = _GUICtrlListView_GetItemCount($ListView2)
	For 	$g1 = 0 To $g - 1
		_GUICtrlListView_ClickItem($ListView2, $g1)
		$g2=_GUICtrlListView_GetItemTexT($ListView2,$g1,1)
		_GUICtrlListView_SetItemText($ListView2,$g1,"-->")
		_GUICtrlListView_ClickItem($ListView2, $g1)
		RunWait($zcxtj & "\DPInst.exe" & $DPInstcs & $g2 & " /F /SE /SW","",@SW_HIDE)
	    _GUICtrlListView_SetItemText($ListView2,$g1,"√")
	Next 	
EndFunc

Func pdDPIhj();定义判断DPI环境的函数,使其能在桌面或者是非桌面都能适用。
	If ProcessExists("explorer.exe") Then
		$DPInstcs = " /LM /SH /SA /PATH "
	Else
		$DPInstcs = " /LM /SA /PATH "
	EndIf
EndFunc

Func begin_time();定义倒计时函数
	$time -=1
	GUICtrlSetData($Button1,"解压并安装(" & $time & ")")
	If $time <= 0 Then AdlibUnRegister()
	If $time <= 0 Then ControlClick("D_I_T","",$Button1,"left",1)
EndFunc

Func Exit_();定义程序退出时要执行的灭绝操作
	GUISetState(@SW_HIDE)
	DllClose($Dll)
	DirRemove($zcxtj,1)
	Exit
EndFunc



	
	
	
	
	
	