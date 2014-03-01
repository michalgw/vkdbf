unit FNtxView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VKDBFNTX, Grids, ExtCtrls, ImgList, ComCtrls, ToolWin, ActnList,
  Menus;

type
  TTNtxView = class(TForm)
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    Work1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ActionList1: TActionList;
    aOpen: TAction;
    aOpenRoot: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    OEM: TCheckBox;
    ImageList1: TImageList;
    Open1: TMenuItem;
    OpenRootPage1: TMenuItem;
    ToolButton3: TToolButton;
    aOpenAnyPage: TAction;
    OpenAnyPage1: TMenuItem;
    aFindKey: TAction;
    aSeekKey: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    N1: TMenuItem;
    FindKey1: TMenuItem;
    SeekKey1: TMenuItem;
    aFindRecNo: TAction;
    ToolButton8: TToolButton;
    FindRecNo1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aOpenAnyPageExecute(Sender: TObject);
    procedure aFindKeyExecute(Sender: TObject);
    procedure aSeekKeyExecute(Sender: TObject);
    procedure aFindRecNoExecute(Sender: TObject);
  private
    { Private declarations }
    hd: NTX_HEADER;
    NtxFile: String;
  public
    { Public declarations }
    procedure Open(FileName: String);
  end;

var
  TNtxView: TTNtxView;

implementation

uses FNtxPage, fPageOff;

{$R *.DFM}

procedure TTNtxView.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Open(OpenDialog1.FileName);
end;

procedure TTNtxView.Button2Click(Sender: TObject);
var
  page: TTNtxPage;
begin
  page := TTNtxPage.CreatePage(self, NtxFile, hd.key_size, hd.root, OEM.Checked);
  page.Show;
end;

procedure TTNtxView.Open(FileName: String);
var
  h: Integer;
begin
  NtxFile := FileName;
  h := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
  if h <> -1 then begin
    FileSeek(h, 0, 0);
    FileRead(h, hd, 1024);
    StringGrid1.Cells[0, 0] := 'NTX Header Field';
    StringGrid1.Cells[1, 0] := 'NTX Header Value';

    StringGrid1.Cells[0, 1] := 'sign';
    StringGrid1.Cells[1, 1] := '$' + inttohex(integer(hd.sign), 4) + ' (' + IntToStr(integer(hd.sign)) + ')';

    StringGrid1.Cells[0, 2] := 'version';
    StringGrid1.Cells[1, 2] := '$' + inttohex(integer(hd.version), 4) + ' (' + IntToStr(integer(hd.version)) + ')';

    StringGrid1.Cells[0, 3] := 'root';
    StringGrid1.Cells[1, 3] := '$' + inttohex(int64(hd.root), 8) + ' (' + IntToStr(int64(hd.root)) + ')';

    StringGrid1.Cells[0, 4] := 'next_page';
    StringGrid1.Cells[1, 4] := '$' + inttohex(int64(hd.next_page), 8) + ' (' + IntToStr(int64(hd.next_page)) + ')';

    StringGrid1.Cells[0, 5] := 'item_size';
    StringGrid1.Cells[1, 5] := '$' + inttohex(integer(hd.item_size), 4) + ' (' + IntToStr(integer(hd.item_size)) + ')';

    StringGrid1.Cells[0, 6] := 'key_size';
    StringGrid1.Cells[1, 6] := '$' + inttohex(integer(hd.key_size), 4) + ' (' + IntToStr(integer(hd.key_size)) + ')';

    StringGrid1.Cells[0, 7] := 'key_dec';
    StringGrid1.Cells[1, 7] := '$' + inttohex(integer(hd.key_dec), 4) + ' (' + IntToStr(integer(hd.key_dec)) + ')';

    StringGrid1.Cells[0, 8] := 'max_item';
    StringGrid1.Cells[1, 8] := '$' + inttohex(integer(hd.max_item), 4) + ' (' + IntToStr(integer(hd.max_item)) + ')';

    StringGrid1.Cells[0, 9] := 'half_page';
    StringGrid1.Cells[1, 9] := '$' + inttohex(integer(hd.half_page), 4) + ' (' + IntToStr(integer(hd.half_page)) + ')';

    StringGrid1.Cells[0, 10] := 'key_expr';
    StringGrid1.Cells[1, 10] := hd.key_expr;

    StringGrid1.Cells[0, 11] := 'unique';
    StringGrid1.Cells[1, 11] := '$' + inttohex(integer(hd.unique), 2) + ' (' + IntToStr(integer(hd.unique)) + ')';

    StringGrid1.Cells[0, 12] := 'reserv1';
    StringGrid1.Cells[1, 12] := '$' + inttohex(integer(hd.reserv1), 2) + ' (' + IntToStr(integer(hd.reserv1)) + ')';

    StringGrid1.Cells[0, 13] := 'desc';
    StringGrid1.Cells[1, 13] := '$' + inttohex(integer(hd.desc), 2) + ' (' + IntToStr(integer(hd.desc)) + ')';

    StringGrid1.Cells[0, 14] := 'reserv3';
    StringGrid1.Cells[1, 14] := '$' + inttohex(integer(hd.reserv3), 2) + ' (' + IntToStr(integer(hd.reserv3)) + ')';

    StringGrid1.Cells[0, 15] := 'for_expr';
    StringGrid1.Cells[1, 15] := hd.for_expr;

    StringGrid1.Cells[0, 16] := 'order';
    StringGrid1.Cells[1, 16] := hd.order;

    StringGrid1.Cells[0, 17] := 'Rest';
    StringGrid1.Cells[1, 17] := hd.Rest;

    FileClose(h);
  end else
    MessageDlg('Open Error', mtError, [mbOK], 0);
