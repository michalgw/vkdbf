program EDB;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Main},
  Unit2 in 'Unit2.pas' {Form2},
  GoToR in 'GoToR.pas' {GoToR},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {Form7},
  Unit8 in 'Unit8.pas' {Form8},
  Unit9 in 'Unit9.pas' {Form9},
  uCreateNew in 'uCreateNew.pas' {CreateDBF},
  GrToExcel in 'GrToExcel.pas',
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas' {Form11},
  Unit12 in 'Unit12.pas' {Form12},
  f_BLob in 'f_BLob.pas' {BlobView},
  About in 'About.pas' {f_About},
  UnitBytesView in 'UnitBytesView.pas' {BytesView};

{$R *.RES}

begin

  Application.Initialize;
  Application.CreateForm(TMain, Main);
  //if ParamStr(1) <> '' then
  //  TForm2.Create(Application, ParamStr(1));
  if ParamStr(1) <> '' then begin
    with TForm2.LoadFile(Application, ParamStr(1)) do begin
      aOpenAttr.Execute;
    end;
  end;

  Application.Run;
  
end.
