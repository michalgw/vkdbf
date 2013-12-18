unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm12 = class(TForm)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    function GetId: Integer;
    { Private declarations }
  public
    { Public declarations }
    property Id: Integer read GetId;
  end;

implementation

{$R *.DFM}

procedure TForm12.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TForm12.Button1Click(Sender: TObject);
begin
  Close;
end;

function TForm12.GetId: Integer;
begin
  Result := RadioGroup1.ItemIndex;
end;

end.
