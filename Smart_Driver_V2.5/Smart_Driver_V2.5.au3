#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=Help.ico
#AutoIt3Wrapper_outfile=Smart_Driver_V2.5.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Smart_Driver
#AutoIt3Wrapper_Res_Description=Smart_Driver
#AutoIt3Wrapper_Res_Fileversion=2.5.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Smart_Driver_V2.5
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
_nlite();���÷�װʱ�Ĳ�������Ҫ������nlite��װʱ��,�����ж��Ƿ����������
Opt("TrayMenuMode",1)
Dim $a1 = -1 , $a3 = -1 
Global $zcxtj = "C:\WINDOWS\temp\Smart_Driver.Temp"
Global $initj = @ScriptDir & "\Drivers\Ini\Drivers.ini"
Global $zdm = StringRegExp(FileRead($initj),"\[.+\]",3) ,$gjz = StringRegExp(FileRead($initj),"=",3)
Global $fx[UBound($zdm)][2] , $zx[UBound($gjz)][2]
Global $CPU = "" , $beiqiao = "" , $nanqiao = "" , $Audio = "" , $Audio2 ="" , $Vidao = "" , $Vidao2 = "" , $Vidao3 = "" , $Network = "" , $Network2 = "" , $Network3 = "" , $str , $DPInstcs , $Dll , $nlite;====>Ӧ������ĺ����ⲿ������ɵı���û���壬����ûʲô����
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
#Include <GuiListView.au3>		;��ͷ�ļ�Ϊ����_GUICtrlListView_SetColumnWidth�����������
#Include <GuiTreeView.au3>		;��ͷ�ļ�Ϊ����_GUICtrlTreeView_GetChildCount�����������
#include <ProgressConstants.au3>;��ͷ�ļ�Ϊ���ý������������
#Include "WinAPIEx.au3"			;��ͷ�ļ�Ϊ����_WinAPI_SetDriverSigning()�������
;==================================================================
#Region ### START Koda GUI section ### 
DirCreate($zcxtj);����������ķ���Ŀ¼
;==================================================================
;�����������
FileInstall("Tools1\7za.exe",$zcxtj & "\7za.exe",1)
FileInstall("Tools1\DPInst.exe",$zcxtj & "\DPInst.exe",1)
FileInstall("Tools1\devcon32.exe",$zcxtj & "\devcon32.exe",1)
FileInstall("Tools1\devcon64.exe",$zcxtj & "\devcon64.exe",1)
;==================================================================
_WinAPI_SetDriverSigning(0);����Microsoft Windows����ϵͳ����������ǩ������
_devcon();�������������ĺ�������Ҫ������DEVCON
$Form1 = GUICreate("Smart_Driver_V2.5", 496, 380, -1, -1)
$TreeView1 = GUICtrlCreateTreeView(5, 170, 153, 125,BitOR($TVS_EDITLABELS, _
											$TVS_HASBUTTONS, $TVS_HASLINES, _ 
											$TVS_LINESATROOT, $TVS_NONEVENHEIGHT, _ 
											$TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, _ 
											$TVS_CHECKBOXES),$WS_EX_CLIENTEDGE)
$TreeView2 = GUICtrlCreateTreeView(5, 5, 486, 160,BitOR($TVS_EDITLABELS, _
											$TVS_HASBUTTONS, $TVS_HASLINES, _ 
											$TVS_LINESATROOT, $TVS_NONEVENHEIGHT, _ 
											$TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS),$WS_EX_CLIENTEDGE)											
