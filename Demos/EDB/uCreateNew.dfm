object CreateDBF: TCreateDBF
  Left = 38
  Top = 165
  Width = 685
  Height = 413
  Caption = 'Create new DBF table'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 82
    Width = 576
    Height = 299
    Align = alClient
    TabOrder = 0
    object BaseTypes: TComboBox
      Left = 80
      Top = 48
      Width = 101
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      Visible = False
      OnClick = BaseTypesClick
      OnExit = BaseTypesExit
      Items.Strings = (
        'C (Varchar)'
        'N (Number)'
        'D (Date)'
        'L (Logic)'
        'M (Memo)'
        'F (Float)'
        'O (Float)'
        'I (Integer)'
        '@ (DateTime)'
        '+ (AutoInc)'
        'B (BinaryLob/Float)'
        'G (GraphicLob/OLE)'
        'Y (Currency)'
        'E (Extended)')
    end
    object ExTypes: TComboBox
      Left = 260
      Top = 48
      Width = 145
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
      Visible = False
      OnClick = BaseTypesClick
      OnExit = ExTypesExit
      Items.Strings = (
        'DBFTS1'
        'DBFTU1'
        'DBFTS2'
        'DBFTU2'
        'DBFTS4'
        'DBFTU4'
        'DBFTS8'
        'DBFTR4'
        'DBFTR6'
        'DBFTR8'
        'DBFTD1'
        'DBFTD2'
        'DBFTS1_N'
        'DBFTU1_N'
        'DBFTS2_N'
        'DBFTU2_N'
        'DBFTS4_N'
        'DBFTU4_N'
        'DBFTS8_N'
        'DBFTR4_N'
        'DBFTR6_N'
        'DBFTR8_N'
        'DBFTD1_N'
        'DBFTD2_N'
        'DBFTCLOB'
        'DBFTBLOB'
        'DBFTGRAPHIC'
        'DBFTFMTMEMO'
        'DBFTSTRING'
        'DBFTSTRING_N '
        'DBFTFIXEDCHAR'
        'DBFTWIDESTRING'
        'DBFTCURRENCY'
        'DBFTCURRENCY_N '
        'DBFTBCD'
        'DBFTDATE'
        'DBFTDATE_N'
        'DBFTTIME'
        'DBFTTIME_N'
        'DBFTD3'
        'DBFTD3_N'
        'DBFTU1_NB'
        'DBFTU2_NB'
        'DBFTU4_NB'
        'DBFTR4_NB'
        'DBFTR6_NB'
        'DBFTR8_NB'
        'DBFTD1_NB'
        'DBFTD2_NB'
        'DBFTD3_NB'
        'DBFTDATE_NB'
        'DBFTTIME_NB'
        'DBFTCURRENCY_NB'
        'DBFTCLOB_NB'
        'DBFTBLOB_NB'
        'DBFTGRAPHIC_NB'
        'DBFTFMTMEMO_NB'
        'DBFTDBFDATASET')
    end
    object FieldFlag: TGroupBox
      Left = 272
      Top = 144
      Width = 145
      Height = 101
      Caption = 'Field Flag'
      TabOrder = 2
      OnExit = FieldFlagExit
      object cSystem: TCheckBox
        Left = 8
        Top = 16
        Width = 131
        Height = 17
        Caption = 'System'
        TabOrder = 0
      end
      object cCanStoreNull: TCheckBox
        Left = 8
        Top = 36
        Width = 131
        Height = 17
        Caption = 'Can store null'
        TabOrder = 1
      end
      object cBinaryColumn: TCheckBox
        Left = 8
        Top = 56
        Width = 131
        Height = 17
        Caption = 'Binary column'
        TabOrder = 2
      end
      object cAutoIncrement: TCheckBox
        Left = 8
        Top = 76
        Width = 131
        Height = 17
        Caption = 'AutoIncrement'
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel
    Left = 576
    Top = 82
    Width = 101
    Height = 299
    Align = alRight
    TabOrder = 1
    object Button2: TButton
      Left = 10
      Top = 164
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 14
      Top = 236
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 2
      Top = 8
      Width = 96
      Height = 25
      Caption = 'Read Structure'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 677
    Height = 41
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 12
      Width = 59
      Height = 16
      Caption = 'File name'
    end
    object Edit1: TEdit
      Left = 76
      Top = 4
      Width = 521
      Height = 24
      TabOrder = 0
    end
    object Button1: TButton
      Left = 608
      Top = 4
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 41
    Width = 677
    Height = 41
    Align = alTop
    TabOrder = 3
    object Label2: TLabel
      Left = 200
      Top = 16
      Width = 85
      Height = 16
      Caption = 'Lob page size'
    end
    object dbfType: TComboBox
      Left = 8
      Top = 9
      Width = 145
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      Items.Strings = (
        'xUnknown'
        'xClipper'
        'xBaseIII'
        'xBaseIV'
        'xBaseV'
        'xBaseVII'
        'xFoxPro'
        'xVisualFoxPro')
    end
    object LobPageSize: TEdit
      Left = 292
      Top = 8
      Width = 121
      Height = 24
      TabOrder = 1
      Text = '512'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'DBF tables|*.dbf'
    Left = 460
    Top = 4
  end
  object DBFNTX1: TVKDBFNTX
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    StorageType = pstFile
    AccessMode.AccessMode = 16
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = False
    AccessMode.ShareExclusive = True
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = False
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 3000
    CreateNow = False
    DbfVersion = xBaseIII
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    Left = 500
    Top = 180
  end
end
