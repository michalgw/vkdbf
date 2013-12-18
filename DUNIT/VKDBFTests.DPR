program VKDBFTests;

uses
  Forms,
  TestFrameWork,
  GUITestRunner,
  VKDBFTestCase in 'VKDBFTestCase.pas',
  VKDBFFaultyTestCase in 'VKDBFFaultyTestCase.pas',
  VKDBFLockTestCase in 'VKDBFLockTestCase.pas',
  VKDBFAddFieldsTestCase in 'VKDBFAddFieldsTestCase.pas',
  VKDBFSetRangeTestCase in 'VKDBFSetRangeTestCase.pas',
  VKDBFReCryptTestCase in 'VKDBFReCryptTestCase.pas',
  VKDBFCommaNumberTestCase in 'VKDBFCommaNumberTestCase.pas',
  VKDBFDeleteRecordsTest in 'VKDBFDeleteRecordsTest.pas',
  VKDBFNextAfterSeek in 'VKDBFNextAfterSeek.pas',
  VKDBFNTXTestCase in 'VKDBFNTXTestCase.pas',
  VKDBFUtilTest in 'VKDBFUtilTest.pas';

{$R *.RES}

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
end.
 