$TreeView2_CPU = GUICtrlCreateTreeViewItem("������",$TreeView2)
GUICtrlSetImage($TreeView2_CPU,"Setupapi.dll",28);ͼ��
_GUICtrlTreeView_Expand($TreeView2_CPU,"",True)
$TreeView2_Audio = GUICtrlCreateTreeViewItem("��������Ƶ����Ϸ������",$TreeView2)
GUICtrlSetImage($TreeView2_Audio,"MMSYS.CPL",1);ͼ��
$TreeView2_Network = GUICtrlCreateTreeViewItem("����������",$TreeView2)
GUICtrlSetImage($TreeView2_Network,"Setupapi.dll",5);ͼ��
$TreeView2_Shebei = GUICtrlCreateTreeViewItem("ϵͳ�豸",$TreeView2)
GUICtrlSetImage($TreeView2_Shebei,"Setupapi.dll",27);ͼ��
$TreeView2_Vidao = GUICtrlCreateTreeViewItem("��ʾ��",$TreeView2)
GUICtrlSetImage($TreeView2_Vidao,"Setupapi.dll",1);ͼ��
$ListView2 = GUICtrlCreateListView("���|;��", 162, 170, 329, 125)
_GUICtrlListView_SetColumnWidth($ListView2,0,40);������Ŀ�Ŀ��
_GUICtrlListView_SetColumnWidth($ListView2,1,260);������Ŀ�Ŀ��
$Input1 = GUICtrlCreateInput("C:\Drivers", 140, 312, 140, 21)
$Input2 = GUICtrlCreateInput("D:\Drivers", 140, 344, 140, 21)
$Label1 = GUICtrlCreateLabel("ѡ�������ͷ�;����", 24, 316, 116, 25)
$Label2 = GUICtrlCreateLabel("ʹ�ñ�������������", 24, 348, 116, 25)
$Button1 = GUICtrlCreateButton("��ѹ����װ", 320, 310, 89, 25)
$Button2 = GUICtrlCreateButton("��������װ", 320, 342, 89, 25)
$Button4 = GUICtrlCreateButton("....", 285, 310, 32, 25)
$Button5 = GUICtrlCreateButton("....", 285, 342, 32, 25)
$Group1 = GUICtrlCreateGroup("", 8, 296, 481, 78)
$Button3 = GUICtrlCreateButton("�˳�", 416, 310, 65, 57)
Duquini_ShezhiTreeView();���ö�ȡini�ļ���������������������ȥ�ĺ���
GUISetState(@SW_SHOW)
yingjianjiance();����Ӳ�����ĺ���
duquyingjianini_shuchuliebiao();���ö�ȡAIDA64����INI���������TreeView2��ȥ�ĺ���
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
			If ProcessExists("explorer.exe") Then ;�ж������氲װʱ�ͻ�����ʾ��װ������������Ͳ�����ʾ
				$MsgBox = MsgBox(8192+32+4,"������װ��ʾ",@TAB & "������ѹ��ϣ�" & @CRLF & @CRLF & "Ҫ���̿�ʼ��װ������(10����Զ���ʼ)"& @CRLF & @CRLF & "��� ��(Y) �İ�ť����������װ��" & @CRLF & @CRLF & "��� ��(N) �İ�ť������������װ��",10)			
				If $MsgBox = 7 Then
					Exit_()
				Else
					If $nlite = "-nlite" Then ;�ж��Ƿ��ڰ�װ���е�ʱ�������-nlite����
						anzhuang();���ð�װ�������������������nlite����
					Else					
						If ProcessExists("explorer.exe") Then
							anzhuang();���ð�װ�������������������nlite����
						Else
							anzhuang1();���ð�װ�������������ڷ�װ
						EndIf
					EndIf
					Exit_()
				EndIf
			Else;�����氲װ
				If $nlite = "-nlite" Then ;�ж��Ƿ��ڰ�װ���е�ʱ�������-nlite����
						anzhuang();���ð�װ�������������������nlite����
				Else					
						anzhuang1();���ð�װ�������������ڷ�װ
				EndIf
				Exit_()
			EndIf
		Case $Button2
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")
			sousuoinftj();��������inf�ļ���;������
			If $nlite = "-nlite" Then ;�ж��Ƿ��ڰ�װ���е�ʱ�������-nlite����
				anzhuang();���ð�װ�������������������nlite����
			Else
				If ProcessExists("explorer.exe") Then
					anzhuang();���ð�װ�������������������nlite����
				Else
					anzhuang1();���ð�װ�������������ڷ�װ
				EndIf
			EndIf			
			Exit_()			
		Case $Button3
			$MsgBox1 = MsgBox(8192+4+48,"���ؾ���","ò����Ҫ�˳�����")
			If $MsgBox1 = 6 Then
				Exit_()
			EndIf
			AdlibUnRegister("begin_time");��ע��ʱ�亯����������������
			GUICtrlSetData($Button1,"��ѹ����װ")			
		Case $Button4 
			$Dir = FileSelectFolder("ѡ��һ���ļ���.", "",1+2)
			If @error <> 1 Then
				GUICtrlSetData($Input1, $Dir)
			EndIf			
		Case $Button5 
			$Dir = FileSelectFolder("ѡ��һ���ļ���.", "",1+2)
			If @error <> 1 Then
				GUICtrlSetData($Input2, $Dir)
			EndIf
		EndSwitch
