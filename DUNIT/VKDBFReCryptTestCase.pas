unit VKDBFReCryptTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, VKDBFIndex, VKDBFNTX, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFReCryptTestCase = class(TTestCase)
  private
    empty0: TVKDBFNTX;
    empty1: TVKDBFNTX;
    dbf: TVKDBFNTX;
    dbf_original: TVKDBFNTX;
    sessions: TVKDBFNTX;
    sessions_original: TVKDBFNTX;
    nested: TVKDBFNTX;
    nested_original: TVKDBFNTX;
    procedure CompareTwoDBF(dbf_file, dbf_file_original: TDataSet);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFirst;
    procedure TestSecond;
    procedure TestThird;
    procedure TestFifth;
  end;

implementation

{ TVKDBFReCryptTestCase }

procedure TVKDBFReCryptTestCase.TestFirst;
var
  pNewCrypt: TVKDBFCrypt;
begin
  pNewCrypt := TVKDBFCrypt.Create;
  pNewCrypt.CryptMethod := cmGost;
  pNewCrypt.Password := 'New password';
  pNewCrypt.Active := True;
  //
  dbf.ReCrypt(pNewCrypt);
  //
  CompareTwoDBF(dbf, dbf_original);
  //
end;

procedure TVKDBFReCryptTestCase.SetUp;
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
  CopyFile( 'faulty\id.ntx',
            'tmp\id.ntx', False);
  CopyFile( 'faulty\s_idx.ntx',
            'tmp\s_idx.ntx', False);
  CopyFile( 'faulty\date.ntx',
            'tmp\date.ntx', False);
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\faulty.dbf';
  with dbf.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'tmp\id.ntx';
  end;
  with dbf.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'tmp\s_idx.ntx';
  end;
  with dbf.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'tmp\date.ntx';
  end;
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
  //
  dbf_original := TVKDBFNTX.Create(nil);
  dbf_original.DBFFileName := 'faulty\faulty.dbf';
  dbf_original.Crypt.Password := q;
  dbf_original.Crypt.CryptMethod := cmGost;
  dbf_original.Crypt.Active := True;
  dbf_original.AccessMode.AccessMode := 18;
  dbf_original.Active := True;
  //
  //
  CopyFile( 'SetRange\sessions.dbf',
            'tmp\sessions.dbf', False);
  sessions := TVKDBFNTX.Create(nil);
  sessions.DBFFileName := 'tmp\sessions.dbf';
  fh := FileOpen( 'SetRange\password.txt',
                  fmOpenRead or fmShareDenyNone);
  l := FileSeek(fh, 0, 2);
  FileSeek(fh, 0, 0);
  FillChar(c, 1001, #0);
  FileRead(fh, c, l - 2);
  FileClose(fh);
  SetString(q, pChar(@c[0]), l - 2);
  sessions.Crypt.Password := q;
  sessions.Crypt.CryptMethod := cmGost;
  sessions.Crypt.Active := True;
  sessions.AccessMode.AccessMode := 18;
  sessions.Active := True;
  //
  sessions_original := TVKDBFNTX.Create(nil);
  sessions_original.DBFFileName := 'SetRange\sessions.dbf';
  sessions_original.Crypt.Password := q;
  sessions_original.Crypt.CryptMethod := cmGost;
  sessions_original.Crypt.Active := True;
  sessions_original.AccessMode.AccessMode := 18;
  sessions_original.Active := True;
  //
  CopyFile( 'SimpleNestedTable\test.dbf',
            'tmp\test.dbf', False);
  CopyFile( 'SimpleNestedTable\test.dbt',
            'tmp\test.dbt', False);
  CopyFile( 'SimpleNestedTable\test.ntx',
            'tmp\test.ntx', False);
  nested := TVKDBFNTX.Create(nil);
  nested.DBFFileName := 'tmp\test.dbf';
  with nested.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'tmp\test.ntx';
  end;
  nested.AccessMode.AccessMode := 18;
  nested.Active := True;
  //
  nested_original := TVKDBFNTX.Create(nil);
  nested_original.DBFFileName := 'SimpleNestedTable\test.dbf';
  with nested_original.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'SimpleNestedTable\test.ntx';
  end;
  nested_original.AccessMode.AccessMode := 18;
  nested_original.Active := True;
  //
  CopyFile( 'EmptyTable\empty0.dbf',
            'tmp\empty0.dbf', False);
  CopyFile( 'EmptyTable\empty0.dbt',
            'tmp\empty0.dbt', False);
  CopyFile( 'EmptyTable\empty1.dbf',
            'tmp\empty1.dbf', False);
  CopyFile( 'EmptyTable\empty1.dbt',
            'tmp\empty1.dbt', False);
  empty0 := TVKDBFNTX.Create(nil);
  empty0.DBFFileName := 'tmp\empty0.dbf';
  empty0.AccessMode.AccessMode := 66;
  empty0.Active := True;
  empty1 := TVKDBFNTX.Create(nil);
  empty1.DBFFileName := 'tmp\empty1.dbf';
  empty1.AccessMode.AccessMode := 66;
  empty1.Active := True;
  //

end;

procedure TVKDBFReCryptTestCase.TearDown;
begin
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\faulty.dbf');
      DeleteFile('tmp\faulty.dbt');
      DeleteFile('tmp\id.ntx');
      DeleteFile('tmp\s_idx.ntx');
      DeleteFile('tmp\date.ntx');
    finally
      FreeAndNil(dbf);
    end;
  end;
  //
  if dbf_original <> nil then begin
    try
      if dbf_original.Active then dbf_original.Close;
    finally
      FreeAndNil(dbf_original);
    end;
  end;
  //
  //
  if sessions <> nil then begin
    try
      if sessions.Active then sessions.Close;
      DeleteFile('tmp\sessions.dbf');
    finally
      FreeAndNil(sessions);
    end;
  end;
  //
  if sessions_original <> nil then begin
    try
      if sessions_original.Active then sessions_original.Close;
    finally
      FreeAndNil(sessions_original);
    end;
  end;
  //
  if nested <> nil then begin
    try
      if nested.Active then nested.Close;
      DeleteFile('tmp\test.dbf');
      DeleteFile('tmp\test.dbt');
      DeleteFile('tmp\test.ntx');
    finally
      FreeAndNil(nested);
    end;
  end;
  //
  if nested_original <> nil then begin
    try
      if nested_original.Active then nested_original.Close;
    finally
      FreeAndNil(nested_original);
    end;
  end;
  //
  if empty0 <> nil then begin
    try
      if empty0.Active then empty0.Close;
      DeleteFile('tmp\empty0.dbf');
      DeleteFile('tmp\empty0.dbt');
    finally
      FreeAndNil(empty0);
    end;
  end;
  if empty1 <> nil then begin
    try
      if empty1.Active then empty1.Close;
      DeleteFile('tmp\empty1.dbf');
      DeleteFile('tmp\empty1.dbt');
    finally
      FreeAndNil(empty1);
    end;
  end;
  //
  inherited TearDown;
end;

procedure TVKDBFReCryptTestCase.TestSecond;
var
  pNewCrypt: TVKDBFCrypt;
begin
  pNewCrypt := TVKDBFCrypt.Create;
  pNewCrypt.CryptMethod := cmGost;
  pNewCrypt.Password := 'New password';
  pNewCrypt.Active := True;
  //
  sessions.ReCrypt(pNewCrypt);
  //
  CompareTwoDBF(sessions, sessions_original);
  //
end;

procedure TVKDBFReCryptTestCase.CompareTwoDBF(dbf_file, dbf_file_original: TDataSet);
var
  i: Integer;
  NstDSet: TVKNestedDBF;
  DataSetFld: TDataSetField;
  NstDSet1: TVKNestedDBF;
  DataSetFld1: TDataSetField;
begin
  //
  dbf_file.First;
  dbf_file_original.First;
  while not dbf_file.Eof do
  begin
    for i := 0 to pred(dbf_file.Fields.Count) do
    begin
      if dbf_file.Fields[i].DataType = ftDataSet then begin
        DataSetFld := TDataSetField(dbf_file.Fields[i]);
        DataSetFld1 := TDataSetField(dbf_file_original.Fields[i]);
        if not DataSetFld.IsNull then begin
          NstDSet := TVKNestedDBF(DataSetFld.NestedDataSet);
          NstDSet.Open;
          NstDSet1 := TVKNestedDBF(DataSetFld1.NestedDataSet);
          NstDSet1.Open;
          CompareTwoDBF(NstDSet, NstDSet);
          NstDSet.Close;
          NstDSet1.Close;
          FreeAndNil(NstDSet);
          FreeAndNil(NstDSet1);
        end else
          Assert(DataSetFld.IsNull and DataSetFld1.IsNull, 'Оба поля должны быть nil!');
      end else
        Assert(dbf_file.Fields[i].Value = dbf_file_original.Fields[i].Value, 'Поля ' + dbf_file.Fields[i].Name + ' не совпадают!');
    end;
    dbf_file.Next;
    dbf_file_original.Next;
  end;
end;

procedure TVKDBFReCryptTestCase.TestThird;
var
  pNewCrypt: TVKDBFCrypt;
begin
  pNewCrypt := TVKDBFCrypt.Create;
  pNewCrypt.CryptMethod := cmGost;
  pNewCrypt.Password := 'New password';
  pNewCrypt.Active := True;
  //
  nested.ReCrypt(pNewCrypt);
  //
  CompareTwoDBF(nested, nested_original);
  //
end;

procedure TVKDBFReCryptTestCase.TestFifth;
var
  pNewCrypt: TVKDBFCrypt;
begin
  pNewCrypt := TVKDBFCrypt.Create;
  pNewCrypt.CryptMethod := cmGost;
  pNewCrypt.Password := 'New password';
  pNewCrypt.Active := True;
  //
  empty0.ReCrypt(pNewCrypt);
  empty1.ReCrypt(pNewCrypt);
  //
  CompareTwoDBF(empty0, empty0);
  CompareTwoDBF(empty1, empty1);
  //
end;

initialization

  TestFramework.RegisterTest(TVKDBFReCryptTestCase.Suite);

end.

