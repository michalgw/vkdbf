unit f_BLob;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, ComCtrls, ToolWin, db, ImgList;

type
  TBlobView = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    DBImage1: TDBImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
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

procedure TBlobView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TBlobView.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if DBImage1.DataSource.DataSet.State in [dsEdit, dsInsert] then
    case MessageDlg('Blob has been changed. Do you want to save it now?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: DBImage1.DataSource.DataSet.Post;
      mrNo: DBImage1.DataSource.DataSet.Cancel;
      mrCancel: CanClose := false;
    end;
end;

function TBlobView.GetDataField: String;
begin
  Result := DBImage1.DataField;
end;

function TBlobView.GetDataSource: TDataSource;
begin
  Result := DBImage1.DataSource;
end;

procedure TBlobView.SetDataField(const Value: String);
begin
  DBImage1.DataField := Value;
end;

procedure TBlobView.SetDataSource(const Value: TDataSource);
begin
  DBImage1.DataSource := Value;
end;

procedure TBlobView.ToolButton1Click(Sender: TObject);
begin
  DBImage1.DataSource.DataSet.Post;
end;

procedure TBlobView.ToolButton3Click(Sender: TObject);
begin
  //Load
  if OpenDialog1.Execute then begin
    DBImage1.DataSource.DataSet.Edit;
    TBlobField(DBImage1.DataSource.DataSet.FieldByName(DataField)).LoadFromFile(OpenDialog1.FileName);
    DBImage1.DataSource.DataSet.Post;
  end;
end;

procedure TBlobView.ToolButton4Click(Sender: TObject);
begin
  //Save
  if SaveDialog1.Execute then begin
    if DBImage1.DataSource.DataSet.State in [dsEdit, dsInsert] then DBImage1.DataSource.DataSet.Post;
    TBlobField(DBImage1.DataSource.DataSet.FieldByName(DataField)).SaveToFile(SaveDialog1.FileName);
  end;
end;

end.