WEnd
;==================================================================
;�Զ���ĺ�������

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
	GUISetState(@SW_DISABLE,$Form1);��������״̬
	$Form2 = GUICreate("������", 314, 50, -1, -1,$WS_POPUP,-1,$Form1)
	GUISetState(@SW_SHOW);������GUI�ز����ٵ�
	WinSetTrans($Form2, "", 200) ;����͸����������û�е���API��Ŀ����Ϊ�˷���
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

Func duquyingjianini_shuchuliebiao();�����ȡAIDA64����INI���������TreeView2��ȥ�ĺ���
	Global $yjinitj = $zcxtj & "\Aida64\Reports\Report.ini" ;������AIDA64��ȡ��Ӳ��INI;��	
	$CPU = IniRead($yjinitj,"CPU","CPU Properties|CPU Type","");��ȡCPU		
	GUICtrlCreateTreeViewItem($CPU,$TreeView2_CPU)
	GUICtrlSetImage(-1,"Setupapi.dll",28);ͼ��
	$beiqiao = IniRead($yjinitj,"Chipset","Chipset1|North Bridge Properties|North Bridge","");��ȡ����		
	GUICtrlCreateTreeViewItem("[����]" & $beiqiao,$TreeView2_Shebei)
	GUICtrlSetImage(-1,"Setupapi.dll",27);ͼ��
	$nanqiao = IniRead($yjinitj,"Chipset","Chipset2|South Bridge Properties|South Bridge","NotFound");��ȡ����
	If $nanqiao = "NotFound" Then
		$nanqiao = IniRead($yjinitj,"Chipset","Chipset3|South Bridge Properties|South Bridge","NotFound");��һЩ��ȡ���ڵ�����
		GUICtrlCreateTreeViewItem("[����]" & $nanqiao,$TreeView2_Shebei)
		GUICtrlSetImage(-1,"Setupapi.dll",27);ͼ��
	Else
		GUICtrlCreateTreeViewItem("[����]" & $nanqiao,$TreeView2_Shebei)
		GUICtrlSetImage(-1,"Setupapi.dll",27);ͼ��
	EndIf
	$Vidao = IniRead($yjinitj,"PCI / AGP Video","PCI / AGP Video1","");��ȡ�Կ�
	GUICtrlCreateTreeViewItem($Vidao,$TreeView2_Vidao)
	GUICtrlSetImage(-1,"Setupapi.dll",1);ͼ��
	$Vidao2 = IniRead($yjinitj,"PCI / AGP Video","PCI / AGP Video2","NotFound");��ȡ�ڶ����Կ������û�оͲ�����
	If $Vidao2 <> "NotFound" And $Vidao2 <> $Vidao Then
	GUICtrlCreateTreeViewItem($Vidao2,$TreeView2_Vidao)
	GUICtrlSetImage(-1,"Setupapi.dll",1);ͼ��
	EndIf
	$Vidao3 = IniRead($yjinitj,"PCI / AGP Video","PCI / AGP Video3","NotFound");��ȡ�������Կ������û�оͲ�����
	If $Vidao3 <> "NotFound" And $Vidao3 <> $Vidao And $Vidao3 <> $Vidao2 Then
	GUICtrlCreateTreeViewItem($Vidao3,$TreeView2_Vidao)
	GUICtrlSetImage(-1,"Setupapi.dll",1);ͼ��
	EndIf
	$Audio = IniRead($yjinitj,"PCI / PnP Audio","PCI / PnP Audio1","");��ȡ����
	GUICtrlCreateTreeViewItem($Audio,$TreeView2_Audio)
	GUICtrlSetImage(-1,"MMSYS.CPL",1);ͼ��
	$Audio2 = IniRead($yjinitj,"PCI / PnP Audio","PCI / PnP Audio2","NotFound");��ȡ����
	If $Audio2 <> "NotFound" Then
	GUICtrlCreateTreeViewItem($Audio2,$TreeView2_Audio)
	GUICtrlSetImage(-1,"MMSYS.CPL",1);ͼ��
	EndIf
	$Network = IniRead($yjinitj,"PCI / PnP Network","PCI / PnP Network1","");��ȡ����
	GUICtrlCreateTreeViewItem($Network,$TreeView2_Network)
	GUICtrlSetImage(-1,"Setupapi.dll",5);ͼ��
	$Network2 = IniRead($yjinitj,"PCI / PnP Network","PCI / PnP Network2","NotFound");��ȡ�ڶ������������û�оͲ�����
	If $Network2 <> "NotFound" Then
		GUICtrlCreateTreeViewItem($Network2,$TreeView2_Network)
		GUICtrlSetImage(-1,"Setupapi.dll",5);ͼ��
	EndIf
	$Network3 = IniRead($yjinitj,"PCI / PnP Network","PCI / PnP Network3","NotFound");��ȡ���������������û�оͲ�����
	If $Network3 <> "NotFound" Then
		GUICtrlCreateTreeViewItem($Network3,$TreeView2_Network)
		GUICtrlSetImage(-1,"Setupapi.dll",5);ͼ��
	EndIf
	GUICtrlSetState($TreeView2_Vidao,$GUI_EXPAND)	;
	GUICtrlSetState($TreeView2_Shebei,$GUI_EXPAND)	;
	GUICtrlSetState($TreeView2_Network,$GUI_EXPAND)	;==����Tree��չ��״̬��չ����˳��ܹؼ�
	GUICtrlSetState($TreeView2_Audio,$GUI_EXPAND)	;
	GUICtrlSetState($TreeView2_CPU,$GUI_EXPAND)		;
