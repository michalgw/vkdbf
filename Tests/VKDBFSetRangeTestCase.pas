unit VKDBFSetRangeTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, VKDBFIndex, VKDBFNTX, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFSetRangeTestCase = class(TTestCase)
  private
    dbf: TVKDBFNTX;
    faulty: TVKDBFNTX;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetRange1;
    procedure TestSetRange2;
  end;

implementation

{ TVKDBFSetRangeTestCase }

procedure TVKDBFSetRangeTestCase.SetUp;
var
  fh: Integer;
  l: Integer;
  c: array[0..1000] of AnsiChar;
  q: AnsiString;
  ntx: TVKNTXIndex;
begin
  inherited SetUp;
  CopyFile( 'SetRange\sessions.dbf',
            'tmp\sessions.dbf', False);
  CopyFile( 'SetRange\sess_s_idx.ntx',
            'tmp\sess_s_idx.ntx', False);
  CopyFile( 'SetRange\zak_status.ntx',
            'tmp\zak_status.ntx', False);
  dbf := TVKDBFNTX.Create(nil);
  dbf.DBFFileName := 'tmp\sessions.dbf';
  ntx := TVKNTXIndex(dbf.Indexes.Add);
  ntx.NTXFileName := 'tmp\sess_s_idx.ntx';
  ntx := TVKNTXIndex(dbf.Indexes.Add);
  ntx.NTXFileName := 'tmp\zak_status.ntx';
  fh := FileOpen( 'SetRange\password.txt',
                  fmOpenRead or fmShareDenyNone);
  l := FileSeek(fh, 0, 2);
  FileSeek(fh, 0, 0);
  FillChar(c, 1001, #0);
  FileRead(fh, c, l - 2);
  FileClose(fh);
  SetString(q, PAnsiChar(@c[0]), l - 2);
  dbf.Crypt.Password := q;
  dbf.Crypt.CryptMethod := cmGost;
  dbf.Crypt.Active := True;
  dbf.AccessMode.AccessMode := 18;
  dbf.Active := True;
  //
  //
  faulty := TVKDBFNTX.Create(nil);
  faulty.DBFFileName := 'faulty\faulty.dbf';
  with faulty.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'faulty\id.ntx';
  end;
  with faulty.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'faulty\s_idx.ntx';
  end;
  with faulty.Indexes.add as TVKNTXIndex do begin
    NTXFileName := 'faulty\date.ntx';
  end;
  fh := FileOpen( 'faulty\password.txt',
                  fmOpenRead or fmShareDenyNone);
  l := FileSeek(fh, 0, 2);
  FileSeek(fh, 0, 0);
  FillChar(c, 1001, #0);
  FileRead(fh, c, l - 2);
  FileClose(fh);
  SetString(q, PAnsiChar(@c[0]), l - 2);
  faulty.Crypt.Password := q;
  faulty.Crypt.CryptMethod := cmGost;
  faulty.Crypt.Active := True;
  faulty.AccessMode.AccessMode := 18;
  faulty.Active := True;
  //
end;

procedure TVKDBFSetRangeTestCase.TestSetRange1;
begin
  dbf.SetRange('zak_status', [2]);
  dbf.First;
  Assert(dbf.FieldByName('zak_status').AsInteger = 2, 'ѕосле установки Range значение пол€ не верно 1!');
  dbf.Last;
  Assert(dbf.FieldByName('zak_status').AsInteger = 2, 'ѕосле установки Range значение пол€ не верно 2!');
  dbf.SetRange('zak_status', [2], [6]);
  dbf.First;
  Assert(dbf.FieldByName('zak_status').AsInteger = 2, 'ѕосле установки Range значение пол€ не верно 3!');
  dbf.Last;
  Assert(dbf.FieldByName('zak_status').AsInteger = 6, 'ѕосле установки Range значение пол€ не верно 4!');
end;

procedure TVKDBFSetRangeTestCase.TearDown;
begin
  if dbf <> nil then begin
    try
      if dbf.Active then dbf.Close;
      DeleteFile('tmp\sessions.dbf');
      DeleteFile('tmp\sess_s_idx.ntx');
      DeleteFile('tmp\zak_status.ntx');
    finally
      FreeAndNil(dbf);
    end;
  end;
  //
  //
  if faulty <> nil then begin
    try
      if faulty.Active then faulty.Close;
    finally
      FreeAndNil(faulty);
    end;
  end;
  //
  inherited TearDown;
end;

procedure TVKDBFSetRangeTestCase.TestSetRange2;
begin
  faulty.SetRange('s_idx', [190], [325]);
  faulty.First;
  Assert(faulty.FieldByName('s_idx').AsInteger = 190, 'ѕосле установки Range значение пол€ не верно 1!');
  faulty.Last;
  Assert(faulty.FieldByName('s_idx').AsInteger = 325, 'ѕосле установки Range значение пол€ не верно 2!');
  faulty.SetRange('id', [41], [133]);
  faulty.First;
  Assert(faulty.FieldByName('id').AsInteger = 41, 'ѕосле установки Range значение пол€ не верно 1!');
  faulty.Last;
  Assert(faulty.FieldByName('id').AsInteger = 133, 'ѕосле установки Range значение пол€ не верно 2!');
end;

initialization

  TestFramework.RegisterTest(TVKDBFSetRangeTestCase.Suite);

end.
