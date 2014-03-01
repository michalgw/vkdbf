unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, VKDBFDataSet, VKDBFNTX, VKDBFIndex, VKDBFSorters,
  ExtCtrls, db;

type
  TForm5 = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    OD: TOpenDialog;
    Button2: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    Button16: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    procedure Button15Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure qqqqq(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    //procedure Button12Click(Sender: TObject);
    //procedure Button13Click(Sender: TObject);
    //procedure Button14Click(Sender: TObject);
    //procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
    ff: Integer;
    function GetHashType: TVKHashTypeForTreeSorters;
    function GetMaxBitsInHashCode:TVKMaxBitsInHashCode;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit2, Unit6;

{$R *.DFM}

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  Close;
end;

constructor TForm5.Create(AOwner: TComponent);
var
  oD: TVKDBFNTX;
  i: Integer;
begin
  inherited Create(AOwner);
  oD := TForm2(AOwner).DBFNTX1;
  ListView1.Items.Clear;
  with ListView1.Items.Add do begin
    Caption := 'Physical order (recno)';
    Data := Pointer(0);
    if oD.Indexes.ActiveObject = nil then Selected := true;
  end;
  for i := 0 to oD.Indexes.Count - 1 do begin
    with ListView1.Items.Add do begin
      Caption := TVKNTXIndex(oD.Indexes[i]).NTXFileName;
      Data := Pointer(i + 1);
      SubItems.Add(TVKNTXIndex(oD.Indexes[i]).KeyExpresion);
      if oD.Indexes.ActiveObject = TVKNTXIndex(oD.Indexes[i]) then Selected := true;
    end;
  end;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  if OD.Execute then begin
    oI := TVKNTXIndex(oT.Indexes.Add);
    oI.NTXFileName := OD.FileName;
    oP := TForm6.Create(self);
    oP.oI := oI;
    oP.ShowModal;
    FreeAndNil(oP);
    if oT.Active then begin
      oI.Open;
      oI.Active := true;
    end;
    with ListView1.Items.Add do begin
      Caption := oI.NTXFileName;
      i := oI.Index + 1;
      Data := Pointer(i);
      SubItems.Add(oI.KeyExpresion);
      Selected := true;
    end;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.ListView1DblClick(Sender: TObject);
begin
  Close;
end;

procedure TForm5.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  oT: TVKDBFNTX;
begin
  oT := TForm2(Owner).DBFNTX1;
  if ListView1.Selected <> nil then
    oT.SetOrder(Integer(ListView1.Selected.Data));
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  oP: TForm6;
  oT: TVKDBFNTX;
  oI: TVKNTXIndex;
  i: Integer;
begin
  if ListView1.Selected <> nil then begin
    oT := TForm2(Owner).DBFNTX1;
    i := Integer(ListView1.Selected.Data);
    if i > 0 then begin
      oI := TVKNTXIndex(oT.Indexes[i - 1]);
      oP := TForm6.Create(self);
      try
        oP.oI := oI;
        oP.ShowModal;
      finally
        oP.Free;
      end;
    end;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.qqqqq(DataSet: TDataSet);
var
  www: String;
begin
  www := IntToStr(DataSet.Tag);
  Label3.Caption := www;
  www := www + chr(13) + chr(10);
  FileSeek(ff, 0, 0);
  FileWrite(ff, pChar(www)^, length(www));
  Application.ProcessMessages;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      //ff := FileCreate('qq.txt');
      //oT.OnNewRecord := qqqqq;
      oI.CreateIndex;
      //FileClose(ff);
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button5Click(Sender: TObject);
var
  oT: TVKDBFNTX;
  oI: TVKNTXIndex;
  i: Integer;
begin
  if ListView1.Selected <> nil then begin
    oT := TForm2(Owner).DBFNTX1;
    i := Integer(ListView1.Selected.Data);
    if i > 0 then begin
      oI := TVKNTXIndex(oT.Indexes[i - 1]);
      oI.Reindex;
      ShowMessage('Ok');
    end;
    oT.Refresh;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button6Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateCompactIndex;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button7Click(Sender: TObject);
var
  oT: TVKDBFNTX;
  i: Integer;
begin
  if ListView1.Selected <> nil then begin
    oT := TForm2(Owner).DBFNTX1;
    i := Integer(ListView1.Selected.Data);
    if i > 0 then begin
      oT.Indexes.Delete(i - 1);
      ListView1.Items.Delete(ListView1.Selected.Index);
      ShowMessage('Ok');
    end;
    oT.Refresh;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button8Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingQuickSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button9Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingTreeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button10Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingRBTreeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button11Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingAVLTreeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

function TForm5.GetHashType: TVKHashTypeForTreeSorters;
begin
  Result := httsDefault;
  if ComboBox1.Text = 'httsDefault' then Result := httsDefault;
  if ComboBox1.Text = 'htts2048'    then Result := htts2048;
  if ComboBox1.Text = 'htts4096'    then Result := htts4096;
  if ComboBox1.Text = 'htts8192'    then Result := htts8192;
  if ComboBox1.Text = 'htts16384'   then Result := htts16384;
  if ComboBox1.Text = 'htts32768'   then Result := htts32768;
  if ComboBox1.Text = 'htts65536'   then Result := htts65536;
  if ComboBox1.Text = 'htts131072'  then Result := htts131072;
  if ComboBox1.Text = 'htts262144'  then Result := htts262144;
  if ComboBox1.Text = 'htts524288'  then Result := htts524288;
end;

function TForm5.GetMaxBitsInHashCode: TVKMaxBitsInHashCode;
begin
  Result := VKDBFIndex.mbhc32;
  if ComboBox2.Text = 'mbhc0' then Result := VKDBFIndex.mbhc0;
  if ComboBox2.Text = 'mbhc1' then Result := VKDBFIndex.mbhc1;
  if ComboBox2.Text = 'mbhc2' then Result := VKDBFIndex.mbhc2;
  if ComboBox2.Text = 'mbhc3' then Result := VKDBFIndex.mbhc3;
  if ComboBox2.Text = 'mbhc4' then Result := VKDBFIndex.mbhc4;
  if ComboBox2.Text = 'mbhc5' then Result := VKDBFIndex.mbhc5;
  if ComboBox2.Text = 'mbhc6' then Result := VKDBFIndex.mbhc6;
  if ComboBox2.Text = 'mbhc7' then Result := VKDBFIndex.mbhc7;
  if ComboBox2.Text = 'mbhc8' then Result := VKDBFIndex.mbhc8;
  if ComboBox2.Text = 'mbhc9' then Result := VKDBFIndex.mbhc9;
  if ComboBox2.Text = 'mbhc10' then Result := VKDBFIndex.mbhc10;
  if ComboBox2.Text = 'mbhc11' then Result := VKDBFIndex.mbhc11;
  if ComboBox2.Text = 'mbhc12' then Result := VKDBFIndex.mbhc12;
  if ComboBox2.Text = 'mbhc13' then Result := VKDBFIndex.mbhc13;
  if ComboBox2.Text = 'mbhc14' then Result := VKDBFIndex.mbhc14;
  if ComboBox2.Text = 'mbhc15' then Result := VKDBFIndex.mbhc15;
  if ComboBox2.Text = 'mbhc16' then Result := VKDBFIndex.mbhc16;
  if ComboBox2.Text = 'mbhc17' then Result := VKDBFIndex.mbhc17;
  if ComboBox2.Text = 'mbhc18' then Result := VKDBFIndex.mbhc18;
  if ComboBox2.Text = 'mbhc19' then Result := VKDBFIndex.mbhc19;
  if ComboBox2.Text = 'mbhc20' then Result := VKDBFIndex.mbhc20;
  if ComboBox2.Text = 'mbhc21' then Result := VKDBFIndex.mbhc21;
  if ComboBox2.Text = 'mbhc22' then Result := VKDBFIndex.mbhc22;
  if ComboBox2.Text = 'mbhc23' then Result := VKDBFIndex.mbhc23;
  if ComboBox2.Text = 'mbhc24' then Result := VKDBFIndex.mbhc24;
  if ComboBox2.Text = 'mbhc25' then Result := VKDBFIndex.mbhc25;
  if ComboBox2.Text = 'mbhc26' then Result := VKDBFIndex.mbhc26;
  if ComboBox2.Text = 'mbhc27' then Result := VKDBFIndex.mbhc27;
  if ComboBox2.Text = 'mbhc28' then Result := VKDBFIndex.mbhc28;
  if ComboBox2.Text = 'mbhc29' then Result := VKDBFIndex.mbhc29;
  if ComboBox2.Text = 'mbhc30' then Result := VKDBFIndex.mbhc30;
  if ComboBox2.Text = 'mbhc31' then Result := VKDBFIndex.mbhc31;
  if ComboBox2.Text = 'mbhc32' then Result := VKDBFIndex.mbhc32;
end;

(*
procedure TForm5.Button12Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter, True, 524288);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter, True, 1048576);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter, True, 2097152);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKAVLTreeSorter);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKAVLTreeSorter, True, 524288);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRAMBinaryTreeSorter);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRAMBinaryTreeSorter, True, 524288 { 65536 } );
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRAMBinaryTreeSorter, True, 1048576);
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRAMBinaryTreeSorter, True, 4096 { 65536 } );
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRAMBinaryTreeSorter, True, 73 );
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter  { TVKRAMBinaryTreeSorter }, True, 73 );
      //oI.CreateIndexUsingMergeBinaryTreeAndBTree(TVKRedBlackTreeSorter  { TVKRAMBinaryTreeSorter });
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;
*)

