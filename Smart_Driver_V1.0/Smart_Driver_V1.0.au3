#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=..\2609\����Ӳ������ͼ������0.ico
#AutoIt3Wrapper_outfile=Smart_Driver_V1.0.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Smart_Driver
#AutoIt3Wrapper_Res_Description=Smart_Driver
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Smart_Driver_V1.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#cs================================================================
�Զ��������������
$zcxtj ;���������е��ļ����õ�;��
$initj ;ini�ļ����ڵ�;��
$zdm ;�ȴ�ini�ļ���ȡȫ���ַ���֮������������ʽƥ��[]�����صõ�һ�����顣
$gjz ;�ȴ�ini�ļ���ȡȫ���ַ���֮������������ʽƥ��=�����صõ�һ�����顣
$fx[?][2] ;��$zdm�����ж�ȡ��������ִ�С�����������2ά����Ĵ�С��ʹ������鶨�岻���˷�,����״ͼ���������ȡ����ini�ļ����ֶ��֡�
$zx[?][2] ;��$zdm�����ж�ȡ��������ִ�С�����������2ά����Ĵ�С��ʹ������鶨�岻���˷ѣ�����״ͼ���������ȡ����ini�ļ��Ĺؼ��֡�
$a1 , $a3 ;����ѭ���õĳ�����ûʲô���塣
#ce================================================================
;==================================================================
;���������õ��ı������ڴ˽��ж���
Opt("TrayMenuMode",1)
Dim $a1 = -1 , $a3 = -1
Global $zcxtj = "C:\WINDOWS\temp\Smart_Driver.Temp"
Global $initj = @ScriptDir & "\Ini\Drivers.ini"
Global $zdm = StringRegExp(FileRead($initj),"\[.+\]",3) ,$gjz = StringRegExp(FileRead($initj),"=",3)
Global $fx[UBound($zdm)][2] , $zx[UBound($gjz)][2]
Global $CPU = "" , $beiqiao = "" , $nanqiao = "" , $Audio = "" , $Vidao = "" , $Network = "" ,$str , $DPInstcs , $Dll;====>Ӧ������ĺ����ⲿ������ɵı���û���壬����ûʲô����
Dim $time = 10 ;Ӧ������begin_time()�����ĵ���ʱ��ûʲô̫������
;==================================================================
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
;==================================================================
;���庯����������ӵ�ͷ�ļ�
#Include <GuiListView.au3>;��ͷ�ļ�Ϊ����_GUICtrlListView_SetColumnWidth�����������
#Include <GuiTreeView.au3>;��ͷ�ļ�Ϊ����_GUICtrlTreeView_GetChildCount�����������
#include <ProgressConstants.au3>;��ͷ�ļ�Ϊ���ý������������
#Include <WinAPIEx.au3>;��ͷ�ļ�Ϊ����_WinAPI_SetDriverSigning()�������
;==================================================================
#Region ### START Koda GUI section ### 
DirCreate($zcxtj)
;==================================================================
;�����������
FileInstall("Tools1\7za.exe",$zcxtj & "\7za.exe",1)
FileInstall("Tools1\DPInst.exe",$zcxtj & "\DPInst.exe",1)
FileInstall("Skin\Skin.dll",$zcxtj & "\Skin.dll",1)
FileInstall("Skin\aero.she",$zcxtj & "\aero.she",1)
;==================================================================
Pifu();����Ƥ��������ʹ����������Ƥ��
_WinAPI_SetDriverSigning(0);����Microsoft Windows����ϵͳ����������ǩ������
pdDPIhj();�����ж�DPI�����ĺ���
$Form1 = GUICreate("Smart_Driver_V1.0", 496, 380, 250, 169)
$TreeView1 = GUICtrlCreateTreeView(4, 4, 153, 289,BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES),$WS_EX_CLIENTEDGE)
$ListView1 = GUICtrlCreateListView("Ӳ��|�ͺ�", 162, 4, 329, 161)
_GUICtrlListView_SetColumnWidth($ListView1,0,40);������Ŀ�Ŀ��
_GUICtrlListView_SetColumnWidth($ListView1,1,280);������Ŀ�Ŀ��
$ListView2 = GUICtrlCreateListView("���|;��", 162, 168, 329, 125)
_GUICtrlListView_SetColumnWidth($ListView2,0,40);������Ŀ�Ŀ��
_GUICtrlListView_SetColumnWidth($ListView2,1,260);������Ŀ�Ŀ��
$Input1 = GUICtrlCreateInput("C:\Drivers", 140, 312, 170, 21)
$Input2 = GUICtrlCreateInput("D:\Drivers", 140, 344, 170, 21)
$Label1 = GUICtrlCreateLabel("ѡ�������ͷ�;����", 24, 316, 116, 25)
$Label2 = GUICtrlCreateLabel("ʹ�ñ�������������", 24, 348, 116, 25)
$Button1 = GUICtrlCreateButton("��ѹ����װ", 320, 310, 89, 25)
$Button2 = GUICtrlCreateButton("��������װ", 320, 342, 89, 25)
$Group1 = GUICtrlCreateGroup("", 8, 296, 481, 78)
$Button3 = GUICtrlCreateButton("�˳�", 416, 310, 65, 57)
Duquini_ShezhiTreeView();���ö�ȡini�ļ���������������������ȥ�ĺ���
GUISetState(@SW_SHOW)
yingjianjiance();����Ӳ�����ĺ���
duquyingjianini_shuchuliebiao();���ö�ȡAIDA64����INI���������LISTBIEW��ȥ�ĺ���
xuanzeTreeView();����ѡ��TreeView�ĺ���
shuchujieyatujing();���������ѹ;���ĺ���
AdlibRegister("begin_time",1000);ע�ᵹ��ʱ����������ú����೤ʱ������һ��
#EndRegion ### END Koda GUI section ###
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			$MsgBox1 = MsgBox(4+48+8192,"���ؾ���","ò����Ҫ�˳�����")
			If $MsgBox1 = 6 Then
				Exit_()
			EndIf
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
		Case $fx[0][0] To $fx[UBound($zdm) - 1][0] , $zx[0][0] To $zx[UBound($gjz) - 1][0]
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
		 	For $b = 0 To UBound($zdm) - 1
				If $nMsg = $fx[$b][0] And BitAND(GUICtrlRead($fx[$b][0]), $GUI_CHECKED) Then ;�������ѡ�У���ô������ȫ��ѡ��
						$Number = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$fx[$b][0]))
					For $b1 = $fx[$b][0] To $fx[$b][0] + $Number
						 GUICtrlSetState($b1, $GUI_CHECKED)
					Next
					ElseIf $nMsg = $fx[$b][0] And BitAND(GUICtrlRead($fx[$b][0]), $GUI_UNCHECKED) Then;�������ѡ�գ���ô������ȫ��ѡ��
						$Number = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$fx[$b][0]))
					For $b1 = $fx[$b][0] To $fx[$b][0] + $Number
						 GUICtrlSetState($b1, $GUI_UNCHECKED)
					Next
				EndIf
			Next			
			For $b2 = 0 To UBound($gjz) - 1
				If $nMsg = $zx[$b2][0] And BitAND(GUICtrlRead($zx[$b2][0]), $GUI_CHECKED) Then;�������������һ����ѡ�У���ô�丸��Ҳ��ѡ��
					$Handle = _GUICtrlTreeView_GetParentParam($TreeView1,$zx[$b2][0])
					GUICtrlSetState($Handle,$GUI_CHECKED)
				ElseIf $nMsg = $zx[$b2][0] And BitAND(GUICtrlRead($zx[$b2][0]), $GUI_UNCHECKED) Then;�������ȫ��ѡ�գ���ô�丸��Ҳ��ѡ��
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
			shuchujieyatujing();���������ѹ;���ĺ���
		Case $Button1
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
			jieya();���ý�ѹ����
			sousuoinftj();��������inf�ļ���;������
			$MsgBox = MsgBox(8192+32+4,"������װ��ʾ",@TAB & "������ѹ��ϣ�" & @CRLF & @CRLF & "Ҫ���̿�ʼ��װ������(10����Զ���ʼ)"& @CRLF & @CRLF & "��� ��(Y) �İ�ť����������װ��" & @CRLF & @CRLF & "��� ��(N) �İ�ť������������װ��",10)			
			If $MsgBox = 7 Then
				Exit_()
			Else
				anzhuang();���ð�װ��������
				Exit_()
			EndIf
		Case $Button2
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
			sousuoinftj();��������inf�ļ���;������
			anzhuang();���ð�װ��������
			Exit_()
		Case $Button3
			$MsgBox1 = MsgBox(8192+4+48,"���ؾ���","ò����Ҫ�˳�����")
			If $MsgBox1 = 6 Then
				Exit_()
			EndIf
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
	EndSwitch
