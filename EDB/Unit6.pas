unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VKDBFNTX, VKDBFDataSet, StdCtrls, VKDBFIndex;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    NtxFileName: TEdit;
    OD: TOpenDialog;
    Button3: TButton;
    Label2: TLabel;
    KeyExpresion: TEdit;
    Label3: TLabel;
    ForExpresion: TEdit;
    KeyTranslate: TCheckBox;
    Unique: TCheckBox;
    Desc: TCheckBox;
    Temp: TCheckBox;
    Label4: TLabel;
    Order: TEdit;
    GroupBox1: TGroupBox;
    RangeActive: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    HiKey: TEdit;
    LoKey: TEdit;
    GroupBox2: TGroupBox;
    LimitAouto: TRadioButton;
    LimitLimited: TRadioButton;
    LimitUnlimited: TRadioButton;
    EditLimit: TEdit;
    ShowLimit: TLabel;
    Collations: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    CustomCollationSeq: TEdit;
    EditPgPB: TEdit;
    ShowPages: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure LimitLimitedClick(Sender: TObject);
  private
    FoI: TVKNTXIndex;
    procedure SetFoI(const Value: TVKNTXIndex);
    { Private declarations }
  public
    { Public declarations }
    Ok: boolean;
    property oI: TVKNTXIndex read FoI write SetFoI;
  end;

  function GetCollation(CollationName: String): TVKCollationTypes;
  function GetCollationName(Collation: TVKCollationTypes): String;

implementation

{$R *.DFM}

  function GetCollation(CollationName: String): TVKCollationTypes;
  begin
    Result :=             cltNone;
    if CollationName = 'cltNone' then Result :=                   cltNone                     ;
    if CollationName = 'cltCustom' then Result :=                 cltCustom                   ;
    if CollationName = 'cltClipper501Rus' then Result :=          cltClipper501Rus            ;
    if CollationName = 'cltGermanCollation' then Result :=        cltGermanCollation          ;
    if CollationName = 'cltFrenchCollation' then Result :=        cltFrenchCollation          ;
    if CollationName = 'cltSpanishCollation' then Result :=       cltSpanishCollation         ;
    if CollationName = 'cltItalianCollation' then Result :=       cltItalianCollation         ;
    if CollationName = 'cltSwedishCollation' then Result :=       cltSwedishCollation         ;
    if CollationName = 'cltPortugueseCollation' then Result :=    cltPortugueseCollation      ;
    if CollationName = 'cltNorwegianCollation' then Result :=     cltNorwegianCollation       ;
    if CollationName = 'cltFinnishCollation' then Result :=       cltFinnishCollation         ;
    if CollationName = 'cltDutchCollation' then Result :=         cltDutchCollation           ;
    if CollationName = 'cltDanishCollation' then Result :=        cltDanishCollation          ;
    if CollationName = 'cltGreek437Collation' then Result :=      cltGreek437Collation        ;
    if CollationName = 'cltGreek851Collation' then Result :=      cltGreek851Collation        ;
    if CollationName = 'cltIcelandic850Collation' then Result :=  cltIcelandic850Collation    ;
    if CollationName = 'cltIcelandic861Collation' then Result :=  cltIcelandic861Collation    ;
    if CollationName = 'cltPolish852Collation' then Result :=     cltPolish852Collation       ;
    if CollationName = 'cltHungarianCWICollation' then Result :=  cltHungarianCWICollation    ;
    if CollationName = 'cltHungarian852Collation' then Result :=  cltHungarian852Collation    ;
  end;

  function GetCollationName(Collation: TVKCollationTypes): String;
  begin
    case Collation of
      cltNone:                    Result := 'cltNone';
      cltCustom:                  Result := 'cltCustom';
      cltClipper501Rus:           Result := 'cltClipper501Rus';
      cltGermanCollation:         Result := 'cltGermanCollation';
      cltFrenchCollation:         Result := 'cltFrenchCollation';
      cltSpanishCollation:        Result := 'cltSpanishCollation';
      cltItalianCollation:        Result := 'cltItalianCollation';
      cltSwedishCollation:        Result := 'cltSwedishCollation';
      cltPortugueseCollation:     Result := 'cltPortugueseCollation';
      cltNorwegianCollation:      Result := 'cltNorwegianCollation';
      cltFinnishCollation:        Result := 'cltFinnishCollation';
      cltDutchCollation:          Result := 'cltDutchCollation';
      cltDanishCollation:         Result := 'cltDanishCollation';
      cltGreek437Collation:       Result := 'cltGreek437Collation';
      cltGreek851Collation:       Result := 'cltGreek851Collation';
      cltIcelandic850Collation:   Result := 'cltIcelandic850Collation';
      cltIcelandic861Collation:   Result := 'cltIcelandic861Collation';
      cltPolish852Collation:      Result := 'cltPolish852Collation';
      cltHungarianCWICollation:   Result := 'cltHungarianCWICollation';
      cltHungarian852Collation:   Result := 'cltHungarian852Collation';
    end;
  end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  ct: TVKCollationTypes;
