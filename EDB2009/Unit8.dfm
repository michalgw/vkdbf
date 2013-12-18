object Form8: TForm8
  Left = 68
  Top = 88
  Width = 680
  Height = 475
  Caption = 'Locate'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Tag = 1
    Left = 360
    Top = 377
    Width = 197
    Height = 24
    Caption = 'Locate'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 563
    Top = 385
    Width = 92
    Height = 31
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 2
    Top = 389
    Width = 92
    Height = 31
    Caption = 'Fill'
    TabOrder = 2
    OnClick = Button3Click
  end
  object StringGrid1: TStringGrid
    Left = 4
    Top = 8
    Width = 653
    Height = 365
    ColCount = 4
    DefaultColWidth = 18
    DefaultRowHeight = 20
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goEditing]
    TabOrder = 3
    OnDrawCell = StringGrid1DrawCell
    OnMouseUp = StringGrid1MouseUp
    ColWidths = (
      18
      144
      55
      381)
  end
  object GroupBox1: TGroupBox
    Left = 104
    Top = 376
    Width = 225
    Height = 53
    Caption = 'Locate options'
    TabOrder = 4
    object CheckBox1: TCheckBox
      Left = 4
      Top = 16
      Width = 145
      Height = 17
      Caption = 'loCaseInsensitive'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 4
      Top = 32
      Width = 141
      Height = 17
      Caption = 'loPartialKey'
      TabOrder = 1
    end
  end
  object Button4: TButton
    Tag = 2
    Left = 360
    Top = 401
    Width = 197
    Height = 24
    Caption = 'Locate next (Only for full scan)'
    TabOrder = 5
    OnClick = Button1Click
  end
end
