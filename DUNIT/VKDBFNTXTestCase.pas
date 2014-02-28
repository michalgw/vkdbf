unit VKDBFNTXTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, VKDBFNTX, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFNTXTestThread = class(TThread)
  private
    dbf: TVKDBFNTX;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

  TVKDBFNTXTestCase = class(TTestCase)
  private
    dbf: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  public
    constructor Create(MethodName: string); override;
    destructor Destroy; override;
  published
    procedure TestFirst;
    procedure TestSecond;
  end;

  function RndStr: String;

implementation

{ TVKDBFNTXTestCase }

function RndStr: String;
var
s: array [0..49] of char;
  j: Integer;
  c: char;
begin
  for j := 0 to 49 do begin
    c := #0;
    while not ( (c in [#65..#90]) or
                (c in [#97..#122]) or
                (c in [#128..#175]) or
                (c in [#224..#241])
                ) do
      c := Chr(Byte(Trunc(Random(256))));
    s[j] := c;
  end;
  Result := s;
end;

procedure TVKDBFNTXTestCase.TestFirst;
var
  index: TVKNTXIndex;
begin
  dbf.Open;
  index := TVKNTXIndex(dbf.Indexes[0]);
  index.VerifyIndex;
  index := TVKNTXIndex(dbf.Indexes[1]);
  index.VerifyIndex;
  dbf.Close;
end;

procedure TVKDBFNTXTestCase.SetUp;
begin
  inherited SetUp;
end;

procedure TVKDBFNTXTestCase.TearDown;
begin
  inherited TearDown;
end;

procedure TVKDBFNTXTestCase.TestSecond;
var
  index: TVKNTXIndex;
  t1, t2, t3, t4: TVKDBFNTXTestThread;
begin
  t1 := TVKDBFNTXTestThread.Create(true);
  t2 := TVKDBFNTXTestThread.Create(true);
  t3 := TVKDBFNTXTestThread.Create(true);
  t4 := TVKDBFNTXTestThread.Create(true);
  try
    t1.Resume;
    t2.Resume;
    t3.Resume;
    t4.Resume;
    t1.WaitFor;
    t2.WaitFor;
    t3.WaitFor;
    t4.WaitFor;
    dbf.Open;
    index := TVKNTXIndex(dbf.Indexes[0]);
    index.VerifyIndex;
    index := TVKNTXIndex(dbf.Indexes[1]);
    index.VerifyIndex;
    dbf.Close;
  finally
    FreeAndNil(t1);
    FreeAndNil(t2);
    FreeAndNil(t3);
    FreeAndNil(t4);
  end;
end;

constructor TVKDBFNTXTestCase.Create(MethodName: string);
var
  index: TVKNTXIndex;
  fld: TVKDBFFieldDef;
  i: Integer;
begin
  inherited Create(MethodName);
  DeleteFile('tmp\ntxTest1.dbf');
  DeleteFile('tmp\ntxTest1_1.ntx');
  DeleteFile('tmp\ntxTest1_2.ntx');
  Randomize;
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\ntxTest1.dbf';
  dbf.OEM := true;
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F1';
  fld.field_type := 'N';
  fld.len := 9;
  fld := TVKDBFFieldDef(dbf.DBFFieldDefs.Add);
  fld.Name := 'F2';
  fld.field_type := 'C';
  fld.len := 50;
  dbf.CreateTable;
  dbf.AccessMode.AccessMode := 66;
  dbf.Open;
  for i := 1 to 100000 do begin
    dbf.Edit;
    dbf.FieldByName('F1').AsInteger := Round(Random(999999999));
    dbf.FieldByName('F2').AsString := RndStr;
    dbf.Insert;
  end;
  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\ntxTest1_1.ntx';
  index.KeyExpresion := 'F1';
  index.CreateIndex();
  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\ntxTest1_2.ntx';
  index.KeyExpresion := 'F2';
  index.CreateIndex();
  dbf.Close;
end;

destructor TVKDBFNTXTestCase.Destroy;
begin
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\ntxTest1.dbf');
      DeleteFile('tmp\ntxTest1_1.ntx');
      DeleteFile('tmp\ntxTest1_2.ntx');
    finally
      FreeAndNil(dbf);
    end;
  end;
  inherited;
end;

{ TVKDBFNTXTestThread }

constructor TVKDBFNTXTestThread.Create(CreateSuspended: Boolean);
var
  index: TVKNTXIndex;
begin
  inherited Create(CreateSuspended);
  Randomize;
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\ntxTest1.dbf';
  dbf.OEM := true;
  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\ntxTest1_1.ntx';
  index := TVKNTXIndex(dbf.Indexes.Add);
  index.NTXFileName := 'tmp\ntxTest1_2.ntx';
  dbf.AccessMode.AccessMode := 66;
  dbf.Open;
end;

destructor TVKDBFNTXTestThread.Destroy;
begin
  FreeAndNil(dbf);
  inherited Destroy;
end;

procedure TVKDBFNTXTestThread.Execute;
var
  i: Integer;
begin
  for i := 1 to 100000 do begin
    dbf.RecNo := Round(Random(100001));
    if dbf.RLock then begin
      try
        dbf.Edit;
        dbf.FieldByName('F1').AsInteger := Round(Random(999999999));
        dbf.FieldByName('F2').AsString := RndStr;
        dbf.Post;
      finally
        dbf.RUnLock;
      end;
    end;
  end;
end;

initialization

  TestFramework.RegisterTest(TVKDBFNTXTestCase.Suite);

end.
