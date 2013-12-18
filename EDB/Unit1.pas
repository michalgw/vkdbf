unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ToolWin, ComCtrls, Menus, ActnList, ImgList, VKDBFCrypt, StdCtrls;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    CloseAll1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    OD: TOpenDialog;
    Windows1: TMenuItem;
    Help1: TMenuItem;
    Help2: TMenuItem;
    About1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Cascade1: TMenuItem;
    N2: TMenuItem;
    Tile1: TMenuItem;
    Vertical1: TMenuItem;
    ActionList1: TActionList;
    aOpen: TAction;
    aClose: TAction;
    aCloseAll: TAction;
    ImageList1: TImageList;
    aExit: TAction;
    aCreate: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    N3: TMenuItem;
    N4: TMenuItem;
    Create1: TMenuItem;
    Loadfile1: TMenuItem;
    ToolButton5: TToolButton;
    procedure Exit1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure Vertical1Click(Sender: TObject);
    procedure aOpenExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aCloseAllExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExitExecute(Sender: TObject);
    procedure aCreateExecute(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses Unit2, uCreateNew, About;

{$R *.DFM}

procedure TMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMain.Cascade1Click(Sender: TObject);
begin
  Application.MainForm.Cascade;
end;

procedure TMain.Tile1Click(Sender: TObject);
begin
  Application.MainForm.TileMode := tbHorizontal;
  Application.MainForm.Tile;
end;

procedure TMain.Vertical1Click(Sender: TObject);
begin
  Application.MainForm.TileMode := tbVertical;
  Application.MainForm.Tile;
end;

procedure TMain.aOpenExecute(Sender: TObject);
begin
  if OD.Execute then
    TForm2.Create(self, OD.FileName);
end;

procedure TMain.aCloseExecute(Sender: TObject);
begin
  if Application.MainForm.ActiveMDIChild <> nil then
    Application.MainForm.ActiveMDIChild.Close;
end;

procedure TMain.aCloseAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to MDIChildCount - 1 do
    if Application.MainForm.MDIChildren[i] <> nil then
      Application.MainForm.MDIChildren[i].Close;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aCloseAllExecute(self);
end;

procedure TMain.aExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMain.aCreateExecute(Sender: TObject);
var
  o: TCreateDBF;
begin
  o := TCreateDBF.Create(self);
  try
    o.ShowModal;
    if o.Ok then
      TForm2.Create(self, o.FileName);
  finally
    o.Destroy;
  end;
end;

procedure TMain.About1Click(Sender: TObject);
var
  oA: Tf_About;
begin
  oA := Tf_About.Create(self);
  oA.ShowModal;
end;

procedure TMain.ToolButton5Click(Sender: TObject);
begin
  if OD.Execute then
    TForm2.LoadFile(self, OD.FileName);
end;

end.
