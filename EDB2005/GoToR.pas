unit GoToR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TGoToR = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function GetNewRec: Integer;
    { Private declarations }
  public
    { Public declarations }
    property NewRec: Integer read GetNewRec;
  end;


implementation

{$R *.DFM}

procedure TGoToR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TGoToR.GetNewRec: Integer;
begin
  try
    Result := StrToInt(Edit1.Text);
  except
    Result := -1;
  end;
end;

end.