WEnd
;==================================================================
;�Զ���ĺ�������

Func Pifu();����Ƥ���ĺ���
	$skins = $zcxtj & "\aero.she"
	$Dll = DllOpen($zcxtj & "\Skin.dll")
	DllCall($Dll, "int", "SkinH_AttachEx", "str", $skins, "str", "mhgd")
	DllCall($Dll, "int", "SkinH_SetAero", "int", 1)
EndFunc

Func Duquini_ShezhiTreeView();�����ȡini�ļ���������������������ȥ�ĺ���
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

Func shuchujieyatujing();���������ѹ;���ĺ���
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

Func yingjianjiance();����Ӳ�����ĺ���
	GUISetState(@SW_DISABLE,$Form1)
	$Form2 = GUICreate("������", 314, 50, 336, 320,$WS_POPUP,-1,$Form1)
	GUISetState(@SW_SHOW);������GUI�ز����ٵ�
	WinSetTrans($Form2, "", 220) ;����͸����������û�е���API��Ŀ����Ϊ�˷���
	$Progress1 = GUICtrlCreateProgress(9, 27, 294, 11)
	$Label = GUICtrlCreateLabel("��ѹӦ�����...",20,9,"",14)
	For $h = 1 To 50 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\Tools\Aida64.7z" & " -y -o" & $zcxtj & " -r","",@SW_HIDE)
	$Label2 = GUICtrlCreateLabel("ɨ��Ӳ���ͺ�...",20,9,"",14)
	For $h = 51 To 80 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	ShellExecuteWait($zcxtj & "\aida64\aida64.exe",' /r /custom aida64.rpf /ini report.ini /silent',$zcxtj & "\Aida64")
	For $h = 81 To 90 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	$Label3 = GUICtrlCreateLabel("ɨ����ϣ������б�...",20,9,"",14)
	For $h = 91 To 100 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	GUISetState(@SW_ENABLE,$Form1)
	GUIDelete($Form2)
	
