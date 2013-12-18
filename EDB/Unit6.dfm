object Form6: TForm6
  Left = 56
  Top = 116
  Width = 676
  Height = 463
  Caption = 'Order properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 15
    Top = 20
    Width = 86
    Height = 16
    Caption = 'NTXFileName'
  end
  object Label2: TLabel
    Left = 15
    Top = 54
    Width = 83
    Height = 16
    Caption = 'KeyExpresion'
  end
  object Label3: TLabel
    Left = 15
    Top = 89
    Width = 80
    Height = 16
    Caption = 'ForExpresion'
  end
  object Label4: TLabel
    Left = 15
    Top = 162
    Width = 34
    Height = 16
    Caption = 'Order'
  end
  object Label7: TLabel
    Left = 240
    Top = 160
    Width = 52
    Height = 16
    Caption = 'Collation'
  end
  object Label8: TLabel
    Left = 8
    Top = 196
    Width = 161
    Height = 16
    Caption = 'Custom collation sequence'
  end
  object Button1: TButton
    Left = 433
    Top = 394
    Width = 93
    Height = 31
    Caption = 'Ok'
    TabOrder = 10
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 542
    Top = 394
    Width = 92
    Height = 31
    Caption = 'Cancel'
    TabOrder = 11
    OnClick = Button2Click
  end
  object NtxFileName: TEdit
    Left = 113
    Top = 10
    Width = 513
    Height = 24
    TabOrder = 0
  end
  object Button3: TButton
    Left = 630
    Top = 10
    Width = 31
    Height = 26
    Caption = '...'
    TabOrder = 1
    OnClick = Button3Click
  end
  object KeyExpresion: TEdit
    Left = 113
    Top = 44
    Width = 548
    Height = 24
    TabOrder = 2
  end
  object ForExpresion: TEdit
    Left = 113
    Top = 79
    Width = 548
    Height = 24
    TabOrder = 3
  end
  object KeyTranslate: TCheckBox
    Left = 15
    Top = 123
    Width = 106
    Height = 21
    Caption = 'KeyTranslate'
    TabOrder = 4
  end
  object Unique: TCheckBox
    Left = 135
    Top = 123
    Width = 72
    Height = 21
    Caption = 'Unique'
    TabOrder = 5
  end
  object Desc: TCheckBox
    Left = 219
    Top = 123
    Width = 62
    Height = 21
    Caption = 'Desc'
    TabOrder = 6
  end
  object Temp: TCheckBox
    Left = 293
    Top = 123
    Width = 62
    Height = 21
    Caption = 'Temp'
    TabOrder = 7
  end
  object Order: TEdit
    Left = 59
    Top = 158
    Width = 149
    Height = 24
    TabOrder = 8
  end
  object GroupBox1: TGroupBox
    Left = 208
    Top = 251
    Width = 354
    Height = 129
    Caption = 'Range'
    TabOrder = 9
    object Label5: TLabel
      Left = 15
      Top = 96
      Width = 36
      Height = 16
      Caption = 'HiKey'
    end
    object Label6: TLabel
      Left = 15
      Top = 57
      Width = 38
      Height = 16
      Caption = 'LoKey'
    end
    object RangeActive: TCheckBox
      Left = 64
      Top = 20
      Width = 119
      Height = 21
      Caption = 'Active'
      TabOrder = 0
    end
    object HiKey: TEdit
      Left = 64
      Top = 86
      Width = 278
      Height = 24
      TabOrder = 2
    end
    object LoKey: TEdit
      Left = 64
      Top = 47
      Width = 278
      Height = 24
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 251
    Width = 193
    Height = 129
    Caption = 'Limit index pages in memory'
    TabOrder = 12
    object ShowLimit: TLabel
      Left = 84
      Top = 24
      Width = 7
      Height = 16
      Caption = '0'
    end
    object ShowPages: TLabel
      Left = 136
      Top = 24
      Width = 7
      Height = 16
      Caption = '0'
    end
    object LimitAouto: TRadioButton
      Left = 8
      Top = 24
      Width = 53
      Height = 17
      Caption = 'Auto'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object LimitLimited: TRadioButton
      Left = 8
      Top = 60
      Width = 73
      Height = 17
      Caption = 'Limited'
      TabOrder = 1
      OnClick = LimitLimitedClick
    end
    object LimitUnlimited: TRadioButton
      Left = 8
      Top = 100
      Width = 81
      Height = 17
      Caption = 'Unlimited'
      TabOrder = 2
    end
    object EditLimit: TEdit
      Left = 84
      Top = 52
      Width = 45
      Height = 24
      Enabled = False
      TabOrder = 3
      Text = '20'
    end
    object EditPgPB: TEdit
      Left = 136
      Top = 52
      Width = 49
      Height = 24
      TabOrder = 4
      Text = '2'
    end
  end
  object Collations: TComboBox
    Left = 312
    Top = 158
    Width = 193
    Height = 24
    ItemHeight = 16
    TabOrder = 13
    Text = 'cltNone'
    Items.Strings = (
      'cltNone'
      'cltCustom'
      'cltClipper501Rus'
      'cltGermanCollation      '
      'cltFrenchCollation'
      'cltSpanishCollation'
      'cltItalianCollation'
      'cltSwedishCollation'
      'cltPortugueseCollation'
      'cltNorwegianCollation'
      'cltFinnishCollation'
      'cltDutchCollation'
      'cltDanishCollation'
      'cltGreek437Collation'
      'cltGreek851Collation'
      'cltIcelandic850Collation'
      'cltIcelandic861Collation'
      'cltPolish852Collation'
      'cltHungarianCWICollation'
      'cltHungarian852Collation')
  end
  object CustomCollationSeq: TEdit
    Left = 8
    Top = 212
    Width = 649
    Height = 24
    TabOrder = 14
  end
  object OD: TOpenDialog
    Filter = 'Clipper Index Files|*.NTX'
    Options = []
    Left = 156
    Top = 2
  end
end
