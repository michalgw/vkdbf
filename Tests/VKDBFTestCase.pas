unit VKDBFTestCase;

interface

uses TestFrameWork, Windows, VKDBFDataSet, Sysutils;

type

  TVKDBFTestCase = class(TTestCase)
  private
    dbf: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
  end;

implementation

procedure TVKDBFTestCase.SetUp;
var
  fld: TVKDBFFieldDef;
begin
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\test.dbf';
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F1';
  fld.field_type := 'C';
  fld.len := 100;
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F2';
  fld.field_type := 'N';
  fld.len := 10;
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F3';
  fld.field_type := 'N';
  fld.len := 13;
  fld.dec := 2;
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F4';
  fld.field_type := 'D';
  dbf.CreateTable;
end;

procedure TVKDBFTestCase.TearDown;
begin
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\test.dbf');
    finally
      FreeAndNil(dbf);
    end;
  end;
end;

procedure TVKDBFTestCase.TestFirst;
var
  i: Integer;
begin
  dbf.AccessMode.AccessMode := 66;
  dbf.Open;
  for i := 1 to 10000 do begin
    dbf.Insert;
    dbf.FieldByName('F1').AsString := 'Запись номер ' + IntToStr(i);
    dbf.FieldByName('F2').AsInteger := i;
    dbf.FieldByName('F3').AsFloat := i;
    dbf.FieldByName('F4').AsDateTime := now + i;
    dbf.Post;
  end;
  dbf.First;
  i := 10000;
  while not dbf.Eof do begin
    dbf.Edit;
    dbf.FieldByName('F1').AsString := 'Запись номер ' + IntToStr(i);
    dbf.FieldByName('F2').AsInteger := i;
    dbf.FieldByName('F3').AsFloat := i;
    dbf.FieldByName('F4').AsDateTime := now + i;
    dbf.Post;
    Dec(i);
    dbf.Next;
  end;
  dbf.Close;
end;

initialization

  TestFramework.RegisterTest(TVKDBFTestCase.Suite);

end.
