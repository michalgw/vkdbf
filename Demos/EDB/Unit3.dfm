object Form3: TForm3
  Left = 182
  Top = 201
  Width = 576
  Height = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 225
    Width = 568
    Height = 50
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 233
      Top = 10
      Width = 92
      Height = 31
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 568
    Height = 225
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Name   Type  Length  Prec  Offset    Extended Type'
      '--------------------------------------------------'
      '        F1     C     10        0       1      0'
      '        F2     N     10        2      11      0'
      '        F3     D      8        0      21      0'
      '        F4     L      1        0      29      0'
      '        F5     M     10        0      30      0'
      '        E1     E     10        0      40     45'
      '        E2     E     26       12      44     47'
      '        E3     E      4        0      50     55'
      '        E4     E      4        0      54     56')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
