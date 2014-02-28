unit VKDBFAddFieldsTestCase;

interface

uses  TestFrameWork, Windows, VKDBFDataSet, Sysutils,
      Classes, DB, VKDBFCrypt;

type

  TVKDBFAddFieldsTestCase = class(TTestCase)
  private
    dbf: TVKDBFNTX;
    procedure CheckNewFieldsIsNull;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddFields1;
  end;


implementation

{ TVKDBFAddFieldsTestCase }

procedure TVKDBFAddFieldsTestCase.TestAddFields1;
var
  fields: TVKDBFFieldDefs;
  field: TVKDBFFieldDef;
  First1: String;
  Last1: String;
  First2: String;
  Last2: String;
  F4Last: String;
  FileLast: String;
begin

  //
  Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
  Assert(dbf.GetCurrentNativeAutoInc('was_export') = 45678);
  Assert(dbf.GetNativeStepAutoInc('was_export') = 1);
  //

  fields := TVKDBFFieldDefs.Create(nil);
  try
    //
    dbf.first;
    First1 := dbf.FieldByName('FILE').AsString;
    dbf.Last;
    dbf.Prior();
    Last1 := dbf.FieldByName('FILE').AsString;
    //
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'F1';
    field.field_type := 'C';
    field.len := 20;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'F2';
    field.field_type := 'N';
    field.len := 10;
    field.dec := 4;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'F3';
    field.field_type := 'E';
    field.extend_type := dbftClob_NB;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'F4';
    field.field_type := 'E';
    field.extend_type := dbftBlob;

    ////////
    dbf.AddFields(fields, 1000, True);
    ////////

    //
    dbf.first;
    First2 := dbf.FieldByName('FILE').AsString;
    CheckNewFieldsIsNull;
    dbf.Last;
    CheckNewFieldsIsNull;
    dbf.Prior();
    CheckNewFieldsIsNull;
    Last2 := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 = First2, 'First Blob not idential.');
    Assert(Last1 = Last2, 'Last Blob not idential.');
    //
    dbf.Insert;
    dbf.FieldByName('FILE').AsString := First1 + Last1;
    dbf.FieldByName('F4').AsString := Last1 + First1;
    dbf.Post;
    //
    dbf.first;
    First1 := dbf.FieldByName('FILE').AsString;
    dbf.Last;
    dbf.Prior;
    dbf.Prior();
    Last1 := dbf.FieldByName('FILE').AsString;
    //
    dbf.first;
    First2 := dbf.FieldByName('FILE').AsString;
    dbf.Last;
    dbf.Prior;
    dbf.Prior();
    Last2 := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 = First2, 'First Blob not idential.');
    Assert(Last1 = Last2, 'Last Blob not idential.');
    //
    dbf.Last;
    F4Last := dbf.FieldByName('F4').AsString;
    FileLast := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 + Last1 = FileLast, 'Next Last Blob not idential 1.');
    Assert(Last1 + First1 = F4Last, 'Next Last Blob not idential 2.');
    //

    //
    Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
    Assert(dbf.GetCurrentNativeAutoInc('was_export') = 45678);
    Assert(dbf.GetNativeStepAutoInc('was_export') = 1);
    //


    ////////
    dbf.DeleteFields(fields, 1000, True);
    ////////

    //
    Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
    Assert(dbf.GetCurrentNativeAutoInc('was_export') = 45678);
    Assert(dbf.GetNativeStepAutoInc('was_export') = 1);
    //

    dbf.Last;
    FileLast := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 + Last1 = FileLast, 'Next Last Blob not idential 1.');
    //

    fields.Clear;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'ID';

    ////////
    dbf.DeleteFields(fields, 1000, True);
    ////////
    dbf.Last;
    FileLast := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 + Last1 = FileLast, 'Next Last Blob not idential 1.');
    //

    //
    Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
    Assert(dbf.GetCurrentNativeAutoInc('was_export') = 45678);
    Assert(dbf.GetNativeStepAutoInc('was_export') = 1);
    //

    fields.Clear;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'DATE';

    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'WAS_EXPORT';

    ////////
    dbf.DeleteFields(fields, 1000, True);
    ////////

    //
    Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
    //

    dbf.Last;
    FileLast := dbf.FieldByName('FILE').AsString;
    //
    Assert(First1 + Last1 = FileLast, 'Next Last Blob not idential 1.');
    //

    fields.Clear;
    field := TVKDBFFieldDef(fields.Add);
    field.Name := 'FILE';

    ////////
    dbf.DeleteFields(fields, 1000, True);
    ////////

    //
    Assert(dbf.GetCurrentAutoInc('s_idx') = 3210);
    //

    Assert(not FileExists(ChangeFileExt(dbf.DBFFileName, '.dbt')), 'Lob not deleted!');

  finally
    FreeAndNil(fields);
  end;

end;

procedure TVKDBFAddFieldsTestCase.CheckNewFieldsIsNull;
begin
  Assert(not dbf.FieldByName('F1').IsNull, 'Field must not be null!');
  Assert(dbf.FieldByName('F1').AsString = '                    ', 'Field F1 must be empty!');
  Assert(dbf.FieldByName('F2').IsNull, 'Field must be null!');
  Assert(dbf.FieldByName('F3').IsNull, 'Field must be null!');
  Assert(dbf.FieldByName('F4').IsNull, 'Field must be null!');
end;

procedure TVKDBFAddFieldsTestCase.SetUp;
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
  dbf.SetAutoInc('s_idx', 3210);
  dbf.SetNativeAutoInc('was_export', 45678);
  dbf.SetNativeStepAutoInc('was_export', 10);
end;

procedure TVKDBFAddFieldsTestCase.TearDown;
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

  TestFramework.RegisterTest(TVKDBFAddFieldsTestCase.Suite);

end.
