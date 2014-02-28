unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VKDBFDataSet, ExtCtrls, VKDBFCrypt;

type
  TForm9 = class(TForm)
    cActive: TCheckBox;
    Label1: TLabel;
    eDbfFileName: TEdit;
    cRead: TCheckBox;
    cReadWrite: TCheckBox;
    cWrite: TCheckBox;
    cDenyNone: TCheckBox;
    cDenyRead: TCheckBox;
    cDenyWrite: TCheckBox;
    cExclusive: TCheckBox;
    Button1: TButton;
    Label2: TLabel;
    eWaitBusyRes: TEdit;
    Label3: TLabel;
    eBuffSize: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    CryptMethod: TComboBox;
    CryptActive: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    CryptPass: TEdit;
    dbfType: TComboBox;
    Label8: TLabel;
    LobPageSize: TEdit;
    LockProtocol: TRadioGroup;
    FoxTableFlag: TGroupBox;
    HasGotIndex: TCheckBox;
    HasGotLOB: TCheckBox;
    ItIsTheDatabase: TCheckBox;
    LobLockProtocol: TRadioGroup;
    UseHash: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cActiveClick(Sender: TObject);
    procedure cReadClick(Sender: TObject);
    procedure cReadWriteClick(Sender: TObject);
    procedure cWriteClick(Sender: TObject);
    procedure eDbfFileNameChange(Sender: TObject);
    procedure cDenyNoneClick(Sender: TObject);
    procedure cDenyReadClick(Sender: TObject);
    procedure cDenyWriteClick(Sender: TObject);
    procedure cExclusiveClick(Sender: TObject);
    procedure eWaitBusyResChange(Sender: TObject);
    procedure eBuffSizeChange(Sender: TObject);
    procedure CryptActiveClick(Sender: TObject);
    procedure CryptMethodChange(Sender: TObject);
    procedure CryptPassChange(Sender: TObject);
    procedure dbfTypeChange(Sender: TObject);
    procedure LockProtocolClick(Sender: TObject);
    procedure FoxTableFlagClick(Sender: TObject);
    procedure LobLockProtocolClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDBF: TVKSmartDBF;
  end;

var
  Form9: TForm9;

implementation

{$R *.DFM}

procedure TForm9.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm9.cActiveClick(Sender: TObject);
begin
  LobLockProtocolClick(self);
  LockProtocolClick(self);
  FDBF.Active := cActive.Checked;
  cActive.Checked := FDBF.Active;
end;

procedure TForm9.cReadClick(Sender: TObject);
begin
  FDBF.AccessMode.OpenRead := cRead.Checked;
  cRead.Checked := FDBF.AccessMode.OpenRead;
end;

procedure TForm9.cReadWriteClick(Sender: TObject);
begin
  FDBF.AccessMode.OpenReadWrite := cReadWrite.Checked;
  cReadWrite.Checked := FDBF.AccessMode.OpenReadWrite;
end;

procedure TForm9.cWriteClick(Sender: TObject);
begin
  FDBF.AccessMode.OpenWrite := cWrite.Checked;
  cWrite.Checked := FDBF.AccessMode.OpenWrite;
end;

procedure TForm9.eDbfFileNameChange(Sender: TObject);
begin
  FDBF.DBFFileName := eDbfFileName.Text;
end;

procedure TForm9.cDenyNoneClick(Sender: TObject);
begin
  FDBF.AccessMode.ShareDenyNone := cDenyNone.Checked;
  cDenyNone.Checked := FDBF.AccessMode.ShareDenyNone;
end;

procedure TForm9.cDenyReadClick(Sender: TObject);
begin
  {
  FDBF.AccessMode.ShareDenyRead := cDenyRead.Checked;
  cDenyRead.Checked := FDBF.AccessMode.ShareDenyRead;
  }
end;

procedure TForm9.cDenyWriteClick(Sender: TObject);
begin
  FDBF.AccessMode.ShareDenyWrite := cDenyWrite.Checked;
  cDenyWrite.Checked := FDBF.AccessMode.ShareDenyWrite;
end;

procedure TForm9.cExclusiveClick(Sender: TObject);
begin
  FDBF.AccessMode.ShareExclusive := cExclusive.Checked;
  cExclusive.Checked := FDBF.AccessMode.ShareExclusive;
end;

procedure TForm9.eWaitBusyResChange(Sender: TObject);
begin
  FDBF.WaitBusyRes := StrToInt(eWaitBusyRes.Text);
end;

procedure TForm9.eBuffSizeChange(Sender: TObject);
begin
  FDBF.BufferSize := StrToInt(eBuffSize.Text);
end;

procedure TForm9.CryptActiveClick(Sender: TObject);
begin
  FDBF.Crypt.Active := CryptActive.Checked;
end;

procedure TForm9.CryptMethodChange(Sender: TObject);
begin
  if AnsiUpperCase(CryptMethod.Text) = 'CMXOR' then begin
    FDBF.Crypt.CryptMethod := cmXOR;
  end else
    if AnsiUpperCase(CryptMethod.Text) = 'CMGOST' then begin
      FDBF.Crypt.CryptMethod := cmGost;
    end else
      FDBF.Crypt.CryptMethod := cmNone;
end;

