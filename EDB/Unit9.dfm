object Form9: TForm9
  Left = 84
  Top = 108
  Width = 584
  Height = 507
  Caption = 'Open Attributes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 5
    Top = 39
    Width = 89
    Height = 16
    Caption = 'DBF FileName'
  end
  object Label2: TLabel
    Left = 177
    Top = 83
    Width = 99
    Height = 16
    Caption = 'Wait busy resurs'
  end
  object Label3: TLabel
    Left = 414
    Top = 83
    Width = 24
    Height = 16
    Caption = 'm.s.'
  end
  object Label4: TLabel
    Left = 208
    Top = 132
    Width = 61
    Height = 16
    Caption = 'Buffer size'
  end
  object Label5: TLabel
    Left = 412
    Top = 132
    Width = 33
    Height = 16
    Caption = 'bytes'
  end
  object Label8: TLabel
    Left = 12
    Top = 296
    Width = 85
    Height = 16
    Caption = 'Lob page size'
  end
  object cActive: TCheckBox
    Left = 5
    Top = 5
    Width = 119
    Height = 21
    Caption = 'Active'
    TabOrder = 0
    OnClick = cActiveClick
  end
  object eDbfFileName: TEdit
    Left = 103
    Top = 34
    Width = 405
    Height = 24
    TabOrder = 1
    OnChange = eDbfFileNameChange
  end
  object cRead: TCheckBox
    Left = 14
    Top = 109
    Width = 119
    Height = 21
    Caption = 'Read'
    TabOrder = 2
    OnClick = cReadClick
  end
  object cReadWrite: TCheckBox
    Left = 14
    Top = 129
    Width = 119
    Height = 21
    Caption = 'ReadWrite'
    TabOrder = 3
    OnClick = cReadWriteClick
  end
  object cWrite: TCheckBox
    Left = 14
    Top = 148
    Width = 119
    Height = 21
    Caption = 'Write'
    TabOrder = 4
    OnClick = cWriteClick
  end
  object cDenyNone: TCheckBox
    Left = 14
    Top = 183
    Width = 119
    Height = 21
    Caption = 'DenyNone'
    TabOrder = 5
    OnClick = cDenyNoneClick
  end
  object cDenyRead: TCheckBox
    Left = 14
    Top = 202
    Width = 119
    Height = 21
    Caption = 'DenyRead'
    Enabled = False
    TabOrder = 6
    OnClick = cDenyReadClick
  end
  object cDenyWrite: TCheckBox
    Left = 14
    Top = 222
    Width = 119
    Height = 21
    Caption = 'DenyWrite'
    TabOrder = 7
    OnClick = cDenyWriteClick
  end
  object cExclusive: TCheckBox
    Left = 14
    Top = 242
    Width = 119
    Height = 21
    Caption = 'Exclusive'
    TabOrder = 8
    OnClick = cExclusiveClick
  end
  object Button1: TButton
    Left = 474
    Top = 432
    Width = 88
    Height = 30
    Caption = 'Ok'
    TabOrder = 9
    OnClick = Button1Click
  end
  object eWaitBusyRes: TEdit
    Left = 281
    Top = 73
    Width = 124
    Height = 24
    TabOrder = 10
    OnChange = eWaitBusyResChange
  end
  object eBuffSize: TEdit
    Left = 280
    Top = 124
    Width = 121
    Height = 24
    TabOrder = 11
    OnChange = eBuffSizeChange
  end
  object GroupBox1: TGroupBox
    Left = 172
    Top = 168
    Width = 245
    Height = 105
    Caption = 'Crypt'
    TabOrder = 12
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 45
      Height = 16
      Caption = 'Method'
    end
    object Label7: TLabel
      Left = 8
      Top = 76
      Width = 60
      Height = 16
      Caption = 'Password'
    end
    object CryptMethod: TComboBox
      Left = 72
      Top = 40
      Width = 165
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = CryptMethodChange
      Items.Strings = (
        'cmNONE'
        'cmXOR'
        'cmGost'
        'cmGost1')
    end
    object CryptActive: TCheckBox
      Left = 8
      Top = 20
      Width = 97
      Height = 17
      Caption = 'Active'
      TabOrder = 1
      OnClick = CryptActiveClick
    end
    object CryptPass: TEdit
      Left = 72
      Top = 72
      Width = 165
      Height = 24
      TabOrder = 2
      OnChange = CryptPassChange
    end
    object UseHash: TCheckBox
      Left = 112
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Use Hash?'
      TabOrder = 3
    end
  end
  object dbfType: TComboBox
    Left = 8
    Top = 68
    Width = 145
    Height = 24
    ItemHeight = 16
    TabOrder = 13
    OnChange = dbfTypeChange
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
    Left = 104
    Top = 288
    Width = 121
    Height = 24
    TabOrder = 14
    Text = '512'
  end
  object LockProtocol: TRadioGroup
    Left = 12
    Top = 332
    Width = 153
    Height = 125
    Caption = 'Table Lock protocol'
    ItemIndex = 0
    Items.Strings = (
      'lpNone'
      'lpDB4'
      'lpClipper'
      'lpFoxpro'
      'lpClipperForFoxLob')
    TabOrder = 15
    OnClick = LockProtocolClick
  end
  object FoxTableFlag: TGroupBox
    Left = 340
    Top = 300
    Width = 141
    Height = 101
    Caption = 'Fox table flag'
    TabOrder = 16
    OnClick = FoxTableFlagClick
    object HasGotIndex: TCheckBox
      Left = 8
      Top = 20
      Width = 110
      Height = 17
      Caption = 'Has got index'
      TabOrder = 0
    end
    object HasGotLOB: TCheckBox
      Left = 8
      Top = 48
      Width = 106
      Height = 17
      Caption = 'Has got LOB'
      TabOrder = 1
    end
    object ItIsTheDatabase: TCheckBox
      Left = 8
      Top = 76
      Width = 130
      Height = 17
      Caption = 'It is the Database'
      TabOrder = 2
    end
  end
  object LobLockProtocol: TRadioGroup
    Left = 176
    Top = 332
    Width = 153
    Height = 125
    Caption = 'Lob Lock protocol'
    ItemIndex = 0
    Items.Strings = (
      'lpNone'
      'lpDB4'
      'lpClipper'
      'lpFoxpro'
      'lpClipperForFoxLob')
    TabOrder = 17
    OnClick = LobLockProtocolClick
  end
end
