unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, DBCtrls, db, ToolWin, ImgList;

type
  TForm10 = class(TForm)
    DBRichEdit1: TDBRichEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    FontDialog1: TFontDialog;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    function GetDataField: String;
    procedure SetDataField(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: String read GetDataField write SetDataField;
  end;

implementation

{$R *.DFM}

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TForm10.GetDataField: String;
begin
  Result := DBRichEdit1.DataField;
end;

function TForm10.GetDataSource: TDataSource;
begin
  Result := DBRichEdit1.DataSource;
end;

procedure TForm10.SetDataField(const Value: String);
begin
  DBRichEdit1.DataField := Value;
end;

procedure TForm10.SetDataSource(const Value: TDataSource);
begin
  DBRichEdit1.DataSource := Value;
end;

procedure TForm10.ToolButton1Click(Sender: TObject);
begin
  DBRichEdit1.DataSource.DataSet.Post;
end;

procedure TForm10.ToolButton3Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    DBRichEdit1.SelAttributes.Assign(FontDialog1.Font);
end;

procedure TForm10.ToolButton4Click(Sender: TObject);
begin
  DBRichEdit1.Paragraph.Alignment := taLeftJustify;
end;

procedure TForm10.ToolButton5Click(Sender: TObject);
begin
  DBRichEdit1.Paragraph.Alignment := taCenter;
end;

procedure TForm10.ToolButton7Click(Sender: TObject);
begin
  DBRichEdit1.Paragraph.Alignment := taRightJustify;
end;

procedure TForm10.ToolButton9Click(Sender: TObject);
begin
  DBRichEdit1.Print('');
end;

procedure TForm10.ToolButton10Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    DBRichEdit1.DataSource.DataSet.Edit;
    TBlobField(DBRichEdit1.DataSource.DataSet.FieldByName(DataField)).LoadFromFile(OpenDialog1.FileName);
    DBRichEdit1.DataSource.DataSet.Post;
  end;
end;

procedure TForm10.ToolButton13Click(Sender: TObject);
begin
  if SaveDialog1.Execute then begin
    if DBRichEdit1.DataSource.DataSet.State in [dsEdit, dsInsert] then DBRichEdit1.DataSource.DataSet.Post;
    TBlobField(DBRichEdit1.DataSource.DataSet.FieldByName(DataField)).SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm10.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if DBRichEdit1.DataSource.DataSet.State in [dsEdit, dsInsert] then
    case MessageDlg('Text has been changed. Do you want to save it now?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: DBRichEdit1.DataSource.DataSet.Post;
      mrNo: DBRichEdit1.DataSource.DataSet.Cancel;
      mrCancel: CanClose := false;
    end;
end;

end.