function Hash1(Value: String): String;
type
  TWordRec = packed record
    case Byte of
      0:  ( LowByte: Byte;
            HighByte: Byte );
      1:  (Value: Word);
  end;
  PWordRec = ^TWordRec;
const
  ssqss = '3487 hrgkldjfhgs89erygios45thkjehr dsiufgyse i5yet8 yslfueygsjer w34y tirtjger';
var
  i, j, l, l1, k: Integer;
  b: TWordRec;
  pass: String;
  p: Byte;
begin
  Result := '';
  p := 0;
  pass := ssqss[41] + ssqss[58] + ssqss[49] + ssqss[09] + ssqss[32] + ssqss[02] +
          ssqss[22] + ssqss[63] + ssqss[15] + ssqss[06] + ssqss[71] + ssqss[19] +
          ssqss[32] + ssqss[16] + ssqss[73] + ssqss[51] + ssqss[25] + ssqss[05];
  l := Length(Value);
  l1 := Length(pass);
  j := 1;
  for i := 1 to l do begin
    b.HighByte := 0;
    b.LowByte := Byte(Value[i]);
    k := b.Value mod 8;   // k = 0..7
    if k = 0 then k := 1;
    b.Value := b.Value shl k;
    b.LowByte := b.HighByte or b.LowByte;
    b.LowByte := b.LowByte xor Byte(pass[j]);
    b.HighByte := 0;
    Inc(j);
    if j > l1 then j := 1;
    b.LowByte := b.LowByte xor p;
    p := b.LowByte or Byte(pass[l1 - j + 1]);
    if b.Value > 122 then b.Value := b.Value - 122;
    if b.Value < 48 then b.Value := b.Value + 48;
    if b.Value in [58..64] then b.Value := (b.Value - 58) + 65;
    if b.Value in [91..96] then b.Value := (b.Value - 91) + 97;
    Result := Result + Char(b.LowByte);
  end;
end;

procedure TForm9.CryptPassChange(Sender: TObject);
begin
  if UseHash.Checked then
    FDBF.Crypt.Password := Hash1(CryptPass.Text)
  else
    FDBF.Crypt.Password := CryptPass.Text;
end;

procedure TForm9.dbfTypeChange(Sender: TObject);
var
  s: String;
begin
  s := AnsiUpperCase(dbfType.Text);
  if s = 'XUNKNOWN' then
    FDBF.DbfVersion := xBaseIII;
  if s = 'XCLIPPER' then
    FDBF.DbfVersion := xClipper;
  if s = 'XBASEIII' then
    FDBF.DbfVersion := xBaseIII;
  if s = 'XBASEIV' then
    FDBF.DbfVersion := xBaseIV;
  if s = 'XBASEV' then
    FDBF.DbfVersion := xBaseV;
  if s = 'XBASEVII' then
    FDBF.DbfVersion := xBaseVII;
  if s = 'XFOXPRO' then
    FDBF.DbfVersion := xFoxPro;
  if s = 'XVISUALFOXPRO' then
    FDBF.DbfVersion := xVisualFoxPro;
end;

procedure TForm9.LockProtocolClick(Sender: TObject);
var
  s: String;
begin
  if LockProtocol.ItemIndex <> - 1 then
    s := AnsiUpperCase(LockProtocol.Items[LockProtocol.ItemIndex])
  else
    s := 'LPNONE';
  if not FDBF.Active then begin
    if s = 'LPNONE' then
      FDBF.LockProtocol := lpNone;
    if s = 'LPDB4' then
      FDBF.LockProtocol := lpDB4Lock;
    if s = 'LPCLIPPER' then
      FDBF.LockProtocol := lpClipperLock;
    if s = 'LPFOXPRO' then
      FDBF.LockProtocol := lpFoxLock;
    if s = 'LPCLIPPERFORFOXLOB' then
      FDBF.LockProtocol := lpClipperForFoxLob;
  end;
end;

procedure TForm9.FoxTableFlagClick(Sender: TObject);
begin
  FDBF.FoxTableFlag.TableFlag := 0;
  if HasGotIndex.Checked then
    FDBF.FoxTableFlag.HasGotIndex := True;
  if HasGotLOB.Checked then
    FDBF.FoxTableFlag.HasGotMemo := True;
  if ItIsTheDatabase.Checked then
    FDBF.FoxTableFlag.ItIsDatabase := True;
end;

procedure TForm9.LobLockProtocolClick(Sender: TObject);
var
  s: String;
begin
  if LobLockProtocol.ItemIndex <> - 1 then
    s := AnsiUpperCase(LobLockProtocol.Items[LobLockProtocol.ItemIndex])
  else
    s := 'LPNONE';
  if not FDBF.Active then begin
    if s = 'LPNONE' then
      FDBF.LobLockProtocol := lpNone;
    if s = 'LPDB4' then
      FDBF.LobLockProtocol := lpDB4Lock;
    if s = 'LPCLIPPER' then
      FDBF.LobLockProtocol := lpClipperLock;
    if s = 'LPFOXPRO' then
      FDBF.LobLockProtocol := lpFoxLock;
    if s = 'LPCLIPPERFORFOXLOB' then
      FDBF.LobLockProtocol := lpClipperForFoxLob;
  end;
end;

end.
