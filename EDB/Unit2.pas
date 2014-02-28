unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, Grids, DBGrids, Db, ActnList,
  StdCtrls, DBCtrls, ExtCtrls, Unit8, GrToExcel, ShellApi, VKDBFDataSet,
  DBTables, VKDBFSorters, VKDBFSortedList, VKDBFCrypt;

type

  qqq = class(TVKSortedObject)
  public
    v: Integer;
    function cpm(sObj: TVKSortedObject): Integer; override;
  end;

  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    One1: TMenuItem;
    One2: TMenuItem;
    DBGrid1: TDBGrid;
    dbfntx1: TVKDBFNTX;
    DataSource1: TDataSource;
    SetDeleted1: TMenuItem;
    Actions1: TMenuItem;
    GotoRecord1: TMenuItem;
    DBFHeader1: TMenuItem;
    DBFStructure1: TMenuItem;
    SetFilter1: TMenuItem;
    Orders1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    aOEM: TAction;
    aSetDeleted: TAction;
    aGoToR: TAction;
    aHeader: TAction;
    aStruct: TAction;
    aFilter: TAction;
    aOrders: TAction;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolBar2: TToolBar;
    FilterText: TComboBox;
    ToolButton5: TToolButton;
    ToolBar3: TToolBar;
    ToolButton6: TToolButton;
    aMasterDital: TAction;
    ToolButton7: TToolButton;
    N1: TMenuItem;
    MasterDital1: TMenuItem;
    aLocate: TAction;
    ToolButton8: TToolButton;
    aLocate1: TMenuItem;
    aOpenAttr: TAction;
    N2: TMenuItem;
    Openattributes1: TMenuItem;
    ToolButton9: TToolButton;
    ToolBar4: TToolBar;
    ToolButton10: TToolButton;
    aToExcel: TAction;
    N3: TMenuItem;
    GridToExcel1: TMenuItem;
    OpenDialog1: TOpenDialog;
    aClearFld: TAction;
    N4: TMenuItem;
    ClearfieldSetNullAltDel1: TMenuItem;
    PopupMenu1: TPopupMenu;
    aFileToLob: TAction;
    LoadfiletoLob1: TMenuItem;
    LoadfiletoLob2: TMenuItem;
    aLobToFile: TAction;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SavefilefromLOB1: TMenuItem;
    SavefilefromLOB2: TMenuItem;
    ClearfieldSetNullAltDel2: TMenuItem;
    aTruncate: TAction;
    N5: TMenuItem;
    TruncateZAP1: TMenuItem;
    N6: TMenuItem;
    TruncateZAP2: TMenuItem;
    N7: TMenuItem;
    DeleteRecallrecord1: TMenuItem;
    Pack1: TMenuItem;
    ReindexAll1: TMenuItem;
    aPack: TAction;
    Pack2: TMenuItem;
    aReindexAll: TAction;
    ReindexAll2: TMenuItem;
    N8: TMenuItem;
    aDelRecall: TAction;
    DeleteRecallrecord2: TMenuItem;
    ToolButton11: TToolButton;
    N9: TMenuItem;
    LockTable1: TMenuItem;
    UnlockTable1: TMenuItem;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    N10: TMenuItem;
    Lockrecord1: TMenuItem;
    Unlockrecord1: TMenuItem;
    procedure Unlockrecord1Click(Sender: TObject);
    procedure Lockrecord1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aOEMExecute(Sender: TObject);
    procedure aSetDeletedExecute(Sender: TObject);
    procedure dbfntx1AfterScroll(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aGoToRExecute(Sender: TObject);
    procedure aHeaderExecute(Sender: TObject);
    procedure aStructExecute(Sender: TObject);
    procedure aFilterExecute(Sender: TObject);
    procedure FilterTextChange(Sender: TObject);
    procedure DBGrid1ColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure aOrdersExecute(Sender: TObject);
    procedure aMasterDitalExecute(Sender: TObject);
    procedure aLocateExecute(Sender: TObject);
    procedure aOpenAttrExecute(Sender: TObject);
    procedure aToExcelExecute(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aClearFldExecute(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure aFileToLobExecute(Sender: TObject);
    procedure aLobToFileExecute(Sender: TObject);
    procedure aTruncateExecute(Sender: TObject);
    procedure aPackExecute(Sender: TObject);
    procedure aReindexAllExecute(Sender: TObject);
    procedure aDelRecallExecute(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure LockTable1Click(Sender: TObject);
    procedure UnlockTable1Click(Sender: TObject);
    procedure dbfntx1AfterOpen(DataSet: TDataSet);
    procedure ToolButton12Click(Sender: TObject);
    procedure tttt(Sender: TVKSortedListAbstract; SortedObject: TVKSortedObject);
    procedure ToolButton13Click(Sender: TObject);
  private
    { Private declarations }
    ColMoved: Boolean;
    oLocate: TForm8;
    function GetMasterSource: TDataSource;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; FileName: String); overload;
    constructor LoadFile(AOwner: TComponent; FileName: String);
    destructor Destroy; override;

    property MasterSource: TDataSource read GetMasterSource;

  end;

implementation

uses Unit1, GoToR, Unit3, Unit4, Unit5, Unit7, Unit9, Unit10, Unit11,
  Unit12, f_BLob, UnitBytesView;

{$R *.DFM}

{ TForm2 }

constructor TForm2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TForm2.Create(AOwner: TComponent; FileName: String);
begin
  Create(AOwner);
  oLocate := nil;
  Caption := FileName;
  DBFNTX1.DBFFileName := FileName;
  try
    DBFNTX1.Active := true;
  except
    on e: Exception do MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
  ColMoved := false;
  oLocate := TForm8.Create(self);
end;

constructor TForm2.LoadFile(AOwner: TComponent; FileName: String);
begin
  Create(AOwner);
  Caption := FileName;
  DBFNTX1.DBFFileName := FileName;
  ColMoved := false;
  oLocate := TForm8.Create(self);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.aOEMExecute(Sender: TObject);
begin
  DBFNTX1.OEM := not DBFNTX1.OEM;
  One2.Checked := DBFNTX1.OEM;
  DBFNTX1.Refresh;
end;

procedure TForm2.aSetDeletedExecute(Sender: TObject);
begin
  DBFNTX1.SetDeleted := not DBFNTX1.SetDeleted;
  SetDeleted1.Checked := DBFNTX1.SetDeleted;
  //DBFNTX1.Refresh;
end;

procedure TForm2.dbfntx1AfterScroll(DataSet: TDataSet);
var
  S: String;
begin
  S := '';
  if DBFNTX1.Deleted then S := 'Deleted';
  StatusBar1.Panels[0].Text := Format('%d / %d  %s', [DBFNTX1.RecNo, DBFNTX1.Last_Rec, S]);
end;

procedure TForm2.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  OldC: TColor;
begin
  if not (gdFocused in State) then
  begin
    {$B+}
    if DBFNTX1.Deleted then
    begin
      OldC := DBGrid1.Canvas.Brush.Color;
      DBGrid1.Canvas.Brush.Color := {cl3DLight}clInfoBk{clAqua};
      DBGrid1.Canvas.FillRect(Rect);
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      DBGrid1.Canvas.Brush.Color := OldC;
    end else
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    {$B-}
  end else
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm2.aGoToRExecute(Sender: TObject);
var
  oG: TGoToR;
begin
  oG := TGoToR.Create(self);
  try
    if oG.ShowModal = mrOk then
    begin
      if oG.NewRec <> -1 then
        DBFNTX1.RecNo := oG.NewRec;
        DBFNTX1.Refresh;
    end;
  finally
    oG.Destroy;
  end;
end;

procedure TForm2.aHeaderExecute(Sender: TObject);
var
  oO: TForm3;
begin
  oO := TForm3.Create(self);
  try
    oO.Caption := 'DBF Header';
    oO.Memo1.Lines.Clear;
    oO.Memo1.Lines.Add(Format('dbf_id: 0x%x', [DBFNTX1.Header.dbf_id]));
    oO.Memo1.Lines.Add(Format('last_update: (%d, %d, %d)', [DBFNTX1.Header.last_update[0], DBFNTX1.Header.last_update[1], DBFNTX1.Header.last_update[2]]));
    oO.Memo1.Lines.Add(Format('last_rec: %d', [DBFNTX1.Header.last_rec]));
    oO.Memo1.Lines.Add(Format('data_offset:  %d', [DBFNTX1.Header.data_offset]));
    oO.Memo1.Lines.Add(Format('rec_size: %d', [DBFNTX1.Header.rec_size]));
    oO.Memo1.Lines.Add(Format('TableFlag: %x', [DBFNTX1.Header.TableFlag]));
    oO.Memo1.Lines.Add(Format('CodePageMark: %x', [DBFNTX1.Header.CodePageMark]));
    oO.ShowModal;
  finally
    oO.Destroy;
  end;
end;

procedure TForm2.aStructExecute(Sender: TObject);
var
  oO: TForm3;
  i: Integer;
  qq: TVKDBFFieldDef;
begin
  oO := TForm3.Create(self);
  try
    oO.Caption := 'DBF Fields info';
    oO.Memo1.Lines.Clear;
    oO.Memo1.Lines.Add('      Name Type Length Prec   Offset    Extended Type');
    oO.Memo1.Lines.Add('---------- ---- ------ ---- --------  ---------------');
    for i := 0 to DBFNTX1.DBFFieldDefs.Count -1 do
    begin
      qq := DBFNTX1.DBFFieldDefs.Items[i];
      if qq.field_type <> 'E' then
        oO.Memo1.Lines.Add(Format('%10s%5s%7d%5d%9d%17s', [qq.Name, qq.field_type, qq.Len, qq.Dec, qq.Offset, '']))
      else
        oO.Memo1.Lines.Add(Format('%10s%5s%7d%5d%9d%17s', [qq.Name, qq.field_type, qq.Len, qq.Dec, qq.Offset, ExtType2Str(qq.extend_type)]));
    end;
    oO.ShowModal;
  finally
    oO.Free;
  end;
end;

procedure TForm2.aFilterExecute(Sender: TObject);
begin
  if FilterText.Items.IndexOf(FilterText.Text) = -1 then
    FilterText.Items.Insert(0, FilterText.Text);
  DBFNTX1.Filtered := false;
  if FilterText.Text <> '' then begin
    DBFNTX1.Filter := FilterText.Text;
    DBFNTX1.Filtered := true;
  end;
end;

procedure TForm2.FilterTextChange(Sender: TObject);
begin
  if FilterText.Text = '' then DBFNTX1.Filtered := false;
end;

procedure TForm2.DBGrid1ColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  ColMoved := true;
end;

procedure TForm2.DBGrid1TitleClick(Column: TColumn);
var
  oB: TBookmark;
  oGrid: TDBGrid;
  oDataSet: TDataSet;
  oField: TField;
  f: boolean;
  oFnd: TForm4;
begin
  if not ColMoved then
  begin
    if FilterText.Text <> '' then begin
      if FilterText.Items.IndexOf(FilterText.Text) = -1 then
        FilterText.Items.Insert(0, FilterText.Text);
      f := false;
      oGrid := Column.Grid as TDBGrid;
      oDataSet := oGrid.DataSource.DataSet;
      oFnd := TForm4.Create(self);
      oFnd.Show;
      oB := oDataSet.GetBookmark;
      oDataSet.DisableControls;
      try
        oDataSet.Next;
        oField := Column.Field;
        while not oDataSet.Eof do
        begin
          if Pos(FilterText.Text, oField.AsString) <> 0 then
          begin
            f := true;
            Break;
          end;
          oFnd.R := TVKDBFNTX(oDataSet).RecNo;
          if oFnd.Cancel then Break;
          oDataSet.Next;
        end;
        if not f then
        begin
          beep;
          oDataSet.GotoBookmark(oB);
        end;
      finally
        oFnd.Free;
        oDataSet.FreeBookmark(oB);
        oDataSet.EnableControls;
      end;
    end;
  end;
  ColMoved := false;
end;

procedure TForm2.aOrdersExecute(Sender: TObject);
var
  oO: TForm5;
begin
  oO := TForm5.Create(self);
  oO.ShowModal;
end;

procedure TForm2.aMasterDitalExecute(Sender: TObject);
var
  oM: TForm7;
begin
  oM := TForm7.Create(self);
  try
    oM.ShowModal;
  finally
    oM.Destroy;
  end;
end;

function TForm2.GetMasterSource: TDataSource;
begin
  if (DBFNTX1 <> nil) and DBFNTX1.Active then
    Result := TVKDBFNTX(DBFNTX1).DataSource
  else
    Result := nil;
end;

procedure TForm2.aLocateExecute(Sender: TObject);
begin
  oLocate.ShowModal;
end;

destructor TForm2.Destroy;
begin
  if oLocate <> nil then oLocate.Destroy;
  inherited Destroy;
end;

procedure TForm2.aOpenAttrExecute(Sender: TObject);
var
  oO: TForm9;
begin
  oO := TForm9.Create(self);
  try
    oO.FDBF := dbfntx1;
    oO.cActive.Checked := dbfntx1.Active;
    oO.eDbfFileName.text := dbfntx1.DBFFileName;
    oO.cRead.Checked := dbfntx1.AccessMode.OpenRead;
    oO.cReadWrite.Checked := dbfntx1.AccessMode.OpenReadWrite;
    oO.cWrite.Checked := dbfntx1.AccessMode.OpenWrite;
    oO.cDenyNone.Checked := dbfntx1.AccessMode.ShareDenyNone;
    {oO.cDenyRead.Checked := dbfntx1.AccessMode.ShareDenyRead;}
    oO.cDenyWrite.Checked := dbfntx1.AccessMode.ShareDenyWrite;
    oO.cExclusive.Checked := dbfntx1.AccessMode.ShareExclusive;
    oO.eWaitBusyRes.Text := IntToStr(dbfntx1.WaitBusyRes);
    oO.eBuffSize.Text := IntToStr(dbfntx1.BufferSize);
    oO.CryptActive.Checked := dbfntx1.Crypt.Active;
    if dbfntx1.Crypt.CryptMethod = cmXOR then
      oO.CryptMethod.Text := 'cmXOR'
    else
      if dbfntx1.Crypt.CryptMethod = cmGost then
        oO.CryptMethod.Text := 'cmGost'
      else
        if dbfntx1.Crypt.CryptMethod = cmGost1 then
          oO.CryptMethod.Text := 'cmGost1'
        else
          oO.CryptMethod.Text := 'cmNONE';
    oO.CryptPass.Text := dbfntx1.Crypt.Password;
    (*
    oO.CryptMethodChange(nil);
    oO.CryptActiveClick(nil);
    oO.CryptPassChange(nil);
    *)

    if dbfntx1.DbfVersion = xBaseIII then oO.dbfType.Text := 'xBaseIII';
    if dbfntx1.DbfVersion = xClipper then oO.dbfType.Text := 'xClipper';
    if dbfntx1.DbfVersion = xBaseIII then oO.dbfType.Text := 'xBaseIII';
    if dbfntx1.DbfVersion = xBaseIV then oO.dbfType.Text := 'xBaseIV';
    if dbfntx1.DbfVersion = xBaseV then oO.dbfType.Text := 'xBaseV';
    if dbfntx1.DbfVersion = xBaseVII then oO.dbfType.Text := 'xBaseVII';
    if dbfntx1.DbfVersion = xFoxPro then oO.dbfType.Text := 'xFoxPro';
    if dbfntx1.DbfVersion = xVisualFoxPro then oO.dbfType.Text := 'xVisualFoxPro';

    oO.LobPageSize.Text := IntToStr(dbfntx1.LobBlockSize);

    oO.LockProtocol.ItemIndex := -1;
    if dbfntx1.LockProtocol = lpNone then oO.LockProtocol.ItemIndex := 0;
    if dbfntx1.LockProtocol = lpDB4Lock then oO.LockProtocol.ItemIndex := 1;
    if dbfntx1.LockProtocol = lpClipperLock then oO.LockProtocol.ItemIndex := 2;
    if dbfntx1.LockProtocol = lpFoxLock then oO.LockProtocol.ItemIndex := 3;
    if dbfntx1.LockProtocol = lpClipperForFoxLob then oO.LockProtocol.ItemIndex := 4;

    oO.LobLockProtocol.ItemIndex := -1;
    if dbfntx1.LobLockProtocol = lpNone then oO.LobLockProtocol.ItemIndex := 0;
    if dbfntx1.LobLockProtocol = lpDB4Lock then oO.LobLockProtocol.ItemIndex := 1;
    if dbfntx1.LobLockProtocol = lpClipperLock then oO.LobLockProtocol.ItemIndex := 2;
    if dbfntx1.LobLockProtocol = lpFoxLock then oO.LobLockProtocol.ItemIndex := 3;
    if dbfntx1.LobLockProtocol = lpClipperForFoxLob then oO.LobLockProtocol.ItemIndex := 4;

    oO.HasGotIndex.Checked := False;
    oO.HasGotLOB.Checked := False;
    oO.ItIsTheDatabase.Checked := False;
    if dbfntx1.FoxTableFlag.HasGotIndex then oO.HasGotIndex.Checked := True;
    if dbfntx1.FoxTableFlag.HasGotMemo then oO.HasGotLOB.Checked := True;
    if dbfntx1.FoxTableFlag.ItIsDatabase then oO.ItIsTheDatabase.Checked := True;

    oO.ShowModal;
  finally
    oO.Free;
  end;
end;

procedure TForm2.aToExcelExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    GrToEx(DBGrid1, OpenDialog1.FileName);
    ShellExecute(self.Handle, Pchar('open'), pChar(OpenDialog1.FileName), Pchar('/n'), nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
var
  c: TForm12;
  oM10: TForm10;
  oM: TForm11;
  oB: TBlobView;
  oBV: TBytesView;
  Buffer: pChar;
  ii: Integer;
  BytesChange: boolean;
  bb: Byte;
begin
  if Column.Field.IsBlob then begin
    case TBlobField(Column.Field).BlobType of
      ftMemo:
        begin
          c := TForm12.Create(self);
          c.ShowModal;
          case c.Id of
            0:
              begin
                oM := TForm11.Create(self);
                oM.DataSource := DataSource1;
                oM.DataField := Column.Field.FieldName;
                oM.ShowModal;
                oM.Free;
              end;
            1:
              begin
                oM10 := TForm10.Create(self);
                oM10.DataSource := DataSource1;
                oM10.DataField := Column.Field.FieldName;
                oM10.ShowModal;
                oM10.Free;
              end;
          end;
          c.Free;
        end;
      ftBlob:
        begin
          oB := TBlobView.Create(self);
          oB.DataSource := DataSource1;
          oB.DataField := Column.Field.FieldName;
          oB.ShowModal;
          oB.Free;
        end;
    end;
  end;
  case Column.Field.DataType of
    ftBytes:
      begin
        oBV := TBytesView.Create(self);
        GetMem(Buffer, Column.Field.DataSize);
        Column.Field.GetData(Buffer);
        for ii := 0 to Pred(Column.Field.DataSize) do begin
          oBV.Add(Byte((Buffer + ii)^));
        end;
        oBV.ShowModal;
        BytesChange := False;
        for ii := 0 to Pred(Column.Field.DataSize) do begin
          bb := oBV.GetValue(ii);
          if bb <> Byte((Buffer + ii)^) then begin
            Byte((Buffer + ii)^) := bb;
            BytesChange := True;
          end;
        end;
        if BytesChange then begin
          DBFNTX1.Edit;
          Column.Field.SetData(Buffer);
          DBFNTX1.Post;
        end;
        FreeMem(Buffer);
        FreeAndNil(oBV);
      end;
  end;
end;

procedure TForm2.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( ssAlt in Shift ) and ( ( Key = VK_DELETE ) or ( Key = VK_BACK ) ) then begin
    aClearFldExecute(self);
  end;
end;

procedure TForm2.aClearFldExecute(Sender: TObject);
begin
  if DBFNTX1.IsCursorOpen then begin
    DBGrid1.DataSource.DataSet.Edit;
    DBGrid1.SelectedField.Clear;
    DBGrid1.DataSource.DataSet.Post;
  end;
end;

procedure TForm2.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if DBFNTX1.IsCursorOpen then begin
    if DBGrid1.SelectedField.IsNull then
      StatusBar1.Panels[1].Text := 'Null'
    else
      StatusBar1.Panels[1].Text := '';
  end;
end;

procedure TForm2.DBGrid1ColEnter(Sender: TObject);
begin
  if DBGrid1.SelectedField.IsNull then
    StatusBar1.Panels[1].Text := 'Null'
  else
    StatusBar1.Panels[1].Text := '';
end;

procedure TForm2.aFileToLobExecute(Sender: TObject);
begin
  if DBGrid1.SelectedField.IsBlob then begin
    if OpenDialog2.Execute then begin
      DBGrid1.DataSource.DataSet.Edit;
      TBlobField(DBGrid1.SelectedField).LoadFromFile(OpenDialog2.FileName);
      DBGrid1.DataSource.DataSet.Post;
    end;
  end;
end;

procedure TForm2.aLobToFileExecute(Sender: TObject);
begin
  if DBGrid1.SelectedField.IsBlob then begin
    if SaveDialog1.Execute then begin
      if DBGrid1.DataSource.DataSet.State in [dsEdit, dsInsert] then DBGrid1.DataSource.DataSet.Post;
      TBlobField(DBGrid1.SelectedField).SaveToFile(SaveDialog1.FileName);
    end;
  end;
end;

procedure TForm2.aTruncateExecute(Sender: TObject);
begin
  if MessageDlg('All records will be deleted from table. Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DBFNTX1.Truncate;
end;

procedure TForm2.aPackExecute(Sender: TObject);
begin
  if MessageDlg('All records marked as deleted will be remove from table. Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DBFNTX1.Pack;
end;

procedure TForm2.aReindexAllExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DBFNTX1.ReindexAll;
end;

procedure TForm2.aDelRecallExecute(Sender: TObject);
begin
  DBFNTX1.Deleted := not DBFNTX1.Deleted;
end;

procedure TForm2.ToolButton11Click(Sender: TObject);
var
  oB: TBookmark;
  oGrid: TDBGrid;
  oDataSet: TDataSet;
  oField: TField;
  //f: boolean;
  //oFnd: TForm4;
  val: Extended;
  S: String;
begin
    oGrid := DBGrid1;
    oField := oGrid.SelectedField;
    if oField is TNumericField then begin
      oDataSet := oGrid.DataSource.DataSet;
      oB := oDataSet.GetBookmark;
      oDataSet.DisableControls;
      try
        val := 0;
        oDataSet.First;
        while not oDataSet.Eof do
        begin
          val := val + oField.AsFloat;
          oDataSet.Next;
        end;
        Str(val:15:4, S);
        ShowMessage(S);
      finally
        oDataSet.FreeBookmark(oB);
        oDataSet.EnableControls;
      end;
    end;
end;

procedure TForm2.LockTable1Click(Sender: TObject);
begin
  //LockTable
  if not DBFNTX1.FileLock then begin
    if not DBFNTX1.FLock then raise Exception.Create('Table not locked!')
    else LockTable1.Checked := True;
  end;
end;

procedure TForm2.UnlockTable1Click(Sender: TObject);
begin
  //UnLockTable
  if DBFNTX1.FileLock then begin
    if not DBFNTX1.UnLock then raise Exception.Create('Table not unlocked!')
    else LockTable1.Checked := False;
  end;
end;

procedure TForm2.dbfntx1AfterOpen(DataSet: TDataSet);
begin
  LockTable1.Checked := DBFNTX1.FileLock;
end;

procedure TForm2.ToolButton12Click(Sender: TObject);
var
  l: TVKSortedList;
  o: qqq;
  i: Integer;
begin
  Randomize;
  l := TVKSortedList.Create;
  dbfntx1.DisableControls;

  dbfntx1.Zap;
  dbfntx1.BeginAddBuffered(1000);
  for i := 0 to 65535 do begin
    o := qqq.Create;
    o.v := i; //Random(81920);  //Random(MAXINT);
    dbfntx1.Append;
    dbfntx1.FieldByName('F1').AsInteger := o.v;
    dbfntx1.FieldByName('F2').AsInteger := Random(81920);
    dbfntx1.Post;
    l.Add(o);
  end;
  dbfntx1.EndAddBuffered;

  (*
  dbfntx1.First;
  while not dbfntx1.Eof do begin
    o := qqq.Create;
    o.v := dbfntx1['f1'];
    l.Add(o);
    dbfntx1.Next;
  end;
  *)
  ShowMessage(IntToStr(l.MaxLevel));

  //dbfntx1.First;
  //while not dbfntx1.Eof do begin
  //  o := qqq(l.Items[Pred(dbfntx1.RecNo)]);
  //  o.v := dbfntx1.FieldByName('F2').AsInteger;
  //  l.UpdateObjectInTree(o);
  //  dbfntx1.Next;
  //end;
  //ShowMessage(IntToStr(l.MaxLevel));

  for i := 0 to Pred(l.Count) do begin
    o := qqq(l.Items[i]);
    o.v := 65535 - o.v; //Random(81920);
    l.UpdateObjectInTree(o);
  end;
  ShowMessage(IntToStr(l.MaxLevel));

  l.OnTraversal := tttt;
  dbfntx1.First;
  l.Traversal;
  ShowMessage(IntToStr(l.MaxLevel));

  dbfntx1.EnableControls;
  dbfntx1.First;
  FreeAndNil(l);
end;

procedure TForm2.tttt(Sender: TVKSortedListAbstract;
  SortedObject: TVKSortedObject);
var
  v: Integer;
begin
  v := qqq(SortedObject).v;
  //ShowMessage(IntToStr(v));
  dbfntx1.edit;
  dbfntx1.FieldByName('F2').AsInteger := v;
  dbfntx1.Post;
  dbfntx1.Next;
end;

{ qqq }

function qqq.cpm(sObj: TVKSortedObject): Integer;
begin
  result := qqq(sObj).v - v;
end;

procedure TForm2.ToolButton13Click(Sender: TObject);
var
  i: Integer;
begin
  dbfntx1.First;
  for i := 0 to 200000 do begin
    //dbfntx1.DeleteRecord;
    //dbfntx1.RecallRecord;
    dbfntx1.Next;
  end;
end;

procedure TForm2.Lockrecord1Click(Sender: TObject);
begin
  dbfntx1.RLock;
end;

procedure TForm2.Unlockrecord1Click(Sender: TObject);
begin
  dbfntx1.RUnLock;
end;

end.
