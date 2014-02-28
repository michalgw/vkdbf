object Form5: TForm5
  Left = 38
  Top = 15
  Width = 744
  Height = 690
  Caption = 'Orders'
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
    Left = 8
    Top = 524
    Width = 149
    Height = 16
    Caption = 'Hash type for tree sorters'
  end
  object Label2: TLabel
    Left = 400
    Top = 524
    Width = 128
    Height = 16
    Caption = 'Max bits in hash code'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 576
    Width = 725
    Height = 4
  end
  object Bevel2: TBevel
    Left = 8
    Top = 612
    Width = 725
    Height = 4
  end
  object Label3: TLabel
    Left = 232
    Top = 324
    Width = 7
    Height = 16
    Caption = '3'
  end
  object ListView1: TListView
    Left = 13
    Top = 4
    Width = 708
    Height = 301
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        AutoSize = True
        Caption = 'Key Expression'
      end>
    HideSelection = False
    Items.Data = {
      4B0000000200000000000000FFFFFFFFFFFFFFFF000000000000000016506879
      736963616C206F7264657220287265636E6F2900000000FFFFFFFFFFFFFFFF00
      0000000000000003757575}
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = ListView1DblClick
    OnSelectItem = ListView1SelectItem
  end
  object Button1: TButton
    Left = 30
    Top = 320
    Width = 93
    Height = 31
    Caption = 'Add'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 489
    Top = 320
    Width = 139
    Height = 31
    Caption = 'Properties'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 621
    Top = 370
    Width = 93
    Height = 30
    Caption = 'Ok'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button2: TButton
    Left = 134
    Top = 320
    Width = 92
    Height = 31
    Caption = 'New'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 297
    Top = 320
    Width = 93
    Height = 31
    Caption = 'Reindex'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 134
    Top = 356
    Width = 105
    Height = 29
    Caption = 'New Compact'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 30
    Top = 356
    Width = 92
    Height = 30
    Caption = 'Delete'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 136
    Top = 392
    Width = 297
    Height = 25
    Caption = 'New Index using RAM and "QuickSort" algorithm'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 429
    Width = 341
    Height = 25
    Caption = 'New Index using RAM and Binary Tree Sort algorithm'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 8
    Top = 457
    Width = 421
    Height = 25
    Caption = 'New Index using RAM and Red/Black Binary Tree Sort algorithm'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 8
    Top = 485
    Width = 421
    Height = 25
    Caption = 'New Index using RAM and AVL-Tree Sort algorithm'
    TabOrder = 11
    OnClick = Button11Click
  end
  object ComboBox1: TComboBox
    Left = 172
    Top = 520
    Width = 209
    Height = 24
    ItemHeight = 16
    TabOrder = 12
    Text = 'httsDefault'
    Items.Strings = (
      'httsDefault'
      'htts2048'
      'htts4096'
      'htts8192'
      'htts16384'
      'htts32768'
      'htts65536'
      'htts131072'
      'htts262144'
      'htts524288')
  end
  object ComboBox2: TComboBox
    Left = 536
    Top = 520
    Width = 145
    Height = 24
    ItemHeight = 16
    TabOrder = 13
    Text = 'mbhc32'
    Items.Strings = (
      'mbhc0'
      'mbhc1'
      'mbhc2'
      'mbhc3'
      'mbhc4'
      'mbhc5'
      'mbhc6'
      'mbhc7'
      'mbhc8'
      'mbhc9'
      'mbhc10'
      'mbhc11'
      'mbhc12'
      'mbhc13'
      'mbhc14'
      'mbhc15'
      'mbhc16'
      'mbhc17'
      'mbhc18'
      'mbhc19'
      'mbhc20'
      'mbhc21'
      'mbhc22'
      'mbhc23'
      'mbhc24'
      'mbhc25'
      'mbhc26'
      'mbhc27'
      'mbhc28'
      'mbhc29'
      'mbhc30'
      'mbhc31'
      'mbhc32')
  end
  object Button16: TButton
    Left = 460
    Top = 484
    Width = 177
    Height = 25
    Caption = 'Trie Tree Sort'
    TabOrder = 14
    OnClick = Button16Click
  end
  object Button12: TButton
    Left = 8
    Top = 624
    Width = 133
    Height = 25
    Caption = '2 Path Merge sort'
    TabOrder = 15
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 156
    Top = 624
    Width = 133
    Height = 25
    Caption = '4 Path Merge sort'
    TabOrder = 16
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 296
    Top = 624
    Width = 141
    Height = 25
    Caption = '8 Path Merge sort'
    TabOrder = 17
    OnClick = Button14Click
  end
  object OD: TOpenDialog
    Filter = 'Clipper Index Files|*.NTX'
    Options = []
    Top = 294
  end
end
