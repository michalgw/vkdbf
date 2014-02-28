unit Unit8;

interface

{$I VKDBF.DEF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI6} Variants, {$ENDIF}
  StdCtrls, ComCtrls, VKDBFDataSet, VKDBFNTX, db, Grids, ActiveX;

type
  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StringGrid1: TStringGrid;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button4: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses Unit2, Unit1;

{$R *.DFM}

constructor TForm8.Create(AOwner: TComponent);
var
  O: TForm2;
  DBFNTX: TVKDBFNTX;
  i: Integer;
begin
  inherited Create(AOwner);
  O := TForm2(AOwner);
  DBFNTX := O.DBFNTX1;
  StringGrid1.Cells[0, 0] := '';
  StringGrid1.Cells[1, 0] := 'Field Name';
  StringGrid1.Cells[2, 0] := 'Type';
  StringGrid1.Cells[3, 0] := 'Value';
  StringGrid1.RowCount := DBFNTX.Fields.Count + 1;
  for i := 0 to StringGrid1.RowCount - 1 do
    StringGrid1.Objects[0, i] := Pointer(0);
  for i := 0 to DBFNTX.Fields.Count - 1 do begin
    StringGrid1.Cells[1, i + 1] := DBFNTX.Fields[i].FieldName;
    case DBFNTX.Fields[i].DataType of
      ftString: StringGrid1.Cells[2, i + 1] := 'C';
      ftSmallint, ftInteger, ftWord: StringGrid1.Cells[2, i + 1] := 'N';
      ftBoolean: StringGrid1.Cells[2, i + 1] := 'L';
      ftFloat, ftCurrency, ftBCD: StringGrid1.Cells[2, i + 1] := 'N';
      ftDate, ftDateTime: StringGrid1.Cells[2, i + 1] := 'D';
      ftMemo: StringGrid1.Cells[2, i + 1] := 'M';
    else
    end;
    StringGrid1.Cells[3, i + 1] := DBFNTX.Fields[i].AsString;
  end;
end;

destructor TForm8.Destroy;
begin
  inherited Destroy;
end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TForm8.Button1Click(Sender: TObject);
var
  O: TForm2;
  DBFNTX: TVKDBFNTX;
  i, j, k, l, m, Code: Integer;
  kk: Int64;
  d: double;
  KeyFields: String;
  KeyValues: Variant;
  {$IFNDEF DELPHI6}
  v: Variant;
  {$ENDIF}
  s: String;
  Options: TLocateOptions;
  r: DWORD;
begin
  O := TForm2(Owner);
  DBFNTX := O.DBFNTX1;
  KeyFields := '';
  j := 0;
  for i := 0 to StringGrid1.RowCount - 2 do
    if Integer(StringGrid1.Objects[0, i + 1]) = 1 then Inc(j);
  if j <> 0 then begin
    KeyValues := VarArrayCreate([0, j - 1], varVariant);
    l := 0;
    for i := 0 to StringGrid1.RowCount - 2 do
      if Integer(StringGrid1.Objects[0, i + 1]) = 1 then begin

          KeyFields := KeyFields + StringGrid1.Cells[1, i + 1] + ';';
          case DBFNTX.FieldByName(StringGrid1.Cells[1, i + 1]).DataType of
            ftString, ftMemo, ftWideString: KeyValues[l] := StringGrid1.Cells[3, i + 1];
            ftSmallint, ftInteger, ftWord:
              begin
                Val(StringGrid1.Cells[3, i + 1], k, code);
                if code <> 0 then
                  KeyValues[l] := Null
                else
                  KeyValues[l] := k;
              end;
            ftLargeint:
              begin
                Val(StringGrid1.Cells[3, i + 1], kk, code);
                if code <> 0 then
                  KeyValues[l] := Null
                else begin
                  {$IFDEF DELPHI6}
                  KeyValues[l] := kk;
                  {$ELSE}
                  TVarData(v).VType := VT_DECIMAL;
                  Decimal(v).lo64 := kk;
                  KeyValues[l] := v;
                  {$ENDIF}
                end;
              end;
            //ftBoolean:
            ftFloat, ftCurrency, ftBCD:
              begin
                s := StringGrid1.Cells[3, i + 1];
                for m := 1 to Length(s) do if s[m] = ',' then s[m] := '.';
                Val(s, d, code);
                if code <> 0 then
                  KeyValues[l] := Null
                else
                  KeyValues[l] := d;
              end;
            ftDate, ftDateTime:
              begin
                d := StrToDate(StringGrid1.Cells[3, i + 1]);
                KeyValues[l] := d;
              end;
          else
          end;
          Inc(l);

      end;
    Options := [];
    if CheckBox1.Checked then
      Options := Options + [loCaseInsensitive];
    if CheckBox2.Checked then
      Options := Options + [loPartialKey];
    if TButton(Sender).Tag = 1 then
      if not DBFNTX.Locate(KeyFields, KeyValues, Options) then
        ShowMessage('Record with giving values not found!');
    if TButton(Sender).Tag = 2 then begin
      r := DBFNTX.LocateRecord(KeyFields, KeyValues, Options, DBFNTX.RecNo + 1);
      if r = 0 then
        ShowMessage('Record with giving values not found!')
      else
        DBFNTX.RecNo := r;
    end;
  end;
  Close;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm8.Button3Click(Sender: TObject);
var
  O: TForm2;
  DBFNTX: TVKDBFNTX;
  i: Integer;
begin
  O := TForm2(Owner);
  DBFNTX := O.DBFNTX1;
  for i := 0 to StringGrid1.RowCount - 2 do
      StringGrid1.Cells[3, i + 1] := DBFNTX.FieldByName(StringGrid1.Cells[1, i + 1]).AsString;
end;

procedure TForm8.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 0) and (ARow = 0) then begin
    StringGrid1.Canvas.FillRect(Rect);
    Main.ImageList1.Draw(StringGrid1.Canvas, Rect.Left, Rect.Top, 56);
  end;
  if (ACol = 0) and (ARow <> 0) then begin
    if Integer(StringGrid1.Objects[0, ARow]) = 1 then begin
      StringGrid1.Canvas.FillRect(Rect);
      Main.ImageList1.Draw(StringGrid1.Canvas, Rect.Left, Rect.Top, 56);
    end;
  end;
end;

procedure TForm8.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Longint;
begin
  StringGrid1.MouseToCell(X, Y, ACol, ARow);
  if (ACol = 0) and (ARow >0) then begin
    if Integer(StringGrid1.Objects[0, ARow]) = 1 then
      StringGrid1.Objects[0, ARow] := Pointer(0)
    else
      StringGrid1.Objects[0, ARow] := Pointer(1);
  end;
end;

end.
