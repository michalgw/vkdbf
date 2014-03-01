unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCancel: Boolean;
    function GetR: Integer;
    procedure SetR(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property R: Integer read GetR write SetR;
    property Cancel: boolean read FCancel;
  end;

implementation

{$R *.DFM}

{ TForm4 }

function TForm4.GetR: Integer;
var
  V, Code: Integer;
begin
  Result := 0;
  Val(Label1.Caption, V, Code);
  if Code = 0 then Result := V;
end;

procedure TForm4.SetR(const Value: Integer);
begin
  Label1.Caption := IntToStr(Value);
  Application.ProcessMessages;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  FCancel := true;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  FCancel := false;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
