unit FNtxPage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, VKDBFNTX, ActnList, ComCtrls, ImgList, Menus,
  ToolWin;

type

  Tqq = class
  public
    off: DWORD;
  end;

  TTNtxPage = class(TForm)
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    Work1: TMenuItem;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ToolButton1: TToolButton;
    aOpenPage: TAction;
    OpenPage1: TMenuItem;
    Label1: TLabel;
    ToolButton2: TToolButton;
    aFindParentPage: TAction;
    ToolButton3: TToolButton;
    FindParentPage1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure aFindParentPageExecute(Sender: TObject);
  private
    { Private declarations }
    ntx_b: NTX_BUFFER;
    Fkey_size: WORD;
    FNtxFile: String;
    FPage_Off: DWORD;
    FOEM: boolean;
    procedure SetRow(const Value: Integer);
    procedure SetCol(const Value: Integer);
  public
    { Public declarations }
    constructor CreatePage(AOwner: TComponent; NtxFile: String;
          key_size: WORD; Page_Off: DWORD; OEM: Boolean = false);
    destructor Destroy; override;
    property Row: Integer write SetRow;
    property Col: Integer write SetCol;
  end;

implementation

uses fPageOff;

{$R *.DFM}

{ TTNtxPage }

constructor TTNtxPage.CreatePage(AOwner: TComponent; NtxFile: String;
  key_size: WORD; Page_Off: DWORD; OEM: Boolean);
var
  h: Integer;
  i, j: Integer;
  item: pNTX_ITEM;
  s: String;
begin
  inherited Create(AOwner);
  Fkey_size := key_size;
  FNtxFile := NtxFile;
  FPage_Off := Page_Off;
  if FPage_Off <> 0 then begin
    FOEM := OEM;
    h := FileOpen(NtxFile, fmOpenRead or fmShareDenyNone);
    if h <> -1 then begin
      Caption := Format('NtxPage: $%x [%d]', [FPage_Off, FPage_Off]);
      FileSeek(h, FPage_Off, 0);
      FileRead(h, ntx_b, 1024);
      Label1.Caption := Format('Count: %d', [ntx_b.count]);
      StringGrid1.Cells[0, 0] := '#';
      StringGrid1.Cells[1, 0] := 'page';
      StringGrid1.Cells[2, 0] := 'rec_no';
      StringGrid1.Cells[3, 0] := 'key';
      j := 1;
      for i := 0 to ntx_b.count - 1 do begin
        if j > ( StringGrid1.RowCount - 1) then StringGrid1.RowCount := StringGrid1.RowCount + 1;
        StringGrid1.Cells[0, j] := IntToStr(j);
        item := pNTX_ITEM(pChar(@ntx_b) + ntx_b.ref[i]);
        StringGrid1.Cells[1, j] := '$' + inttohex(int64(item.page), 8) + ' (' + IntToStr(int64(item.page)) + ')';
        StringGrid1.Objects[1, j] := Tqq.Create;
        Tqq(StringGrid1.Objects[1, j]).off := item.page;
        StringGrid1.Cells[2, j] := '$' + inttohex(int64(item.rec_no), 8) + ' (' + IntToStr(int64(item.rec_no)) + ')';
        SetString(s, item.key, key_size);
        if OEM then OEMToChar(pChar(s), pChar(s));
        StringGrid1.Cells[3, j] := s;
        Inc(j);
      end;
      item := pNTX_ITEM(pChar(@ntx_b) + ntx_b.ref[ntx_b.count]);
      //if item.page <> 0 then begin
        if j > ( StringGrid1.RowCount - 1) then StringGrid1.RowCount := StringGrid1.RowCount + 1;
        StringGrid1.Cells[0, j] := '';
        StringGrid1.Cells[1, j] := '$' + inttohex(int64(item.page), 8) + ' (' + IntToStr(int64(item.page)) + ')';
        StringGrid1.Objects[1, j] := Tqq.Create;
        Tqq(StringGrid1.Objects[1, j]).off := item.page;
        StringGrid1.Cells[2, j] := '$' + inttohex(int64(item.rec_no), 8) + ' (' + IntToStr(int64(item.rec_no)) + ')';
        StringGrid1.Cells[3, j] := '';
      //end;
      FileClose(h);
    end else
      raise Exception.Create('Open Error');
      //MessageDlg('Open Error', mtError, [mbOK], 0);
  end else
    raise Exception.Create('Offset is 0');
    //MessageDlg('Offset is 0', mtError, [mbOK], 0);
end;

destructor TTNtxPage.Destroy;
begin
  inherited Destroy;
end;

procedure TTNtxPage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTNtxPage.Button1Click(Sender: TObject);
var
  page: TTNtxPage;
begin
  page := TTNtxPage.CreatePage(self, FNtxFile, Fkey_size, Tqq(StringGrid1.Objects[1, StringGrid1.Row]).off, FOEM);
  page.Show;
end;

procedure TTNtxPage.SetRow(const Value: Integer);
begin
  ActiveControl := StringGrid1;
  StringGrid1.Row := Value;
end;

procedure TTNtxPage.SetCol(const Value: Integer);
begin
  ActiveControl := StringGrid1;
  StringGrid1.Col := Value;
end;

procedure TTNtxPage.aFindParentPageExecute(Sender: TObject);
var
  h: Integer;
  page: NTX_BUFFER;
  item: pNTX_ITEM;
  FPageOff: DWORD;
  rRead, i: Integer;
  bFound: boolean;
  oPage: TTNtxPage;
begin
  i := 0;
  bFound := false;
  FPageOff := 1024;
  h := FileOpen(FNtxFile, fmOpenRead or fmShareDenyNone);
  if h <> -1 then begin

    FileSeek(h, FPageOff, 0);
    rRead := FileRead(h, page, 1024);

    if rRead <> 0 then
      repeat
        for i := 0 to page.count - 1 do begin
          item := pNTX_ITEM(pChar(@page) + page.ref[i]);
          if FPage_Off = item.page then begin
            bFound := true;
            Break;
          end;
        end;
        item := pNTX_ITEM(pChar(@page) + page.ref[page.count]);
        if FPage_Off = item.page then bFound := true;

        if bFound then Break;

        Inc(FPageOff, 1024);
        FileSeek(h, FPageOff, 0);
        rRead := FileRead(h, page, 1024);
      until rRead = 0;

    FileClose(h);
  end else
    MessageDlg('Open Error', mtError, [mbOK], 0);
  if bFound then begin
    oPage := TTNtxPage.CreatePage(self, FNtxFile, Fkey_size, FPageOff, FOEM);
    oPage.Show;
    oPage.Row := i + 1;
    oPage.Col := 1;
  end else
    MessageDlg('Page not found!', mtError, [mbOK], 0);
end;

end.

