unit uCreateNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Db, ExtCtrls, VKDBFDataSet, VKDBFPrx;

type

  TCanEdit = procedure(Sender: TObject) of object;

  TMyInplaceEdit = class(TInplaceEdit)
  public
    property MaxLength;
    property EditMask;
  end;

  TMyGrid = class(TStringGrid)
  protected
    FOnCanEdit1: TCanEdit;
    FOnCanEdit2: TCanEdit;
    FOnCanEdit5: TCanEdit;
    function CanEditShow: Boolean; override;
    function CreateEditor: TInplaceEdit; override;
  public
    procedure DeleteRow(ARow: Longint); override;
    property OnCanEdit1: TCanEdit read FOnCanEdit1 write FOnCanEdit1;
    property OnCanEdit2: TCanEdit read FOnCanEdit2 write FOnCanEdit2;
    property OnCanEdit5: TCanEdit read FOnCanEdit5 write FOnCanEdit5;
  end;

  TCreateDBF = class(TForm)
    OpenDialog1: TOpenDialog;
    DBFNTX1: TVKDBFNTX;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    Button3: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    BaseTypes: TComboBox;
    ExTypes: TComboBox;
    Button4: TButton;
    Panel4: TPanel;
    dbfType: TComboBox;
    Label2: TLabel;
    LobPageSize: TEdit;
    FieldFlag: TGroupBox;
    cSystem: TCheckBox;
    cCanStoreNull: TCheckBox;
    cBinaryColumn: TCheckBox;
    cAutoIncrement: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BaseTypesExit(Sender: TObject);
    procedure BaseTypesClick(Sender: TObject);
    procedure ExTypesExit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FieldFlagExit(Sender: TObject);
  private
    function GetFileName: String;
    { Private declarations }
  public
    { Public declarations }
    Ok: boolean;
    StringGrid1: TMyGrid;
    procedure OnMyCanEdit1(Sender: TObject);
    procedure OnMyCanEdit2(Sender: TObject);
    procedure OnMyCanEdit5(Sender: TObject);
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;

    property FileName: String read GetFileName;

  end;

implementation

{$R *.DFM}

procedure TCreateDBF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caHide;
end;

procedure TCreateDBF.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
end;

constructor TCreateDBF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  StringGrid1 := TMyGrid.Create(self);
  StringGrid1.Parent := Panel1;
  StringGrid1.Align := alClient;
  StringGrid1.ColCount := 6;
  StringGrid1.RowCount := 2;
  StringGrid1.Options := [
    goFixedVertLine,
    goFixedHorzLine,
    goVertLine,
    goHorzLine,
    goRangeSelect,
    goEditing,
    goColSizing
  ];
  StringGrid1.FixedCols := 0;
  StringGrid1.OnKeyDown := StringGrid1KeyDown;
  StringGrid1.OnCanEdit1 := OnMyCanEdit1;
  StringGrid1.OnCanEdit2 := OnMyCanEdit2;
  StringGrid1.OnCanEdit5 := OnMyCanEdit5;
  StringGrid1.ColWidths[0] := 142;
  StringGrid1.ColWidths[1] := 112;
  StringGrid1.ColWidths[2] := 112;
  StringGrid1.ColWidths[3] := 50;
  StringGrid1.ColWidths[4] := 50;
  StringGrid1.ColWidths[5] := 50;
  StringGrid1.Cells[0, 0] := 'Name';
  StringGrid1.Cells[1, 0] := 'Type';
  StringGrid1.Cells[2, 0] := 'XType';
  StringGrid1.Cells[3, 0] := 'Size';
  StringGrid1.Cells[4, 0] := 'Dec';
  StringGrid1.Cells[5, 0] := 'Flag';

  Ok := false;
end;

destructor TCreateDBF.Destroy;
begin
  StringGrid1.Destroy;
  inherited Destroy;
end;

procedure TCreateDBF.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  OldRow: Integer;
begin
  if Key = VK_DELETE then
    if StringGrid1.Row <> 1 then begin
      OldRow := StringGrid1.Row;
      TMyGrid(StringGrid1).DeleteRow(OldRow);
      if OldRow < StringGrid1.RowCount then
        StringGrid1.Row := OldRow
      else
        StringGrid1.Row := StringGrid1.RowCount - 1;
    end;
  if Key = VK_UP then
    if StringGrid1.Row <> 1 then
      if (StringGrid1.RowCount - 1) = StringGrid1.Row then
        if (StringGrid1.Cells[0, StringGrid1.Row] = '')
            and (StringGrid1.Cells[1, StringGrid1.Row] = '')
            and (StringGrid1.Cells[2, StringGrid1.Row] = '')
            and (StringGrid1.Cells[3, StringGrid1.Row] = '') then begin
          TMyGrid(StringGrid1).DeleteRow(StringGrid1.RowCount - 1);
          StringGrid1.Row := StringGrid1.RowCount - 1;
          Key := 0;
        end;
  if Key = VK_DOWN then
    if (StringGrid1.RowCount - 1) = StringGrid1.Row then
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

{ TMyGrid }

