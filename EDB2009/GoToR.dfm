object GoToR: TGoToR
  Left = 304
  Top = 249
  Width = 212
  Height = 129
  Caption = 'New Recno'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 20
    Top = 12
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 4
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 84
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
