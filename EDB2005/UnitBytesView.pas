unit UnitBytesView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, ToolWin, ComCtrls;

type
  TBytesView = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Splitter1: TSplitter;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1Exit(Sender: TObject);
    procedure StringGrid2Enter(Sender: TObject);
    procedure StringGrid2Exit(Sender: TObject);
  private
    { Private declarations }
    cc, cr: Integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Add(Value: byte);
    function GetValue(Ind: Integer): byte;
  end;

implementation

{$R *.DFM}

{ TBytesView }

procedure TBytesView.Add(Value: byte);
begin
  StringGrid1.Cells[cc, cr] := IntToHex(Value, 2);
  StringGrid2.Cells[cc, cr] := Char(Value);
  Inc(cc);
  if cc = 16 then begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid2.RowCount := StringGrid2.RowCount + 1;
    Inc(cr);
    cc := 0;
  end;
end;

constructor TBytesView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  cc := 0;
  cr := 0;
end;

procedure TBytesView.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  oS: TStringGrid;
  oP: TStringGrid;
begin
  oS := Sender as TStringGrid;
  oP := nil;
  if oS.Name = 'StringGrid1' then
    oP := StringGrid2;
  if oS.Name = 'StringGrid2' then
    oP := StringGrid1;

  if oP <> nil then begin
    oP.Row := ARow;
    oP.Col := ACol;
  end;
end;

procedure TBytesView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

function TBytesView.GetValue(Ind: Integer): byte;
var
  r, c: Integer;
  h: String;
  b, b1: byte;
begin
  r := Ind div 16;
  c := Ind mod 16;
  h := StringGrid1.Cells[c, r];
  b := byte(h[1]);
  if b < $40 then
    b := b - $30
  else
    b := b - $37;
  b1 := byte(h[2]);
  if b1 < $40 then
    b1 := b1 - $30
  else
    b1 := b1 - $37;
  Result := b * 16 + b1;
end;

procedure TBytesView.StringGrid1Enter(Sender: TObject);
begin
  StringGrid1.OnSelectCell := StringGrid1SelectCell;
end;

procedure TBytesView.StringGrid1Exit(Sender: TObject);
begin
  StringGrid1.OnSelectCell := nil;
end;

procedure TBytesView.StringGrid2Enter(Sender: TObject);
begin
  StringGrid2.OnSelectCell := StringGrid1SelectCell;
end;

procedure TBytesView.StringGrid2Exit(Sender: TObject);
begin
  StringGrid2.OnSelectCell := nil;
end;

end.
