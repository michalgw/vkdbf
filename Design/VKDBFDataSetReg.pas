unit VKDBFDataSetReg;

interface

procedure Register;

implementation

uses
  Classes, VKDBFDataSet;

//******************************************************************************
procedure Register;
begin
  RegisterComponents('VK DBF', [TVKDBFNTX, {TVKDBFCDX,} TVKNestedDBF]);
end;

end.