function TMyGrid.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow;
  if InplaceEditor <> nil then begin
    if Col = 0 then begin
      //TMyInplaceEdit(InplaceEditor).EditMask := 'Laaaaaaaaa';
      TMyInplaceEdit(InplaceEditor).MaxLength := 31;
    end;
    if Col in [3, 4] then begin
      TMyInplaceEdit(InplaceEditor).EditMask := '####';
      TMyInplaceEdit(InplaceEditor).MaxLength := 4;
    end;
  end;
  if Col = 1 then begin
    if Assigned(FOnCanEdit1) and Result then FOnCanEdit1(self);
    Result := false;
  end;
  if Col = 2 then begin
    if Assigned(FOnCanEdit2) and Result and (Cells[1, Row] = 'E') then FOnCanEdit2(self);
    Result := false;
  end;
  if Col = 5 then begin
    if Assigned(FOnCanEdit5) and Result then FOnCanEdit5(self);
    Result := false;
  end;
end;

function TMyGrid.CreateEditor: TInplaceEdit;
begin
  Result := TMyInplaceEdit.Create(Self);
end;

procedure TMyGrid.DeleteRow(ARow: Integer);
begin
  inherited DeleteRow(ARow);
end;

procedure TCreateDBF.Button3Click(Sender: TObject);
begin
  Close;
end;

function TCreateDBF.GetFileName: String;
begin
  Result := Edit1.Text;
end;

procedure TCreateDBF.Button2Click(Sender: TObject);
var
  i: Integer;
  b: Byte;
begin
  if Edit1.Text <> '' then begin
    DBFNTX1.DBFFileName := Edit1.Text;
    if (dbfType.Text = '') or (dbfType.Text = 'xClipper') or (dbfType.Text = 'xBaseIII') then DBFNTX1.DbfVersion := xBaseIII;
    if dbfType.Text = 'xBaseIV' then DBFNTX1.DbfVersion := xBaseIV;
    if dbfType.Text = 'xBaseV' then DBFNTX1.DbfVersion := xBaseV;
    if dbfType.Text = 'xBaseVII' then DBFNTX1.DbfVersion := xBaseVII;
    if dbfType.Text = 'xFoxPro' then DBFNTX1.DbfVersion := xFoxPro;
    if dbfType.Text = 'xVisualFoxPro' then DBFNTX1.DbfVersion := xVisualFoxPro;
    DBFNTX1.LobBlockSize := StrToInt(LobPageSize.Text);
    for i := 1 to StringGrid1.RowCount - 1 do begin
      with DBFNTX1.DBFFieldDefs.Add as TVKDBFFieldDef do begin
        Name := Uppercase(Trim(StringGrid1.Cells[0, i]));
        field_type := AnsiChar(Uppercase(Trim(StringGrid1.Cells[1, i]))[1]);
        case field_type of
          'C', 'N', 'F':
            begin
              try
                len := StrToInt(Uppercase(Trim(StringGrid1.Cells[3, i])));
              except
                len := 0;
              end;
              try
                dec := StrToInt(Uppercase(Trim(StringGrid1.Cells[4, i])));
              except
                dec := 0;
              end;
            end;
        end;
        extend_type := Str2ExtType(StringGrid1.Cells[2, i]);
        case extend_type of
          DBFTSTRING, DBFTSTRING_N, DBFTFIXEDCHAR, DBFTWIDESTRING:
            begin
              try
                len := StrToInt(Uppercase(Trim(StringGrid1.Cells[3, i])));
              except
                len := 0;
              end;
            end;
        end;
        try
          b := Byte(StrToInt(StringGrid1.Cells[5, i]));
        except
          b := 0;
        end;
        FieldFlag.FieldFlag := b;
      end;
    end;
    try
      try
        DBFNTX1.CreateTable;
      except
        on e: Exception do begin
          ShowMessage(e.Message);
          raise;
        end;
      end;
      Ok := true;
    except
      Ok := false;
    end;
    Close;
  end else
    ShowMessage('Input filename!');
end;

procedure TCreateDBF.OnMyCanEdit1(Sender: TObject);
var
  Rect: TRect;
begin
  Rect := StringGrid1.CellRect(1, StringGrid1.Row);
  BaseTypes.Top := Rect.Top + 3;
  BaseTypes.Left := Rect.Left + 2;
  BaseTypes.Height := Rect.Bottom - Rect.Top + 8;
  BaseTypes.Width := Rect.Right - Rect.Left + 4;
  BaseTypes.Visible := true;
  BaseTypes.BringToFront;
  ActiveControl := BaseTypes;
end;

procedure TCreateDBF.BaseTypesExit(Sender: TObject);
begin
  BaseTypes.Visible := false;
  if BaseTypes.Text <> '' then
    StringGrid1.Cells[1, StringGrid1.Row] := BaseTypes.Text[1]
  else
    StringGrid1.Cells[1, StringGrid1.Row] := '';
  if StringGrid1.Cells[1, StringGrid1.Row] <> 'E' then
    StringGrid1.Cells[2, StringGrid1.Row] := '';
end;

procedure TCreateDBF.BaseTypesClick(Sender: TObject);
begin
  ActiveControl := StringGrid1;
end;

