object TNtxPage: TTNtxPage
  Left = 129
  Top = 179
  Width = 820
  Height = 455
  Caption = 'NtxPage'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object StringGrid1: TStringGrid
    Left = 0
    Top = 29
    Width = 812
    Height = 370
    Align = alClient
    ColCount = 4
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goEditing, goAlwaysShowEditor]
    TabOrder = 0
    ColWidths = (
      50
      133
      134
      450)
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 812
    Height = 29
    Caption = 'ToolBar1'
    Images = ImageList1
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Action = aOpenPage
    end
    object ToolButton3: TToolButton
      Left = 23
      Top = 2
      Action = aFindParentPage
    end
    object ToolButton2: TToolButton
      Left = 46
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object Label1: TLabel
      Left = 54
      Top = 2
      Width = 47
      Height = 22
      Caption = 'Count: 0'
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 204
    Top = 132
    object Work1: TMenuItem
      Caption = 'Work'
      object OpenPage1: TMenuItem
        Action = aOpenPage
      end
      object FindParentPage1: TMenuItem
        Action = aFindParentPage
      end
    end
  end
  object ImageList1: TImageList
    Left = 236
    Top = 132
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E07FE07F
      E07F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E07FE07F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E07FF75EE07FF75E
      E07FF75EE07FF75EE07F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF7F0000E07FF75EE07F
      F75EE07FF75EE07FF75EE07F0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FFF7F0000E07FF75E
      E07FF75EE07FF75EE07FF75EE07F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF7FE07FFF7F00000000
      00000000000000000000000000000000000000000000000000000000E07FE07F
      E07F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FFF7FE07FFF7FE07F
      FF7FE07FFF7FE07F0000000000000000000000000000000000000000E07FE07F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF7FE07FFF7FE07FFF7F
      E07FFF7FE07FFF7F000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07FFF7FE07FFF7FE07F
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E07FFF7FE07FFF7F
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EF3D0000000000000000
      EF3D000000000000000000000000000000000000E07FE07FE07F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFBFFF00000000FFFFBFFF00000000
      FFFFB04900000000FFFF807F00000000C00FB07F000000008007B9FF00000000
      8003BFFF000000008001B049000000008001807F00000000800FB07F00000000
      800FB9FF00000000801FBFFF00000000C0FF048F00000000C0FF07FF00000000
      FFFF07FF00000000FFFF9FFF0000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 272
    Top = 132
    object aOpenPage: TAction
      Caption = 'Open Page'
      Hint = 'Open Page under cursor'
      ImageIndex = 0
      OnExecute = Button1Click
    end
    object aFindParentPage: TAction
      Caption = 'Find Parent Page'
      Hint = 'Find Parent Page'
      ImageIndex = 1
      OnExecute = aFindParentPageExecute
    end
  end
end