unit VKDBFLockTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFLockTestCase = class(TTestCase)
  private
    dbf1: TVKDBFNTX;
    dbf2: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
    procedure TestSecond;
    procedure TestThird;
    procedure TestFourth;
    procedure TestFifth;
    procedure TestSixth;
  end;

implementation

{ TVKDBFFaultyTestCase }

procedure TVKDBFLockTestCase.TestFirst;
begin

  dbf1.First;
  dbf2.First;

  dbf1.RLock;
  try
    Assert(dbf2.IsRLock);
  finally
    dbf1.UnLock;
    Assert(not dbf2.IsRLock);
  end;

end;

procedure TVKDBFLockTestCase.TestSecond;
begin

  dbf1.First;
  dbf2.First;

  Assert(dbf1.RLock(dbf1.recNo));
  try
    Assert(not dbf2.RLock(dbf2.RecNo));
  finally
    dbf1.UnLock;
    Assert(dbf2.RLock(dbf2.RecNo));
    try
      Assert(not dbf1.RLock(dbf1.RecNo));
    finally
      dbf2.UnLock;
    end;
  end;

end;

procedure TVKDBFLockTestCase.TestThird;
begin

  dbf1.First;
  dbf2.First;

  Assert(dbf1.RLock(dbf1.recNo));
  try
    Assert(dbf1.FieldByName('STATUS').AsInteger = -1);
    dbf1.Edit;
    dbf1.FieldByName('STATUS').AsInteger := 100;
    dbf1.Post;
  finally
    dbf1.UnLock;
  end;

  Assert(dbf2.RLock(dbf2.recNo));
  try
    Assert(dbf2.FieldByName('STATUS').AsInteger = 100);
    dbf2.Edit;
    dbf2.FieldByName('STATUS').AsInteger := 200;
    dbf2.Post;
  finally
    dbf2.UnLock;
  end;

  Assert(dbf1.FieldByName('STATUS').AsInteger = 100);
  Assert(dbf2.FieldByName('STATUS').AsInteger = 200);

  dbf1.Refresh;
  Assert(dbf1.FieldByName('STATUS').AsInteger = 200);

end;

procedure TVKDBFLockTestCase.TestFourth;
begin

  dbf1.First;
  dbf2.First;

  Assert(dbf1.FLock());
  try
    while not dbf1.Eof do begin
      dbf1.Edit;
      dbf1.FieldByName('STATUS').AsInteger := 300;
      dbf1.Post;
      dbf1.Next;
    end;
  finally
    dbf1.UnLock;
  end;

  Assert(dbf2.FLock());
  try
    while not dbf2.Eof do begin
      Assert(dbf2.FieldByName('STATUS').AsInteger = 300);
      dbf2.Edit;
      dbf2.FieldByName('STATUS').AsInteger := 400;
      dbf2.Post;
      dbf2.Next;
    end;
  finally
    dbf2.UnLock;
  end;

  Assert(dbf1.FieldByName('STATUS').AsInteger = 300);
  Assert(dbf2.FieldByName('STATUS').AsInteger = 400);

  dbf1.Refresh;
  Assert(dbf1.FieldByName('STATUS').AsInteger = 400);

end;

procedure TVKDBFLockTestCase.TestFifth;
begin

  dbf1.First;

  dbf2.Filter := 'STATUS <> 1000';
  dbf2.Filtered := True;
  dbf2.First;

  Assert(dbf1.RLock(dbf1.recNo));
  try
    dbf1.Edit;
    dbf1.FieldByName('STATUS').AsInteger := 1000;
    dbf1.Post;
  finally
    dbf1.UnLock;
  end;

  Assert(dbf2.RLock(dbf2.recNo));
  try
    // RLock update record, but it change not reflected in any filters or ranges.
    Assert(dbf2.FieldByName('STATUS').AsInteger = 1000);
    dbf2.Edit;
    dbf2.FieldByName('STATUS').AsInteger := 2000;
    dbf2.Post;
  finally
    dbf2.UnLock;
  end;

  Assert(dbf1.FieldByName('STATUS').AsInteger = 1000);
  Assert(dbf2.FieldByName('STATUS').AsInteger = 2000);

  dbf1.Refresh;
  Assert(dbf1.FieldByName('STATUS').AsInteger = 2000);

end;

procedure TVKDBFLockTestCase.TestSixth;
begin

  dbf1.First;

  dbf2.Filter := 'STATUS <> 3000';
  dbf2.Filtered := True;
  dbf2.First;

  Assert(dbf1.FLock());
  try
    while not dbf1.Eof do begin
      dbf1.Edit;
      dbf1.FieldByName('STATUS').AsInteger := 3000;
      dbf1.Post;
      dbf1.Next;
    end;
  finally
    dbf1.UnLock;
  end;

  Assert(dbf2.FLock());
  try
    // FLock update record buffer, and it change reflected in any filters or ranges.
    while not dbf2.Eof do begin
      dbf2.Edit;
      dbf2.FieldByName('STATUS').AsInteger := 4000;
      dbf2.Post;
      dbf2.Next;
    end;
  finally
    dbf2.UnLock;
  end;

  Assert(dbf1.FieldByName('STATUS').AsInteger = 3000);
  Assert(dbf2.Eof);

  dbf1.First;
  dbf2.Filtered := False;
  dbf2.First;

  Assert(dbf1.FieldByName('STATUS').AsInteger = 3000);
  Assert(dbf2.FieldByName('STATUS').AsInteger = 3000);

end;

procedure TVKDBFLockTestCase.SetUp;
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
  dbf2 := TVKDBFNTX.Create(nil);
  dbf2.DBFFileName := 'tmp\faulty.dbf';
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
  dbf2.Crypt.Password := q;
  dbf2.Crypt.CryptMethod := cmGost;
  dbf2.Crypt.Active := True;
  dbf2.AccessMode.AccessMode := 66;
  dbf2.Active := True;
end;

procedure TVKDBFLockTestCase.TearDown;
begin
  try
    if dbf2 <> nil then begin
      try
        if dbf2.Active then dbf2.Close;
      finally
        FreeAndNil(dbf2);
      end;
    end;
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

initialization

  TestFramework.RegisterTest(TVKDBFLockTestCase.Suite);

end.
