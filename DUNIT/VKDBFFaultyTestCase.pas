unit VKDBFFaultyTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFFaultyTestCase = class(TTestCase)
  private
    dbf: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
  end;

implementation

{ TVKDBFFaultyTestCase }

procedure TVKDBFFaultyTestCase.TestFirst;
var
  memfile, memfile1: TMemoryStream;
  i: Integer;
begin

  memfile := TMemoryStream.Create;
  memfile1 := TMemoryStream.Create;
  memfile.LoadFromFile('faulty\eZakaz.xml');

  dbf.Insert;
  memfile.Position := 0;
  TBlobField(dbf.FieldByName('file')).LoadFromStream(memfile);
  dbf.Post;

  dbf.Edit;
  memfile.Position := 0;
  TBlobField(dbf.FieldByName('file')).LoadFromStream(memfile);
  dbf.Post;

  TBlobField(dbf.FieldByName('file')).SaveToStream(memfile1);

  Assert(memfile.Size = memfile1.Size);

  for i := 0 to Pred(memfile.Size) do
  begin
    Assert(pChar(memfile.Memory)[i] = pChar(memfile1.Memory)[i]);
  end;

end;

procedure TVKDBFFaultyTestCase.SetUp;
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
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\faulty.dbf';
  fh := FileOpen( 'faulty\password.txt',
                  fmOpenRead or fmShareDenyNone);
  l := FileSeek(fh, 0, 2);
  FileSeek(fh, 0, 0);
  FillChar(c, 1001, #0);
  FileRead(fh, c, l - 2);
  FileClose(fh);
  SetString(q, pChar(@c[0]), l - 2);
  dbf.Crypt.Password := q;
  dbf.Crypt.CryptMethod := cmGost;
  dbf.Crypt.Active := True;
  dbf.AccessMode.AccessMode := 18;
  dbf.Active := True;
end;

procedure TVKDBFFaultyTestCase.TearDown;
begin
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\faulty.dbf');
      DeleteFile('tmp\faulty.dbt');
    finally
      FreeAndNil(dbf);
    end;
  end;
  inherited TearDown;
end;

initialization

  TestFramework.RegisterTest(TVKDBFFaultyTestCase.Suite);

end.