(*
procedure TForm5.Button13Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.CreateIndexUsingBTreeHeapSort();
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;
*)

(*
procedure TForm5.Button14Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRedBlackTreeSorter);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRedBlackTreeSorter, True, 524288);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRedBlackTreeSorter, True, 1048576);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRedBlackTreeSorter, True, 2097152);
      oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKAVLTreeSorter);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKAVLTreeSorter, True, 524288);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRAMBinaryTreeSorter);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRAMBinaryTreeSorter, True, 524288);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRAMBinaryTreeSorter, True, 1048576);
      //oI.CreateIndexUsingFindMinsAndJoinItToBTree(TVKRAMBinaryTreeSorter, True, 2097152);
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;
*)

(*
procedure TForm5.Button15Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter);
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter, True, 524288);
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter, True, 1048576);
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter, True, 2097152);
      oI.CreateIndexUsingAbsorption(TVKAVLTreeSorter);
      //oI.CreateIndexUsingAbsorption(TVKAVLTreeSorter, True, 524288);
      //oI.CreateIndexUsingAbsorption(TVKRAMBinaryTreeSorter);
      //oI.CreateIndexUsingAbsorption(TVKRAMBinaryTreeSorter, True, 524288 { 65536 } );
      //oI.CreateIndexUsingAbsorption(TVKRAMBinaryTreeSorter, True, 1048576);
      //oI.CreateIndexUsingAbsorption(TVKRAMBinaryTreeSorter, True, 4096 { 65536 } );
      //oI.CreateIndexUsingAbsorption(TVKRAMBinaryTreeSorter, True, 73 );
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter  { TVKRAMBinaryTreeSorter }, True, 73 );
      //oI.CreateIndexUsingAbsorption(TVKRedBlackTreeSorter  { TVKRAMBinaryTreeSorter });
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;
*)

