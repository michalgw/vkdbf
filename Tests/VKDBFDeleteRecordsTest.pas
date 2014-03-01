unit VKDBFDeleteRecordsTest;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFDeleteRecordsTestCase = class(TTestCase)
  private
    dbf1: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
    procedure TestSecond;
  end;

implementation

{ TVKDBFDeleteRecordsTestCase }

procedure TVKDBFDeleteRecordsTestCase.TestFirst;
var
  id: Integer;
begin
  dbf1.SetDeleted := false;
  dbf1.Locate('ID', 10, []);
  Assert(not dbf1.Deleted);
  id := dbf1.FieldByName('ID').AsInteger;
  Assert(id = 10);
  dbf1.Delete;
  id := dbf1.FieldByName('ID').AsInteger;
  Assert(id = 10);
  Assert(dbf1.Deleted);
end;

procedure TVKDBFDeleteRecordsTestCase.SetUp;
var
  fh: Integer;
  l: Integer;
  c: array[0..1000] of char;
  q: String;
begin
  inherited SetUp;
  CopyFile( 'faulty\faulty.dbf',
            'tmp\faulty.dbf', False);
  CopyFile( 'faulty\faulty.dbt',
            'tmp\faulty.dbt', False);
  dbf1 := TVKDBFNTX.Create(nil);
  dbf1.DBFFileName := 'tmp\faulty.dbf';
  fh := FileOpen( 'faulty\password.txt',
                  fmOpenRead or fmShareDenyNone);
  l := FileSeek(fh, 0, 2);
  FileSeek(fh, 0, 0);
  FillChar(c, 1001, #0);
  FileRead(fh, c, l - 2);
  FileClose(fh);
  SetString(q, pChar(@c[0]), l - 2);
  dbf1.Crypt.Password := q;
  dbf1.Crypt.CryptMethod := cmGost;
  dbf1.Crypt.Active := True;
  dbf1.AccessMode.AccessMode := 66;
  dbf1.Active := True;
end;

procedure TVKDBFDeleteRecordsTestCase.TearDown;
begin
  try
    if dbf1 <> nil then begin
      try
        if dbf1.Active then dbf1.Close;
      finally
        FreeAndNil(dbf1);
      end;
    end;
  finally
    DeleteFile('tmp\faulty.dbf');
    DeleteFile('tmp\faulty.dbt');
  end;
  inherited TearDown;
end;

procedure TVKDBFDeleteRecordsTestCase.TestSecond;
var
  id: Integer;
begin
  dbf1.SetDeleted := True;
  dbf1.Locate('ID', 10, []);
  Assert(not dbf1.Deleted);
  id := dbf1.FieldByName('ID').AsInteger;
  Assert(id = 10);
  dbf1.Delete;
  id := dbf1.FieldByName('ID').AsInteger;
  Assert(id = 11);
  Assert(not dbf1.Deleted);
end;

initialization

  TestFramework.RegisterTest(TVKDBFDeleteRecordsTestCase.Suite);

end.