procedure TCreateDBF.ExTypesExit(Sender: TObject);
begin
  ExTypes.Visible := false;
  StringGrid1.Cells[2, StringGrid1.Row] := ExTypes.Text;
end;

procedure TCreateDBF.OnMyCanEdit2(Sender: TObject);
var
  Rect: TRect;
begin
  Rect := StringGrid1.CellRect(2, StringGrid1.Row);
  ExTypes.Top := Rect.Top + 3;
  ExTypes.Left := Rect.Left + 2;
  ExTypes.Height := Rect.Bottom - Rect.Top + 8;
  ExTypes.Width := Rect.Right - Rect.Left + 4;
  ExTypes.Visible := true;
  ExTypes.BringToFront;
  ActiveControl := ExTypes;
end;

procedure TCreateDBF.OnMyCanEdit5(Sender: TObject);
var
  Rect, RectGrig: TRect;
  b: Byte;
begin

  Rect := StringGrid1.CellRect(5, StringGrid1.Row);
  RectGrig := StringGrid1.ClientRect;
  if Rect.Top + FieldFlag.Height < RectGrig.Bottom then begin
    FieldFlag.Top := Rect.Top + 3;
    FieldFlag.Left := Rect.Right - FieldFlag.Width + 1;
  end else begin
    FieldFlag.Top := Rect.Bottom - FieldFlag.Height;
    FieldFlag.Left := Rect.Right - FieldFlag.Width + 1;
  end;

  try
    b := Byte(StrToInt(StringGrid1.Cells[5, StringGrid1.Row]));
  except
    b := 0;
  end;
  cSystem.Checked := False;
  cCanStoreNull.Checked := False;
  cBinaryColumn.Checked := False;
  cAutoIncrement.Checked := False;
  if ( b and DBF_CT_SYSTEM ) = DBF_CT_SYSTEM then cSystem.Checked := True;
  if ( b and DBF_CT_CANSTORENULL  ) = DBF_CT_CANSTORENULL then cCanStoreNull.Checked := True;
  if ( b and DBF_CT_BINARYCOLUMN  ) = DBF_CT_BINARYCOLUMN then cBinaryColumn.Checked := True;
  if ( b and DBF_CT_AUTOINCREMENT  ) = DBF_CT_AUTOINCREMENT then cAutoIncrement.Checked := True;

  FieldFlag.Visible := true;
  FieldFlag.BringToFront;
  ActiveControl := FieldFlag;

end;

procedure TCreateDBF.FieldFlagExit(Sender: TObject);
var
  b: Byte;
begin
  FieldFlag.Visible := false;
  b := 0;
  if cSystem.Checked then b := ( b or DBF_CT_SYSTEM );
  if cCanStoreNull.Checked then b := ( b or DBF_CT_CANSTORENULL );
  if cBinaryColumn.Checked then b := ( b or DBF_CT_BINARYCOLUMN );
  if cAutoIncrement.Checked then b := ( b or DBF_CT_AUTOINCREMENT );
  StringGrid1.Cells[5, StringGrid1.Row] := IntToStr(b);
end;

procedure TCreateDBF.Button4Click(Sender: TObject);
var
  oDB: TVKDBFNTX;
  i: Integer;
  qq: TVKDBFFieldDef;
  q: String;
begin
  if OpenDialog1.Execute then begin
    oDB := TVKDBFNTX.Create(self);
    try
      oDB.DBFFileName := OpenDialog1.FileName;
      oDB.AccessMode.AccessMode := 64;
      oDB.Open;
      case oDB.DbfVersion of
          xClipper:       dbfType.Text := 'xClipper';
          xBaseIII:       dbfType.Text := 'xBaseIII';
          xBaseIV:        dbfType.Text := 'xBaseIV';
          xBaseV:         dbfType.Text := 'xBaseV';
          xBaseVII:       dbfType.Text := 'xBaseVII';
          xFoxPro:        dbfType.Text := 'xFoxPro';
          xVisualFoxPro:  dbfType.Text := 'xVisualFoxPro';
      end;
      LobPageSize.Text := IntToStr(oDB.LobBlockSize);
      StringGrid1.RowCount := 2;
      for i := 0 to oDB.DBFFieldDefs.Count -1 do begin
        qq := oDB.DBFFieldDefs.Items[i];
        StringGrid1.Cells[0, i + 1] := Uppercase(Trim(qq.Name));
        StringGrid1.Cells[1, i + 1] := Uppercase(Trim(qq.field_type));
        StringGrid1.Cells[3, i + 1] := IntToStr(qq.Len);
        StringGrid1.Cells[4, i + 1] := IntToStr(qq.Dec);
        StringGrid1.Cells[5, i + 1] := IntToStr(qq.FieldFlag.FieldFlag);
        if qq.field_type = 'E' then begin
          q := ExtType2Str(qq.extend_type);
          StringGrid1.Cells[2, i + 1] := q;
        end else
          StringGrid1.Cells[2, i + 1] := '';
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
      end;
      StringGrid1.RowCount := StringGrid1.RowCount - 1;
      oDB.Close;
    finally
      oDB.Destroy;
    end;
  end;
end;

end.
