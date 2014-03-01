object Form12: TForm12
  Left = 285
  Top = 198
  Width = 239
  Height = 195
  Caption = 'Choice view memo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object RadioGroup1: TRadioGroup
    Left = 20
    Top = 12
    Width = 165
    Height = 105
    ItemIndex = 0
    Items.Strings = (
      'Text'
      'Rich Text Format')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 152
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
end