procedure TForm5.Button16Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingTrieTreeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button12Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsingMergeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button13Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsing4PathMergeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button14Click(Sender: TObject);
var
  d: TDateTime;
  Hour, Min, Sec, MSec: Word;
  oT: TVKDBFNTX;
  i: Integer;
  oI: TVKNTXIndex;
  oP: TForm6;
begin
  oT := TForm2(Owner).DBFNTX1;
  oI := TVKNTXIndex(oT.Indexes.Add);
  oP := TForm6.Create(self);
  try
    oP.oI:= oI;
    oP.ShowModal;
    if oP.Ok then begin
      d := now;
      oI.HashTypeForTreeSorters := GetHashType;
      oI.MaxBitsInHashCode := GetMaxBitsInHashCode;
      oI.CreateIndexUsing8PathMergeSort;
      d := (now - d);
      DecodeTime(d, Hour, Min, Sec, MSec);
      ShowMessage(Format('%d:%d:%d:%d', [Hour, Min, Sec, MSec]));
      with ListView1.Items.Add do begin
        Caption := oI.NTXFileName;
        i := oI.Index + 1;
        Data := Pointer(i);
        SubItems.Add(oI.KeyExpresion);
        Selected := true;
      end;
    end else
      oT.Indexes.Delete(oI.Index);
  finally
    oP.Free;
  end;
  ActiveControl := ListView1;
end;

procedure TForm5.Button15Click(Sender: TObject);
var
  oT: TVKDBFNTX;
  oI: TVKNTXIndex;
  i: Integer;
begin
  if ListView1.Selected <> nil then begin
    oT := TForm2(Owner).DBFNTX1;
    i := Integer(ListView1.Selected.Data);
    if i > 0 then begin
      oI := TVKNTXIndex(oT.Indexes[i - 1]);
      oI.VerifyIndex;
      ShowMessage('Ok');
    end;
    oT.Refresh;
  end;
  ActiveControl := ListView1;
end;

end.
