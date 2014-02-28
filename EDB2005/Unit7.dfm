object Form7: TForm7
  Left = 30
  Top = 94
  Width = 671
  Height = 470
  Caption = 'Master - Dital'
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
    Left = 20
    Top = 320
    Width = 81
    Height = 16
    Caption = 'Master Fields'
  end
  object Label2: TLabel
    Left = 15
    Top = 5
    Width = 85
    Height = 16
    Caption = 'Master source'
  end
  object ListView1: TListView
    Left = 10
    Top = 30
    Width = 641
    Height = 276
    Columns = <
      item
        AutoSize = True
        Caption = 'Caption'
      end>
    HideSelection = False
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Edit1: TEdit
    Left = 10
    Top = 345
    Width = 641
    Height = 24
    TabOrder = 1
  end
  object Button1: TButton
    Left = 345
    Top = 394
    Width = 92
    Height = 31
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 561
    Top = 394
    Width = 93
    Height = 31
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 453
    Top = 394
    Width = 92
    Height = 31
    Caption = 'Clear'
    TabOrder = 4
    OnClick = Button3Click
  end
end
