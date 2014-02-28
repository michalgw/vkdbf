object PageOff: TPageOff
  Left = 254
  Top = 277
  Width = 580
  Height = 168
  Caption = 'Enter Value'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 20
    Width = 142
    Height = 16
    Caption = 'Any text or 123 or  $F134'
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 12
    Top = 48
    Width = 545
    Height = 24
    Hint = 'Hex edit'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 488
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
  object cbSoftSeek: TCheckBox
    Left = 12
    Top = 112
    Width = 97
    Height = 17
    Caption = 'SoftSeek'
    TabOrder = 2
  end
end
