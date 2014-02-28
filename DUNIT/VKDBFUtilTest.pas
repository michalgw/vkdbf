unit VKDBFUtilTest;

interface

uses TestFrameWork, Windows, VKDBFDataSet, Sysutils, VKDBFUtil;

type

  TVKDBFUtilTestCase = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestInt2Str;
  end;

implementation

procedure TVKDBFUtilTestCase.SetUp;
begin
end;

procedure TVKDBFUtilTestCase.TearDown;
begin
end;

procedure TVKDBFUtilTestCase.TestInt2Str;
var
  s: AnsiString;
begin
  Int2Str(-2147483647, 30,  s);
  CheckEquals('-00000000000000000002147483647', s);
  Int2Str(-1234567, 30,  s);
  CheckEquals('-00000000000000000000001234567', s);
  Int2Str(-1, 30,  s);
  CheckEquals('-00000000000000000000000000001', s);
  Int2Str(0, 30,  s);
  CheckEquals('000000000000000000000000000000', s);
  Int2Str(1, 30,  s);
  CheckEquals('000000000000000000000000000001', s);
  Int2Str(1234567, 30,  s);
  CheckEquals('000000000000000000000001234567', s);
  Int2Str(2147483647, 30,  s);
  CheckEquals('000000000000000000002147483647', s);
  Int2Str(4294967295, 30,  s);
  CheckEquals('-00000000000000000000000000001', s);
end;

initialization

  TestFramework.RegisterTest(TVKDBFUtilTestCase.Suite);

end.
