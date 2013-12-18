unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList, StdCtrls, DBCtrls, ToolWin, DB;

type
  TForm11 = class(TForm)
    ToolBar1: TToolBar;
    DBRichEdit1: TDBMemo;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    FontDialog1: TFontDialog;
    ImageList1: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetDataField: String;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: String);
    procedure SetDataSource(const Value: TDataSource);
    { Private declarations }
  public
    { Public declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: String read GetDataField write SetDataField;
  end;

implementation

{$R *.DFM}

procedure TForm11.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TForm11.GetDataField: String;
begin
  Result := DBRichEdit1.DataField;
end;

function TForm11.GetDataSource: TDataSource;
begin
  Result := DBRichEdit1.DataSource;
end;

procedure TForm11.SetDataField(const Value: String);
begin
  DBRichEdit1.DataField := Value;
end;

procedure TForm11.SetDataSource(const Value: TDataSource);
begin
  DBRichEdit1.DataSource := Value;
end;

procedure TForm11.ToolButton1Click(Sender: TObject);
begin
  DBRichEdit1.DataSource.DataSet.Post;
end;

procedure TForm11.ToolButton3Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    DBRichEdit1.Font.Assign(FontDialog1.Font);
end;

procedure TForm11.ToolButton5Click(Sender: TObject);
begin
  //Load
  if OpenDialog1.Execute then begin
    DBRichEdit1.DataSource.DataSet.Edit;
    TBlobField(DBRichEdit1.DataSource.DataSet.FieldByName(DataField)).LoadFromFile(OpenDialog1.FileName);
    DBRichEdit1.DataSource.DataSet.Post;
  end;
end;

procedure TForm11.ToolButton6Click(Sender: TObject);
begin
  //Save
  if SaveDialog1.Execute then begin
    if DBRichEdit1.DataSource.DataSet.State in [dsEdit, dsInsert] then DBRichEdit1.DataSource.DataSet.Post;
    TBlobField(DBRichEdit1.DataSource.DataSet.FieldByName(DataField)).SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm11.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