EndFunc




Func xuanzeTreeView();����ѡ��TreeView�ĺ���
	_GUICtrlTreeView_SetChecked($TreeView1,23)
	_GUICtrlTreeView_SetChecked($TreeView1,31)
	_GUICtrlTreeView_SetChecked($TreeView1,32)
	_GUICtrlTreeView_SetChecked($TreeView1,39)
	_GUICtrlTreeView_SetChecked($TreeView1,40)
	_GUICtrlTreeView_SetChecked($TreeView1,52)
	_GUICtrlTreeView_SetChecked($TreeView1,53)
	_GUICtrlTreeView_SetChecked($TreeView1,67)
	_GUICtrlTreeView_SetChecked($TreeView1,68)
	For $d = 68 To 82
		_GUICtrlTreeView_SetChecked($TreeView1,$d)
	Next
	_GUICtrlTreeView_SetChecked($TreeView1,92)
	
;~ 	�ж�CPU���Ͳ�ѡ��
	If StringInStr($CPU,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,21)
		_GUICtrlTreeView_SetChecked($TreeView1,22)
	EndIf
;~ 	�жϽ���

;~ �ж�����оƬ���Ͳ�ѡ��
	If StringInStr($beiqiao&$nanqiao,"ALi") Or StringInStr($beiqiao&$nanqiao,"ULi") Then
		_GUICtrlTreeView_SetChecked($TreeView1,24)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"AMD") Or StringInStr($beiqiao&$nanqiao,"ATi") Then
		_GUICtrlTreeView_SetChecked($TreeView1,25)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,26)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,27)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,28)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,29)
	EndIf
	If StringInStr($beiqiao&$nanqiao,"NoteBook") Then
		_GUICtrlTreeView_SetChecked($TreeView1,30)
	EndIf
;~ 	�жϽ���

