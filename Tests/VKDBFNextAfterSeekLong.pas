unit VKDBFNextAfterSeekLong;

interface

uses TestFrameWork, Windows, VKDBFDataSet, VKDBFNTX, Sysutils;

type

  TVKDBFNextAfterSeekLong = class(TTestCase)
  private
    dbf: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
  end;

implementation

{ TVKDBFNextAfterSeekLong }

procedure TVKDBFNextAfterSeekLong.TestFirst;
var
  i: Integer;
begin
  for i := 1 to 999 do begin
    if dbf.FindKey([i]) then begin
      dbf.Next;
      Assert(dbf.FieldByName('F1').AsInteger = i + 1, '���� �� ������: ' + IntToStr(i));
      dbf.Next;
    end else
      Assert(false, '���� �� ������: ' + IntToStr(i));
  end;
end;

procedure TVKDBFNextAfterSeekLong.SetUp;
var
  index: TVKNTXIndex;
  fld: TVKDBFFieldDef;
  i, r: Integer;
begin
  inherited SetUp;
  DeleteFile('tmp\NextAfterSeekLong.dbf');
  DeleteFile('tmp\NextAfterSeekLong.ntx');
  Randomize;
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\NextAfterSeekLong.dbf';
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F1';
  fld.field_type := 'N';
  fld.len := 10;
  dbf.CreateTable;
  dbf.AccessMode.AccessMode := 66;
  dbf.Open;
  for i := 1 to 10000 do begin
    dbf.Insert;
    dbf.Post;
  end;
  for i := 1 to 10000 do begin
    r := Round(Random(10001));
    dbf.RecNo := r;
    while (not dbf.FieldByName('F1').IsNull) and (not dbf.Eof) do dbf.Next;
    if dbf.Eof then begin
      dbf.RecNo := r;
      while (not dbf.FieldByName('F1').IsNull) and (not dbf.Bof) do dbf.Prior;
    end;
    if (not dbf.Eof) and (not dbf.Eof) and dbf.FieldByName('F1').IsNull then begin
      dbf.Edit;
      dbf.FieldByName('F1').AsInteger := i;
      dbf.Post;
    end;
  end;
  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\NextAfterSeekLong.ntx';
  index.KeyExpresion := 'F1';
  index.CreateIndex();
end;

procedure TVKDBFNextAfterSeekLong.TearDown;
begin
  inherited TearDown;
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\NextAfterSeekLong.dbf');
      DeleteFile('tmp\NextAfterSeekLong.ntx');
    finally
      FreeAndNil(dbf);
    end;
  end;
end;

initialization

  TestFramework.RegisterTest(TVKDBFNextAfterSeekLong.Suite);

end.
