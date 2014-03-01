unit VKDBFCommaNumberTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFCommaNumberTestCase = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
  end;

implementation

{ TVKDBFCommaNumberTestCase }

procedure TVKDBFCommaNumberTestCase.TestFirst;
var
  dbf1: TVKDBFNTX;
  Separator: Char;
begin
  // in dbf data in field: '1,05'  '2.03'
  Separator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  dbf1 := TVKDBFNTX.Create(nil);
  try
    dbf1.DBFFileName := 'CommaNumber\CommaNumber.dbf';
    dbf1.Open;
    Assert(dbf1.FieldByName('CN').AsString = '1.05');
    dbf1.Next;
    Assert(dbf1.FieldByName('CN').AsString = '2.03');
    dbf1.Close;
  finally
    FormatSettings.DecimalSeparator := Separator;
    FreeAndNil(dbf1);
  end;
end;

procedure TVKDBFCommaNumberTestCase.SetUp;
begin
  inherited;
end;

procedure TVKDBFCommaNumberTestCase.TearDown;
begin
  inherited;
end;

initialization

  TestFramework.RegisterTest(TVKDBFCommaNumberTestCase.Suite);

end.
