program NtxView;

uses
  Forms,
  FNtxView in 'FNtxView.pas' {TNtxView},
  FNtxPage in 'FNtxPage.pas' {TNtxPage},
  fPageOff in 'fPageOff.pas' {PageOff};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTNtxView, TNtxView);
  Application.Run;
end.