end;

procedure TTNtxView.FormCreate(Sender: TObject);
begin
  if ParamStr(1) <> '' then
    Open(ParamStr(1));
end;

procedure TTNtxView.aOpenAnyPageExecute(Sender: TObject);
var
  page: TTNtxPage;
  objN: TPageOff;
begin
  objN := TPageOff.Create(self);
  objN.ShowModal;
  if objN.Ok then begin
    page := TTNtxPage.CreatePage(self, NtxFile, hd.key_size, objN.N, OEM.Checked);
    page.Show;
  end;
end;

procedure TTNtxView.aFindKeyExecute(Sender: TObject);
var
  h: Integer;
  page: NTX_BUFFER;
  item: pNTX_ITEM;
  FPage_Off: DWORD;
  rRead, i: Integer;
  bFound: boolean;
  oPage: TTNtxPage;
  objT: TPageOff;
  LenKey: Integer;
  sKey, S: String;
  bOEM: boolean;
  bSoftSeek: boolean;
begin
  i := 0;
  bOEM := OEM.Checked;
  bFound := false;
  FPage_Off := 1024;
  objT := TPageOff.Create(self);
  objT.ShowModal;
  if objT.Ok then begin
    bSoftSeek := objT.SoftSeek;
    sKey := objT.Text;
    LenKey := Length(sKey);
    if LenKey > hd.key_size then begin
      SetLength(sKey, hd.key_size);
      LenKey := hd.key_size;
    end;
    if (not bSoftSeek) and ( LenKey < hd.key_size ) then begin
      sKey := sKey + StringOfChar(' ', hd.key_size - LenKey);
      LenKey := hd.key_size;
    end;

    h := FileOpen(NtxFile, fmOpenRead or fmShareDenyNone);
    if h <> -1 then begin

      FileSeek(h, FPage_Off, 0);
      rRead := FileRead(h, page, 1024);

      if rRead <> 0 then
        repeat
          for i := 0 to page.count - 1 do begin
            item := pNTX_ITEM(pChar(@page) + page.ref[i]);
            SetString(s, item.key, hd.key_size);
            if bOEM then OEMToChar(pChar(s), pChar(s));
            if bSoftSeek and ( LenKey < hd.key_size ) then SetLength(s, LenKey);
            if CompareStr(sKey, S) = 0 then begin
              bFound := true;
              Break;
            end;
          end;

          if bFound then Break;

          Inc(FPage_Off, 1024);
          FileSeek(h, FPage_Off, 0);
          rRead := FileRead(h, page, 1024);
        until rRead = 0;

      FileClose(h);
    end else
      MessageDlg('Open Error', mtError, [mbOK], 0);
    if bFound then begin
      oPage := TTNtxPage.CreatePage(self, NtxFile, hd.key_size, FPage_Off, OEM.Checked);
      oPage.Show;
      oPage.Row := i + 1;
      oPage.Col := 3;
    end else
      MessageDlg('Key not found!', mtError, [mbOK], 0);
  end;
end;

procedure TTNtxView.aSeekKeyExecute(Sender: TObject);
begin
  ShowMessage('Seek Key not suported yet!');
end;

procedure TTNtxView.aFindRecNoExecute(Sender: TObject);
var
  h: Integer;
  page: NTX_BUFFER;
  item: pNTX_ITEM;
  FPage_Off: DWORD;
  rRead, i: Integer;
  bFound: boolean;
  oPage: TTNtxPage;
  objT: TPageOff;
  Rec: DWORD;
begin
  i := 0;
  bFound := false;
  FPage_Off := 1024;
  objT := TPageOff.Create(self);
  objT.ShowModal;
  if objT.Ok then begin
    Rec := objT.N;
    h := FileOpen(NtxFile, fmOpenRead or fmShareDenyNone);
    if h <> -1 then begin

      FileSeek(h, FPage_Off, 0);
      rRead := FileRead(h, page, 1024);

      if rRead <> 0 then
        repeat
          for i := 0 to page.count - 1 do begin
            item := pNTX_ITEM(pChar(@page) + page.ref[i]);
            if Rec = item.rec_no then begin
              bFound := true;
              Break;
            end;
          end;

          if bFound then Break;

          Inc(FPage_Off, 1024);
          FileSeek(h, FPage_Off, 0);
          rRead := FileRead(h, page, 1024);
        until rRead = 0;

      FileClose(h);
    end else
      MessageDlg('Open Error', mtError, [mbOK], 0);
    if bFound then begin
      oPage := TTNtxPage.CreatePage(self, NtxFile, hd.key_size, FPage_Off, OEM.Checked);
      oPage.Show;
      oPage.Row := i + 1;
      oPage.Col := 2;
    end else
      MessageDlg('RecNo not found!', mtError, [mbOK], 0);
  end;
end;

end.