;~ �ж��Կ����Ͳ�ѡ��
	If StringInStr($Vidao,"AMD") Or StringInStr($Vidao,"ATi") Or StringInStr($Vidao,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,33)
	EndIf
	If StringInStr($Vidao,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,34)
	EndIf
	If StringInStr($Vidao,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,35)
	EndIf
	If StringInStr($Vidao,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,36)
	EndIf
	If StringInStr($Vidao,"VIA") Or StringInStr($Vidao,"S3") Then
		_GUICtrlTreeView_SetChecked($TreeView1,37)
	EndIf
	If StringInStr($Vidao,"VMware") Then
		_GUICtrlTreeView_SetChecked($TreeView1,38)
	EndIf
	
	If StringInStr($Vidao2,"AMD") Or StringInStr($Vidao2,"ATi") Or StringInStr($Vidao2,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,33)
	EndIf
	If StringInStr($Vidao2,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,34)
	EndIf
	If StringInStr($Vidao2,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,35)
	EndIf
	If StringInStr($Vidao2,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,36)
	EndIf
	If StringInStr($Vidao2,"VIA") Or StringInStr($Vidao2,"S3") Then
		_GUICtrlTreeView_SetChecked($TreeView1,37)
	EndIf
	If StringInStr($Vidao2,"VMware") Then
		_GUICtrlTreeView_SetChecked($TreeView1,38)
	EndIf
	
	If StringInStr($Vidao3,"AMD") Or StringInStr($Vidao3,"ATi") Or StringInStr($Vidao3,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,33)
	EndIf
	If StringInStr($Vidao3,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,34)
	EndIf
	If StringInStr($Vidao3,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,35)
	EndIf
	If StringInStr($Vidao3,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,36)
	EndIf
	If StringInStr($Vidao3,"VIA") Or StringInStr($Vidao3,"S3") Then
		_GUICtrlTreeView_SetChecked($TreeView1,37)
	EndIf
	If StringInStr($Vidao3,"VMware") Then
		_GUICtrlTreeView_SetChecked($TreeView1,38)
	EndIf
;~ 	�жϽ���
	
