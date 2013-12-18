unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, db, VKDBFNTX;

type
  TForm7 = class(TForm)
    ListView1: TListView;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1, Unit2;

{$R *.DFM}

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  //Ok
  if  (ListView1.Selected <> nil) and
      (ListView1.Selected.Data <> nil) and
      (Edit1.Text <> '') then begin
    TForm2(Owner).DBFNTX1.DataSource := TDataSource(ListView1.Selected.Data);
    TForm2(Owner).DBFNTX1.MasterFields := Edit1.Text;
  end;
  Close;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm7.Button3Click(Sender: TObject);
var
  i: Integer;
begin
  TForm2(Owner).DBFNTX1.MasterFields := '';
  TForm2(Owner).DBFNTX1.DataSource := nil;
  for i := 0 to TForm2(Owner).DBFNTX1.Indexes.Count - 1 do
    TVKNTXIndex(TForm2(Owner).DBFNTX1.Indexes.Items[i]).NTXRange.Active := false;
  Close;
end;

constructor TForm7.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  for i := 0 to Application.MainForm.MDIChildCount - 1 do
    if Application.MainForm.MDIChildren[i] <> nil then
      if Application.MainForm.MDIChildren[i] <> Owner then begin
        with ListView1.Items.Add do begin
          Caption := Application.MainForm.MDIChildren[i].Caption;
          Data := TForm2(Application.MainForm.MDIChildren[i]).DataSource1;
          if TForm2(AOwner).MasterSource <> nil then
            if (TForm2(AOwner).MasterSource = TForm2(Application.MainForm.MDIChildren[i]).DataSource1) then
              Selected := true;
        end;
      end;
  Edit1.Text := TForm2(AOwner).DBFNTX1.MasterFields;
end;

end.