begin
  ct := GetCollation(Collations.Text);
  if ct <> FoI.Collation.CollationType then FoI.Collation.CollationType := ct;
  FoI.Collation.CustomCollatingSequence := CustomCollationSeq.Text;
  FoI.NTXFileName := NTXFileName.Text;
  FoI.KeyExpresion := KeyExpresion.Text;
  FoI.ForExpresion := ForExpresion.Text;
  FoI.KeyTranslate := KeyTranslate.Checked;
  FoI.Unique := Unique.Checked;
  FoI.Desc := Desc.Checked;
  FoI.Temp := Temp.Checked;
  FoI.Order := Order.Text;
  FoI.NTXRange.HiKey := HiKey.Text;
  FoI.NTXRange.LoKey := LoKey.Text;
  if FoI.IsOpen then begin
    if FoI.NTXRange.Active = RangeActive.Checked then
      FoI.NTXRange.Active := not RangeActive.Checked;
    FoI.NTXRange.Active := RangeActive.Checked;
    FoI.OwnerTable.First;
  end;
  if LimitAouto.Checked then FoI.LimitPages.LimitPagesType := lbtAuto;
  if LimitLimited.Checked then begin
    FoI.LimitPages.LimitPagesType := lbtLimited;
    FoI.LimitPages.LimitBuffers := StrToInt(EditLimit.Text);
    FoI.LimitPages.PagesPerBuffer := StrToInt(EditPgPB.Text);
  end;
  if LimitUnlimited.Checked then begin
    FoI.LimitPages.LimitPagesType := lbtUnlimited;
    FoI.LimitPages.PagesPerBuffer := StrToInt(EditPgPB.Text);
  end;
  Ok := true;
  Close;
end;

procedure TForm6.SetFoI(const Value: TVKNTXIndex);
begin
  FoI := Value;
  Collations.Text := GetCollationName(FoI.Collation.CollationType);
  CustomCollationSeq.Text := FoI.Collation.CustomCollatingSequence;
  NTXFileName.Text := FoI.NTXFileName;
  KeyExpresion.Text := FoI.KeyExpresion;
  ForExpresion.Text := FoI.ForExpresion;
  KeyTranslate.Checked := FoI.KeyTranslate;
  Unique.Checked := FoI.Unique;
  Desc.Checked := FoI.Desc;
  Temp.Checked := FoI.Temp;
  Order.Text := FoI.Order;
  RangeActive.Checked := FoI.NTXRange.Active;
  HiKey.Text := FoI.NTXRange.HiKey;
  LoKey.Text := FoI.NTXRange.LoKey;
  case FoI.LimitPages.LimitPagesType of
    lbtAuto:
      begin
        LimitAouto.Checked := True;
        EditLimit.Text := '0';
        EditPgPB.Text := '0';
        ShowLimit.Caption := IntToStr(FoI.LimitPages.LimitBuffers);
        ShowPages.Caption := IntToStr(FoI.LimitPages.PagesPerBuffer);
      end;
    lbtLimited:
      begin
        LimitLimited.Checked := True;
        EditLimit.Text := IntToStr(FoI.LimitPages.LimitBuffers);
        EditPgPB.Text := IntToStr(FoI.LimitPages.PagesPerBuffer);
        ShowLimit.Caption := '0';
        ShowPages.Caption := '0';
      end;
    lbtUnlimited:
      begin
        LimitUnlimited.Checked := True;
        EditLimit.Text := '0';
        EditPgPB.Text :=  '0';
        ShowLimit.Caption := '0';
        ShowPages.Caption := '0';
      end;
  end;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Ok := false;
  Close;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  Ok := false;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  if OD.Execute then
    NtxFileName.Text := OD.FileName;
end;

procedure TForm6.LimitLimitedClick(Sender: TObject);
begin
  if LimitLimited.Checked then
    EditLimit.Enabled := True
  else
    EditLimit.Enabled := False;
end;

end.
