object BytesView: TBytesView
  Left = 3
  Top = 149
  Width = 798
  Height = 375
  Caption = 'BytesView'
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
  object Splitter1: TSplitter
    Left = 393
    Top = 29
    Width = 3
    Height = 295
    Cursor = crHSplit
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 324
    Width = 790
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 790
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 1
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 29
    Width = 393
    Height = 295
    Align = alLeft
    ColCount = 16
    DefaultColWidth = 23
    DefaultRowHeight = 23
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
    TabOrder = 2
    OnEnter = StringGrid1Enter
    OnExit = StringGrid1Exit
    OnSelectCell = StringGrid1SelectCell
  end
  object StringGrid2: TStringGrid
    Left = 396
    Top = 29
    Width = 394
    Height = 295
    Align = alClient
    ColCount = 16
    DefaultColWidth = 23
    DefaultRowHeight = 23
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
    TabOrder = 3
    OnEnter = StringGrid2Enter
    OnExit = StringGrid2Exit
  end
end