EndFunc

Func duquyingjianini_shuchuliebiao();�����ȡAIDA64����INI���������LISTBIEW��ȥ�ĺ���
	Global $yjinitj = $zcxtj & "\Aida64\Reports\Report.ini" ;������AIDA64��ȡ��Ӳ��INI;��
	$CPU = IniRead($yjinitj,"CPU","CPU Properties|CPU Type","")
	GUICtrlCreateListViewItem("CPU|" & $CPU,$ListView1)
	$beiqiao = IniRead($yjinitj,"Chipset","Chipset1|North Bridge Properties|North Bridge","")
	GUICtrlCreateListViewItem("����|[����] " & $beiqiao,$ListView1)
	$nanqiao = IniRead($yjinitj,"Chipset","Chipset2|South Bridge Properties|South Bridge","")
	GUICtrlCreateListViewItem("|[����] " & $nanqiao,$ListView1)
	$Vidao = IniRead($yjinitj,"PCI / AGP Video","PCI / AGP Video1","")
	GUICtrlCreateListViewItem("�Կ�|" & $Vidao,$ListView1)
	$Audio = IniRead($yjinitj,"PCI / PnP Audio","PCI / PnP Audio1","")
	GUICtrlCreateListViewItem("����|" & $Audio,$ListView1)
	$Network = IniRead($yjinitj,"PCI / PnP Network","PCI / PnP Network1","")
	GUICtrlCreateListViewItem("����|" & $Network,$ListView1)	
EndFunc

Func xuanzeTreeView();����ѡ��TreeView�ĺ���
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
	
;~ 	�ж�CPU���Ͳ�ѡ��
	If StringInStr($CPU,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,14)
		_GUICtrlTreeView_SetChecked($TreeView1,15)
	EndIf
;~ 	�жϽ���

;~ �ж�����оƬ���Ͳ�ѡ��
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
;~ 	�жϽ���

;~ �ж��Կ����Ͳ�ѡ��
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
;~ 	�жϽ���
	
;~ 	�ж��������Ͳ�ѡ��
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
;~ 	�жϽ���
	
;~ 	�ж��������Ͳ�ѡ��
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
;~ 	�жϽ���
	
;~ 	�жϱʼǱ������Ͳ�ѡ��
	$_SYSTEM_POWER_STATUS=DllStructCreate('byte[4];dword[2]')
    DllCall('Kernel32.dll','bool','GetSystemPowerStatus','ptr',DllStructGetPtr($_SYSTEM_POWER_STATUS))
	$j = DllStructGetData($_SYSTEM_POWER_STATUS,1,2);�����ж���ͨ���ʼǱ��ĵ�Դ�����жϣ�ֻ�ܵ�80%����һ��ȫ��
	If $j <> 128 Then
		For $j1 = 76 To 84
			_GUICtrlTreeView_SetChecked($TreeView1,$j1)
		Next
		_GUICtrlTreeView_SetChecked($TreeView1,87)
	EndIf