;~ 	�ж��������Ͳ�ѡ��
	If StringInStr($Audio,"AD") Or StringInStr($Audio,"Inte") Then
		_GUICtrlTreeView_SetChecked($TreeView1,41)
	EndIf
	If StringInStr($Audio,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,42)
	EndIf
	If StringInStr($Audio,"C-Media") Then
		_GUICtrlTreeView_SetChecked($TreeView1,43)
	EndIf
	If StringInStr($Audio,"Conexant") Then
		_GUICtrlTreeView_SetChecked($TreeView1,44)
	EndIf
	If StringInStr($Audio,"Creative") Then
		_GUICtrlTreeView_SetChecked($TreeView1,45)
	EndIf
	If StringInStr($Audio,"High Definition") Then
		_GUICtrlTreeView_SetChecked($TreeView1,46)
	EndIf
	If StringInStr($Audio,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,47)
	EndIf
	If StringInStr($Audio,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,48)
	EndIf
	If StringInStr($Audio,"Sigmatel") Or StringInStr($Audio,"IDT") Then
		_GUICtrlTreeView_SetChecked($TreeView1,49)
	EndIf
	If StringInStr($Audio,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,50)
	EndIf
	If StringInStr($Audio,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,51)
	EndIf
	
	If StringInStr($Audio2,"AD") Or StringInStr($Audio,"Inte") Then
		_GUICtrlTreeView_SetChecked($TreeView1,41)
	EndIf
	If StringInStr($Audio2,"ATI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,42)
	EndIf
	If StringInStr($Audio2,"C-Media") Then
		_GUICtrlTreeView_SetChecked($TreeView1,43)
	EndIf
	If StringInStr($Audio2,"Conexant") Then
		_GUICtrlTreeView_SetChecked($TreeView1,44)
	EndIf
	If StringInStr($Audio2,"Creative") Then
		_GUICtrlTreeView_SetChecked($TreeView1,45)
	EndIf
	If StringInStr($Audio2,"High Definition") Then
		_GUICtrlTreeView_SetChecked($TreeView1,46)
	EndIf
	If StringInStr($Audio2,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,47)
	EndIf
	If StringInStr($Audio2,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,48)
	EndIf
	If StringInStr($Audio2,"Sigmatel") Or StringInStr($Audio,"IDT") Then
		_GUICtrlTreeView_SetChecked($TreeView1,49)
	EndIf
	If StringInStr($Audio2,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,50)
	EndIf
	If StringInStr($Audio2,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,51)
	EndIf
;~ 	�жϽ���
	
;~ 	�ж��������Ͳ�ѡ��
	If StringInStr($Network,"3Com") Then
		_GUICtrlTreeView_SetChecked($TreeView1,54)
	EndIf
	If StringInStr($Network,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,55)
	EndIf
	If StringInStr($Network,"Atheros") Then
		_GUICtrlTreeView_SetChecked($TreeView1,56)
	EndIf
	If StringInStr($Network,"Broadcom") Then
		_GUICtrlTreeView_SetChecked($TreeView1,57)
	EndIf
	If StringInStr($Network,"D-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,58)
	EndIf
	If StringInStr($Network,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,59)
	EndIf
	If StringInStr($Network,"Marvell") Then
		_GUICtrlTreeView_SetChecked($TreeView1,60)
	EndIf
	If StringInStr($Network,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,61)
	EndIf
	If StringInStr($Network,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,62)
	EndIf
	If StringInStr($Network,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,63)
	EndIf
	If StringInStr($Network,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,64)
	EndIf
	If StringInStr($Network,"TP-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,65)
	EndIf
	If StringInStr($Network,"ULI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,66)
	EndIf
	If StringInStr($Network,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,67)
	EndIf
	
	If StringInStr($Network2,"3Com") Then
		_GUICtrlTreeView_SetChecked($TreeView1,54)
	EndIf
	If StringInStr($Network2,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,55)
	EndIf
	If StringInStr($Network2,"Atheros") Then
		_GUICtrlTreeView_SetChecked($TreeView1,56)
	EndIf
	If StringInStr($Network2,"Broadcom") Then
		_GUICtrlTreeView_SetChecked($TreeView1,57)
	EndIf
	If StringInStr($Network2,"D-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,58)
	EndIf
	If StringInStr($Network2,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,59)
	EndIf
	If StringInStr($Network2,"Marvell") Then
		_GUICtrlTreeView_SetChecked($TreeView1,60)
	EndIf
	If StringInStr($Network2,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,61)
	EndIf
	If StringInStr($Network2,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,62)
	EndIf
	If StringInStr($Network2,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,63)
	EndIf
	If StringInStr($Network2,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,64)
	EndIf
	If StringInStr($Network2,"TP-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,65)
	EndIf
	If StringInStr($Network2,"ULI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,66)
	EndIf
	If StringInStr($Network2,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,67)
	EndIf
	
	If StringInStr($Network3,"3Com") Then
		_GUICtrlTreeView_SetChecked($TreeView1,54)
	EndIf
	If StringInStr($Network3,"AMD") Then
		_GUICtrlTreeView_SetChecked($TreeView1,55)
	EndIf
	If StringInStr($Network3,"Atheros") Then
		_GUICtrlTreeView_SetChecked($TreeView1,56)
	EndIf
	If StringInStr($Network3,"Broadcom") Then
		_GUICtrlTreeView_SetChecked($TreeView1,57)
	EndIf
	If StringInStr($Network3,"D-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,58)
	EndIf
	If StringInStr($Network3,"Intel") Then
		_GUICtrlTreeView_SetChecked($TreeView1,59)
	EndIf
	If StringInStr($Network3,"Marvell") Then
		_GUICtrlTreeView_SetChecked($TreeView1,60)
	EndIf
	If StringInStr($Network3,"nVIDIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,61)
	EndIf
	If StringInStr($Network3,"Realtek") Then
		_GUICtrlTreeView_SetChecked($TreeView1,62)
	EndIf
	If StringInStr($Network3,"SiS") Then
		_GUICtrlTreeView_SetChecked($TreeView1,63)
	EndIf
	If StringInStr($Network3,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,64)
	EndIf
	If StringInStr($Network3,"TP-Link") Then
		_GUICtrlTreeView_SetChecked($TreeView1,65)
	EndIf
	If StringInStr($Network3,"ULI") Then
		_GUICtrlTreeView_SetChecked($TreeView1,66)
	EndIf
	If StringInStr($Network3,"VIA") Then
		_GUICtrlTreeView_SetChecked($TreeView1,67)
	EndIf
;~ 	�жϽ���
	
;~ 	�жϱʼǱ������Ͳ�ѡ��
	$_SYSTEM_POWER_STATUS=DllStructCreate('byte[4];dword[2]')
    DllCall('Kernel32.dll','bool','GetSystemPowerStatus','ptr',DllStructGetPtr($_SYSTEM_POWER_STATUS))
	$j = DllStructGetData($_SYSTEM_POWER_STATUS,1,2);�����ж���ͨ���ʼǱ��ĵ�Դ�����жϣ�ֻ�ܵ�80%����һ��ȫ��
	If $j <> 128 Then
		For $j1 = 83 To 91
			_GUICtrlTreeView_SetChecked($TreeView1,$j1)
		Next
		_GUICtrlTreeView_SetChecked($TreeView1,94)
	Else 
		_GUICtrlTreeView_SetChecked($TreeView1,93)
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
		If StringInStr($e3,"CPU") Then
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\CPU" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Board") Then
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Board" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Audio") Then
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Audio" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Network") Then
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Network" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Video") Then
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Video" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"MassStorage") Then 
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\MassStorage" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Modem") Then 
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Modem" & " -r","",@SW_HIDE)
		ElseIf StringInStr($e3,"Camera") Then 
			RunWait($zcxtj & "\7za.exe" & " x " & @ScriptDir & "\" & $e3 & " -y -o" & $e & "\Camera" & " -r","",@SW_HIDE)
		EndIf
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
		If $nMsg = 15 Then 
			$f1 = GUICtrlRead($Input1)
		ElseIf $nMsg = 16 Then
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

Func anzhuang();���尲װ�������������������nlite����
	pdDPIhj();�����ж�DPI�����ĺ���
	$g = _GUICtrlListView_GetItemCount($ListView2)
	For 	$g1 = 0 To $g - 1
		_GUICtrlListView_ClickItem($ListView2, $g1)
		$g2=_GUICtrlListView_GetItemTexT($ListView2,$g1,1)
		_GUICtrlListView_SetItemText($ListView2,$g1,"-->")
		_GUICtrlListView_ClickItem($ListView2, $g1)
		RunWait($zcxtj & "\DPInst.exe" & $DPInstcs & $g2 & " /F /SE /SW","",@SW_HIDE);����DPI��װ����
	    _GUICtrlListView_SetItemText($ListView2,$g1,"��")
	Next 
EndFunc

Func anzhuang1();���尲װ�����������÷�װ
	Global $g2_1
	$g = _GUICtrlListView_GetItemCount($ListView2)
	For 	$g1 = 0 To $g - 1
		_GUICtrlListView_ClickItem($ListView2, $g1)
		$g2=_GUICtrlListView_GetItemTexT($ListView2,$g1,1)
		_GUICtrlListView_SetItemText($ListView2,$g1,"-->")
		_GUICtrlListView_ClickItem($ListView2, $g1)
		$g2 = $g2 & ";"
		$g2_1 &= $g2
	    _GUICtrlListView_SetItemText($ListView2,$g1,"��")
	Next 
	RegWrite("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\","DevicePath", _
                "REG_EXPAND_SZ",$g2_1 & "%SystemRoot%\inf")	;д��ע���DevicePath��ֵ��������װ����
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
	If $time <= 0 Then ControlClick("Smart_Driver_V2.5","",$Button1,"left",1)
EndFunc

Func Exit_();��������˳�ʱҪִ�е��������
	GUISetState(@SW_HIDE)
	DllClose($Dll)
	DirRemove($zcxtj,1)
	Exit
EndFunc

Func _nlite();�����װʱ�Ĳ�������Ҫ������nlite��װʱ�� ,,,,,nlite���ϰ�װ����ϵͳ��������====== -nlite ========
	Global $nlite
	If $CmdLine[0] = 1 Then
		$nlite = $CmdLine[1]
		If $nlite <> "-nlite" Then;һ����Ҫ��-nlite�������������Ȼ��������
			MsgBox(0+16,"Error","      �������ô���" & @CR & "�����ʽΪ��XX.exe -nlite",5)
			Exit
		EndIf
	EndIf
EndFunc

Func _devcon();�������������ĺ�������Ҫ�ǵ���DEVCON
	If ProcessExists("explorer.exe") Then
		If @OSArch = "X86" Then
			ShellExecuteWait($zcxtj & "\devcon32.exe"," rescan","","",@SW_HIDE)
		ElseIf @OSArch = "X64" Then
			ShellExecuteWait($zcxtj & "\devcon64.exe"," rescan","","",@SW_HIDE)
		EndIf
	EndIf
EndFunc



	
	
	
	
	
	