unit VKDBFNextAfterSeekString;

interface

uses Windows, SysUtils, TestFrameWork, VKDBFDataSet, VKDBFNTX;

type
  TVKDBFNextAfterSeekString = class(TTestCase)
  private
    dbf: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
  end;

implementation

const
  ALPHABET: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  REP_COUNT: integer = 150;
  REC_SIZE: integer = 30;

{ TVKDBFNextAfterSeekString }

procedure TVKDBFNextAfterSeekString.TestFirst;
var
  i: Integer;
begin
  for i := 1 to Length(ALPHABET) do
    if not dbf.FindKey([StringOfChar(ALPHABET[i], REC_SIZE)]) then
      Assert(false, 'Ключ не найден: ' + StringOfChar(ALPHABET[i], REC_SIZE));
end;

procedure TVKDBFNextAfterSeekString.SetUp;
var
  index: TVKNTXIndex;
  fld: TVKDBFFieldDef;
  i: Integer;
  j: Integer;
begin
  inherited SetUp;

  DeleteFile('tmp\NextAfterSeekString.dbf');
  DeleteFile('tmp\NextAfterSeekString.ntx');

  Randomize;

  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\NextAfterSeekString.dbf';
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F1';
  fld.field_type := 'C';
  fld.len := 128;
  dbf.CreateTable;
  dbf.AccessMode.AccessMode := 66;

  dbf.Open;

  for j := 1 to REP_COUNT do
    begin
      for i := 1 to Length(ALPHABET) do
        begin
          dbf.Insert;
          dbf.FieldByName('F1').AsString := StringOfChar(ALPHABET[i], REC_SIZE);
          dbf.Post;
       end;
    end;

  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\NextAfterSeekString.ntx';
  index.KeyExpresion := 'F1';
  index.CreateIndex();
end;

procedure TVKDBFNextAfterSeekString.TearDown;
begin
  inherited TearDown;
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\NextAfterSeekString.dbf');
      DeleteFile('tmp\NextAfterSeekString.ntx');
    finally
      FreeAndNil(dbf);
    end;
  end;
end;

initialization

  TestFramework.RegisterTest(TVKDBFNextAfterSeekString.Suite);

end.