;~ 	�жϽ���
EndFunc

Func jieya();�����ѹ����
	GUICtrlSetState($TreeView1,$GUI_DISABLE)
	GUICtrlSetState($Input1,$GUI_DISABLE)
	GUICtrlSetState($Input2,$GUI_DISABLE)
	GUICtrlSetState($Button1,$GUI_DISABLE)
	GUICtrlSetState($Button2,$GUI_DISABLE)
	GUICtrlSetState($Button3,$GUI_DISABLE)
	$e = GUICtrlRead($Input1);��ȡ��ѹ;�����������Ϣ
	DirCreate($e)
	$e1 = _GUICtrlListView_GetItemCount($ListView2)
	For 	$e2 = 0 To $e1
		_GUICtrlListView_ClickItem($ListView2, $e2)
		$e3=_GUICtrlListView_GetItemTexT($ListView2,$e2,1)
		_GUICtrlListView_SetItemText($ListView2,$e2,"-->")
		_GUICtrlListView_ClickItem($ListView2, $e2)
		RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & " -r","",@SW_HIDE)
		_GUICtrlListView_SetItemText($ListView2,$e2,"��")
	Next 
EndFunc

Func sousuoinftj();��������inf�ļ���;������
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

Func _filelist($searchdir);�������INF;���ĺ���
        $search = FileFindFirstFile($searchdir & "\*.*") ;;;;��ָ��Ŀ¼�µ��ļ�
        If $search = -1 Then Return -1 ;;;;����Ҳ���,����ֵ -1
        While 1
                $file = FileFindNextFile($search) ;;;������һ���ļ�
                If @error Then ;;;����Ҳ����ļ�
                        FileClose($search) ;;;��رմ˾��
                        Return ;;;����
                ElseIf $file = "." Or $file = ".." Then ;;����ҵ����ļ���Ϊ.��..��ContinueLoop
                        ContinueLoop ;;;��ĳЩ�汾��AU3������Բ���Ҫ���к����С�
                ElseIf StringInStr(FileGetAttrib($searchdir & "\" & $file), "D") Then;;����ҵ�����һ���ļ���,��
                    _filelist($searchdir & "\" & $file) ;;�ݹ����filelist����,��������  "$searchdir & "\" & $file"
                EndIf ;;;$fileΪ���ҵ����ļ�������,��һ����˼���ǽ�����ļ��м��������ļ�.���ѭ��
                If StringInStr($file, '.inf') Then $str &= $searchdir & "\" & $file & @CRLF;_ArrayAdd($filelist,$searchdir & "\" & $file );MsgBox( 0,0,$searchdir & "\" & $file & @crlf )
        WEnd
EndFunc   ;==>_filelist

Func anzhuang();���尲װ��������
	$g = _GUICtrlListView_GetItemCount($ListView2)
	For 	$g1 = 0 To $g - 1
		_GUICtrlListView_ClickItem($ListView2, $g1)
		$g2=_GUICtrlListView_GetItemTexT($ListView2,$g1,1)
		_GUICtrlListView_SetItemText($ListView2,$g1,"-->")
		_GUICtrlListView_ClickItem($ListView2, $g1)
		RunWait($zcxtj & "\DPInst.exe" & $DPInstcs & $g2 & " /F /SE /SW","",@SW_HIDE)
	    _GUICtrlListView_SetItemText($ListView2,$g1,"��")
	Next 	
EndFunc

Func pdDPIhj();�����ж�DPI�����ĺ���,ʹ��������������Ƿ����涼�����á�
	If ProcessExists("explorer.exe") Then
		$DPInstcs = " /LM /SH /SA /PATH "
	Else
		$DPInstcs = " /LM /SA /PATH "
	EndIf
EndFunc

Func begin_time();���嵹��ʱ����
	$time -=1
	GUICtrlSetData($Button1,"��ѹ����װ(" & $time & ")")
	If $time <= 0 Then AdlibUnRegister()
	If $time <= 0 Then ControlClick("D_I_T","",$Button1,"left",1)
EndFunc

Func Exit_();��������˳�ʱҪִ�е��������
	GUISetState(@SW_HIDE)
	DllClose($Dll)
	DirRemove($zcxtj,1)
	Exit
EndFunc



	
	
	
	
	
	