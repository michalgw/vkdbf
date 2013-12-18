unit fPageOff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPageOff = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    cbSoftSeek: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    function GetN: DWORD;
    function GetText: String;
    function GetSoftSeek: boolean;
    { Private declarations }
  public
    { Public declarations }
    Ok: boolean;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property N: DWORD read GetN;
    property Text: String read GetText;
    property SoftSeek: boolean read GetSoftSeek;
  end;

implementation

{$R *.DFM}

procedure TPageOff.Button1Click(Sender: TObject);
begin
  Ok := true;
  Close;
end;

constructor TPageOff.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Ok := false;
end;

destructor TPageOff.Destroy;
begin
  inherited Destroy;
end;

function TPageOff.GetN: DWORD;
begin
  try
    Result := DWORD(StrToInt(Edit1.Text));
  except
    Result := 0;
  end;
end;

function TPageOff.GetSoftSeek: boolean;
begin
  Result := cbSoftSeek.Checked;
end;

function TPageOff.GetText: String;
begin
  Result := Edit1.Text;
end;

end.
