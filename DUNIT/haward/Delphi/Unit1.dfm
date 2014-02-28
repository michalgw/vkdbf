object Form1: TForm1
  Left = 245
  Top = 114
  Width = 670
  Height = 511
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 148
    Top = 20
    Width = 28
    Height = 16
    Caption = 'Stop'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 269
    Width = 641
    Height = 243
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 434
    Top = 49
    Width = 93
    Height = 31
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 325
    Top = 10
    Width = 149
    Height = 24
    TabOrder = 2
    Text = '2'
  end
  object Memo1: TMemo
    Left = 0
    Top = 80
    Width = 641
    Height = 189
    Align = alBottom
    TabOrder = 3
  end
  object DBNavigator1: TDBNavigator
    Left = 128
    Top = 49
    Width = 290
    Height = 31
    DataSource = DataSource1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 496
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 530
    Top = 49
    Width = 93
    Height = 31
    Caption = #1057#1090#1072#1088#1090'1'
    TabOrder = 6
    OnClick = Button3Click
  end
  object db: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'test.dbf'
    AccessMode.AccessMode = 66
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = True
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 30000
    CreateNow = False
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 8
    Top = 40
    DBFFieldDefs = <
      item
        FieldFlag.FieldFlag = 14
        FieldFlag.System = False
        FieldFlag.CanStoreNull = True
        FieldFlag.BinaryColumn = True
        FieldFlag.AutoIncrement = True
        Name = 'ID'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 10
        dec = 0
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 14
        FieldFlag.System = False
        FieldFlag.CanStoreNull = True
        FieldFlag.BinaryColumn = True
        FieldFlag.AutoIncrement = True
        Name = 'TEXT'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 10
        dec = 0
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 14
        FieldFlag.System = False
        FieldFlag.CanStoreNull = True
        FieldFlag.BinaryColumn = True
        FieldFlag.AutoIncrement = True
        Name = 'TM'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 10
        dec = 0
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 14
        FieldFlag.System = False
        FieldFlag.CanStoreNull = True
        FieldFlag.BinaryColumn = True
        FieldFlag.AutoIncrement = True
        Name = 'NUM'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 10
        dec = 0
        Tag = 0
      end>
  end
  object DataSource1: TDataSource
    Left = 55
    Top = 40
  end
  object db1: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'S:\home\Programmers\HAWORD\test\log.dbf'
    AccessMode.AccessMode = 66
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = True
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 3000
    CreateNow = False
    DbfVersion = xBaseIII
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 56
    Top = 8
  end
end
