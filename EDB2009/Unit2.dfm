object Form2: TForm2
  Left = 83
  Top = 200
  Caption = 'Form2'
  ClientHeight = 282
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object DBGrid1: TDBGrid
    Left = 0
    Top = 26
    Width = 652
    Height = 230
    Align = alClient
    DataSource = DataSource1
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnColEnter = DBGrid1ColEnter
    OnColumnMoved = DBGrid1ColumnMoved
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnKeyUp = DBGrid1KeyUp
    OnTitleClick = DBGrid1TitleClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 652
    Height = 26
    Align = alBottom
    TabOrder = 1
    object Panel2: TPanel
      Left = 397
      Top = 1
      Width = 254
      Height = 24
      Align = alRight
      TabOrder = 0
      object DBNavigator1: TDBNavigator
        Left = 1
        Top = 1
        Width = 252
        Height = 22
        DataSource = DataSource1
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 396
      Height = 24
      Align = alClient
      TabOrder = 1
      object StatusBar1: TStatusBar
        Left = 1
        Top = 1
        Width = 394
        Height = 22
        Align = alClient
        Panels = <
          item
            Width = 200
          end
          item
            Width = 50
          end>
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 652
    Height = 26
    Align = alTop
    AutoSize = True
    BevelEdges = [beLeft, beTop, beRight]
    BevelOuter = bvRaised
    BevelKind = bkNone
    BevelWidth = 7
    DockSite = False
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 122
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      Images = Main.ImageList1
      TabOrder = 0
      object ToolButton9: TToolButton
        Left = 0
        Top = 0
        Action = aOpenAttr
      end
      object ToolButton4: TToolButton
        Left = 23
        Top = 0
        Action = aOEM
      end
      object ToolButton1: TToolButton
        Left = 46
        Top = 0
        Action = aGoToR
      end
      object ToolButton2: TToolButton
        Left = 69
        Top = 0
        Action = aHeader
      end
      object ToolButton3: TToolButton
        Left = 92
        Top = 0
        Action = aStruct
      end
    end
    object ToolBar2: TToolBar
      Left = 146
      Top = 2
      Width = 291
      Height = 22
      Anchors = []
      AutoSize = True
      Caption = 'ToolBar2'
      Images = Main.ImageList1
      TabOrder = 1
      object FilterText: TComboBox
        Left = 0
        Top = 0
        Width = 265
        Height = 24
        Hint = 'Enter heare find string or a filter expression'
        ItemHeight = 16
        TabOrder = 0
        OnChange = FilterTextChange
      end
      object ToolButton5: TToolButton
        Left = 265
        Top = 0
        Action = aFilter
      end
    end
    object ToolBar3: TToolBar
      Left = 450
      Top = 2
      Width = 75
      Height = 22
      Anchors = []
      AutoSize = True
      Caption = 'ToolBar3'
      Images = Main.ImageList1
      TabOrder = 2
      object ToolButton6: TToolButton
        Left = 0
        Top = 0
        Action = aOrders
      end
      object ToolButton7: TToolButton
        Left = 23
        Top = 0
        Action = aMasterDital
      end
      object ToolButton8: TToolButton
        Left = 46
        Top = 0
        Action = aLocate
      end
    end
    object ToolBar4: TToolBar
      Left = 538
      Top = 2
      Width = 103
      Height = 22
      Caption = 'ToolBar4'
      Images = Main.ImageList1
      TabOrder = 3
      object ToolButton10: TToolButton
        Left = 0
        Top = 0
        Action = aToExcel
      end
      object ToolButton11: TToolButton
        Left = 23
        Top = 0
        Caption = 'ToolButton11'
        ImageIndex = 325
        OnClick = ToolButton11Click
      end
      object ToolButton12: TToolButton
        Left = 46
        Top = 0
        Caption = 'ToolButton12'
        ImageIndex = 326
        OnClick = ToolButton12Click
      end
      object ToolButton13: TToolButton
        Left = 69
        Top = 0
        Caption = 'ToolButton13'
        ImageIndex = 327
        OnClick = ToolButton13Click
      end
    end
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Images = Main.ImageList1
    Left = 348
    Top = 160
    object One1: TMenuItem
      Caption = 'Property'
      GroupIndex = 10
      object One2: TMenuItem
        Caption = 'OEM'
        Hint = 'OEM'
        ImageIndex = 136
        OnClick = aOEMExecute
      end
      object SetDeleted1: TMenuItem
        Caption = 'SetDeleted'
        Hint = 'Set Deleted'
        ImageIndex = 82
        OnClick = aSetDeletedExecute
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Openattributes1: TMenuItem
        Action = aOpenAttr
      end
    end
    object Actions1: TMenuItem
      Caption = 'Actions'
      GroupIndex = 10
      object GotoRecord1: TMenuItem
        Caption = 'Goto Record'
        Hint = 'Goto Record'
        ImageIndex = 256
        OnClick = aGoToRExecute
      end
      object DBFHeader1: TMenuItem
        Caption = 'DBF Header'
        Hint = 'DBF Header'
        ImageIndex = 182
        OnClick = aHeaderExecute
      end
      object DBFStructure1: TMenuItem
        Caption = 'DBF Structure'
        Hint = 'DBF Structure'
        ImageIndex = 264
        OnClick = aStructExecute
      end
      object SetFilter1: TMenuItem
        Caption = 'Set Filter'
        Hint = 'Set Filter'
        ImageIndex = 118
        OnClick = aFilterExecute
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Orders1: TMenuItem
        Caption = 'Orders'
        Hint = 'Orders'
        ImageIndex = 140
        OnClick = aOrdersExecute
      end
      object MasterDital1: TMenuItem
        Action = aMasterDital
      end
      object aLocate1: TMenuItem
        Action = aLocate
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object GridToExcel1: TMenuItem
        Action = aToExcel
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ClearfieldSetNullAltDel1: TMenuItem
        Action = aClearFld
      end
      object LoadfiletoLob2: TMenuItem
        Action = aFileToLob
      end
      object SavefilefromLOB2: TMenuItem
        Action = aLobToFile
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object TruncateZAP1: TMenuItem
        Action = aTruncate
      end
      object Pack2: TMenuItem
        Action = aPack
      end
      object ReindexAll2: TMenuItem
        Action = aReindexAll
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object DeleteRecallrecord2: TMenuItem
        Action = aDelRecall
      end
    end
  end
  object dbfntx1: TVKDBFNTX
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    AfterOpen = dbfntx1AfterOpen
    AfterScroll = dbfntx1AfterScroll
    TrimInLocate = False
    TrimCType = True
    StorageType = pstFile
    AccessMode.AccessMode = 66
    AccessMode.OpenRead = False
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = True
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 8192
    WaitBusyRes = 3000
    CreateNow = False
    DbfVersion = xBaseIII
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 208
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = dbfntx1
    OnDataChange = DataSource1DataChange
    Left = 240
    Top = 156
  end
  object ActionList1: TActionList
    Images = Main.ImageList1
    Left = 380
    Top = 160
    object aOEM: TAction
      Caption = 'OEM'
      Hint = 'OEM'
      ImageIndex = 136
      OnExecute = aOEMExecute
    end
    object aSetDeleted: TAction
      Caption = 'SetDeleted'
      Hint = 'Set Deleted'
      ImageIndex = 82
      OnExecute = aSetDeletedExecute
    end
    object aGoToR: TAction
      Caption = 'Goto Record'
      Hint = 'Goto Record'
      ImageIndex = 256
      OnExecute = aGoToRExecute
    end
    object aHeader: TAction
      Caption = 'DBF Header'
      Hint = 'DBF Header'
      ImageIndex = 182
      OnExecute = aHeaderExecute
    end
    object aStruct: TAction
      Caption = 'DBF Structure'
      Hint = 'DBF Structure'
      ImageIndex = 264
      OnExecute = aStructExecute
    end
    object aFilter: TAction
      Caption = 'Set Filter'
      Hint = 'Set Filter'
      ImageIndex = 118
      OnExecute = aFilterExecute
    end
    object aOrders: TAction
      Caption = 'Orders'
      Hint = 'Orders'
      ImageIndex = 140
      OnExecute = aOrdersExecute
    end
    object aMasterDital: TAction
      Caption = 'Master - Dital'
      Hint = 'Master - Dital'
      ImageIndex = 216
      OnExecute = aMasterDitalExecute
    end
    object aLocate: TAction
      Caption = 'Locate'
      Hint = 'Locate'
      ImageIndex = 118
      OnExecute = aLocateExecute
    end
    object aOpenAttr: TAction
      Caption = 'Open attributes'
      Hint = 'Open attributes'
      ImageIndex = 132
      OnExecute = aOpenAttrExecute
    end
    object aToExcel: TAction
      Caption = 'Grid To Excel'
      Hint = 'Grid To Excel'
      ImageIndex = 324
      OnExecute = aToExcelExecute
    end
    object aClearFld: TAction
      Caption = 'Clear field (Set Null)  Alt-Del'
      Hint = 'Clear field (Set Null)  Alt-Del'
      OnExecute = aClearFldExecute
    end
    object aFileToLob: TAction
      Caption = 'Load file to LOB'
      Hint = 'Load file to LOB'
      OnExecute = aFileToLobExecute
    end
    object aLobToFile: TAction
      Caption = 'Save file from LOB'
      Hint = 'Save file from LOB'
      OnExecute = aLobToFileExecute
    end
    object aTruncate: TAction
      Caption = 'Truncate (ZAP)'
      Hint = 'Truncate DBF with LOB and Indexes'
      OnExecute = aTruncateExecute
    end
    object aPack: TAction
      Caption = 'Pack'
      Hint = 'Remove all deleted records'
      OnExecute = aPackExecute
    end
    object aReindexAll: TAction
      Caption = 'Reindex All'
      Hint = 'Reindex all indexes in table'
      OnExecute = aReindexAllExecute
    end
    object aDelRecall: TAction
      Caption = 'Delete / Recall record'
      Hint = 'Delete or Recall record'
      OnExecute = aDelRecallExecute
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'XLS'
    Filter = 'Excel WorkBook|*.XLS'
    Left = 540
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    Left = 448
    Top = 160
    object ClearfieldSetNullAltDel2: TMenuItem
      Action = aClearFld
    end
    object LoadfiletoLob1: TMenuItem
      Action = aFileToLob
    end
    object SavefilefromLOB1: TMenuItem
      Action = aLobToFile
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object TruncateZAP2: TMenuItem
      Action = aTruncate
    end
    object Pack1: TMenuItem
      Action = aPack
    end
    object ReindexAll1: TMenuItem
      Action = aReindexAll
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object DeleteRecallrecord1: TMenuItem
      Action = aDelRecall
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object LockTable1: TMenuItem
      Caption = 'Lock Table'
      OnClick = LockTable1Click
    end
    object UnlockTable1: TMenuItem
      Caption = 'Unlock Table'
      OnClick = UnlockTable1Click
    end
  end
  object OpenDialog2: TOpenDialog
    Left = 28
    Top = 108
  end
  object SaveDialog1: TSaveDialog
    Left = 56
    Top = 108
  end
end
