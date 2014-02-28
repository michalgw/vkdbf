unit GrToExcel;

interface

uses
  Windows, Messages, SysUtils, Classes, Grids, DBGrids, Db, Graphics;

// Excel format
var
  XLSBOF: array[0..4] of Word = ($409, 6, 0, $10, 0);
  XLSGUTS: array[0..5] of Word = ($80, 8, 0, 0, 0, 0);
  XLSPalette: array[0..2] of Word = ($92, 0, 0);
  XLSDimension: array [0..6] of Word = ($200, $0A, 0, $FFFF, 0, $FF, 0);
  XLSEOF: array[0..1] of Word = ($0A, 0);
  XLSFONTH: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 8, 0);
  XLSFONTG: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 10, 0);
  XLSFONT: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 0, 0);
  XLSXF1: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, $F5, $FF, $20, 0, 0, $CE, 0, 0, 0, 0);
  XLSXF2: array[0..15] of Byte = ($43, 4, $0C, 0, 1, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF3: array[0..15] of Byte = ($43, 4, $0C, 0, 2, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF4: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, $F5, $FF, $20, $F4, 0, $CE, 0, 0, 0, 0);
  XLSXF5: array[0..15] of Byte = ($43, 4, $0C, 0, 0, 0, 1, 0, $20, 0, 0, $CE, 0, 0, 0, 0);
  XLSXF6: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $21, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF7: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $1F, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF8: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $20, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF9: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $1E, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF10: array[0..15] of Byte = ($43, 4, $0C, 0, 1, $0D, $F5, $FF, $20, $F8, 0, $CE, 0, 0, 0, 0);
  XLSXF: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $21, $78, $41, 3, 0, 0, 0, 0);
  XLSXFB: array[0..15] of Byte = ($43, 4, $0C, 0, 8, 0, 1, 0, $22, $78, $41, 2, $71, $71, $71, 0);
  XLSXFH: array[0..15] of Byte = ($43, 4, $0C, 0, 6, 0, 1, 0, $22, $78, $41, 2, $71, $71, $71, $71);
  XLSXFG: array[0..15] of Byte = ($43, 4, $0C, 0, 7, 0, 1, 0, $21, $78, $C1, 2, 0, 0, 0, 0);
  XLSXFF: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $22, $78, $C1, 2, $B9, $B9, $B9, $B9);
  XLSXFF1: array[0..15] of Byte = ($43, 4, $0C, 0, 5, 0, 1, 0, $22, $78, $C1, 2, $B9, 0, $B9, 0);
  XLSXFRF: array[0..15] of Byte = ($43, 4, $0C, 0, 9, 0, 1, 0, $21, $78, $C1, 2, $B9, $B9, $B9, $B9);
  XLSXFRF1: array[0..15] of Byte = ($43, 4, $0C, 0, 9, 0, 1, 0, $21, $78, $C1, 2, $B9, 0, $B9, 0);
  XLSCOL: array[0..7] of Word = ($7D, $0C, 0, 0, 0, $F, 0, 0);
  XLSSFONT: array[0..15] of Byte = ($31, 2, $0C, 0, $C8, 0, 0, 0, $FF, $7F, 5, $41, $72, $69, $61, $6C);
  XLSXT: array[0..13] of Byte = ($1E, 4, $A, 0, 0, 0, 7, $47, $65, $6E, $65, $72, $61, $6C);
  XLSXT1: array[0..14] of Byte = ($1E, 4, $B, 0, 0, 0, 8, $64, $64, $2F, $6D, $6D, $2F, $79, $79);
  XLSLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  XLSBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);
  XLSBlankF: array[0..4] of Word = ($201, 6, 0, 0, $19);
  XLSBlankRF: array[0..4] of Word = ($201, 6, 0, 0, $1C);
  XLSBlankH: array[0..4] of Word = ($201, 6, 0, 0, $16);
  XLSBlankB: array[0..4] of Word = ($201, 6, 0, 0, $1A);
  XLSNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  XLSRK: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  XLSFormula: array[0..15] of Word =($406, $1D, 0, 0, $18, 0, 0, 0, 0, 3, $0B, $25, 0, 0, 0, 0);

procedure GrToEx(Gr: TDBGrid; FileName: String);
function ColorToRGB(Color: TColor): Longint;

implementation

procedure GrToEx(Gr: TDBGrid; FileName: String);
var
  Stream: TFileStream;
  TotalCount: Integer;
  DS: TDataSet;
  bm: String;

  procedure DoBeginWritind;
  var
    C: LongInt;
    S: string;
    B: Byte;
    i: Integer;
  begin
    Stream.WriteBuffer(XLSBOF, SizeOf(XLSBOF));
    Stream.WriteBuffer(XLSGUTS, SizeOf(XLSGUTS));
    // XLS Palette
    XLSPalette[1] := 26;
    XLSPalette[2] := 6;
    Stream.WriteBuffer(XLSPalette, SizeOf(XLSPalette));

    //1
    if Gr.TitleFont.Color = clNone then
      C := 0
    else
      C := ColorToRGB(Gr.TitleFont.Color);
    Stream.WriteBuffer(C, SizeOf(C));

    //2
    if Gr.FixedColor = clNone then
      C := 0
    else
      C := ColorToRGB(Gr.FixedColor);
    Stream.WriteBuffer(C, SizeOf(C));

    //3
    if Gr.Font.Color = clNone then
      C := 0
    else
      C := ColorToRGB(Gr.Font.Color);
    Stream.WriteBuffer(C, SizeOf(C));

    //4
    if Gr.Color = clNone then
      C := 0
    else
      C := ColorToRGB(Gr.Color);
    Stream.WriteBuffer(C, SizeOf(C));

    //5
    C := ColorToRGB(clWindowFrame);
    Stream.WriteBuffer(C, SizeOf(C));

    //6
    C := ColorToRGB(clWindow);
    Stream.WriteBuffer(C, SizeOf(C));

    // XLS Font
    Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
    Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
    Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));
    Stream.WriteBuffer(XLSSFont, SizeOf(XLSSFont));

    // Grid Font
    S := Gr.Font.Name;
    B := Length(S);
    XLSFont[2] := B + 7;
    XLSFont[4] := Gr.Font.Size*20 mod 256;
    XLSFont[5] := Gr.Font.Size*20 div 256;
    XLSFont[6] := 0;
    if (fsBold in Gr.Font.Style) then XLSFont[6] := XLSFont[6] + 1;
    if (fsItalic in Gr.Font.Style) then XLSFont[6] := XLSFont[6] + 2;
    if (fsUnderline in Gr.Font.Style) then XLSFont[6] := XLSFont[6] + 4;
    if (fsStrikeOut in Gr.Font.Style) then XLSFont[6] := XLSFont[6] + 8;
    XLSFont[8] := 10;
    Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));

    // Header Font
    S := Gr.TitleFont.Name;
    B := Length(S);
    XLSFont[2] := B + 7;
    XLSFont[4] := Gr.TitleFont.Size*20 mod 256;
    XLSFont[5] := Gr.TitleFont.Size*20 div 256;
    XLSFont[6] := 0;
    if (fsBold in Gr.TitleFont.Style) then XLSFont[6] := XLSFont[6] + 1;
    if (fsItalic in Gr.TitleFont.Style) then XLSFont[6] := XLSFont[6] + 2;
    if (fsUnderline in Gr.TitleFont.Style) then XLSFont[6] := XLSFont[6] + 4;
    if (fsStrikeOut in Gr.TitleFont.Style) then XLSFont[6] := XLSFont[6] + 8;
    XLSFont[8] := 8;
    Stream.WriteBuffer(XLSFont, SizeOf(XLSFont));
    Stream.WriteBuffer(B, SizeOf(B));
    Stream.WriteBuffer(Pointer(S)^, Length(S));

    //Format Cell
    Stream.WriteBuffer(XLSXT, SizeOf(XLSXT));
    Stream.WriteBuffer(XLSXT1, SizeOf(XLSXT1));

    // Grid
    Stream.WriteBuffer(XLSXF1, SizeOf(XLSXF1));
    Stream.WriteBuffer(XLSXF2, SizeOf(XLSXF2));
    Stream.WriteBuffer(XLSXF2, SizeOf(XLSXF2));
    Stream.WriteBuffer(XLSXF3, SizeOf(XLSXF3));
    Stream.WriteBuffer(XLSXF3, SizeOf(XLSXF3));
    for i := 0 to 9 do
      Stream.WriteBuffer(XLSXF4, SizeOf(XLSXF4));
    Stream.WriteBuffer(XLSXF5, SizeOf(XLSXF5));
    Stream.WriteBuffer(XLSXF6, SizeOf(XLSXF6));
    Stream.WriteBuffer(XLSXF7, SizeOf(XLSXF7));
    Stream.WriteBuffer(XLSXF8, SizeOf(XLSXF8));
    Stream.WriteBuffer(XLSXF9, SizeOf(XLSXF9));
    Stream.WriteBuffer(XLSXF10, SizeOf(XLSXF10));
      XLSXF[12] := $A1;
      XLSXF[13] := $A1;
      XLSXF[14] := $A1;
      XLSXF[15] := $A1;
    Stream.WriteBuffer(XLSXF, SizeOf(XLSXF));

    //Header
    Stream.WriteBuffer(XLSXFH, SizeOf(XLSXFH)); //$16

    Stream.WriteBuffer(XLSXFG, SizeOf(XLSXFG));

    //Record
    XLSXFF[5] := $00;
    XLSXFF[8] := $22; //taCenter
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$18
    XLSXFF[8] := $21; //taLeftJustify
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$19
    XLSXFF[8] := $23; //taRightJustify
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$1A

    //Record for ftDateTime
    XLSXFF[5] := $01;
    XLSXFF[8] := $22; //taCenter
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$1B
    XLSXFF[8] := $21; //taLeftJustify
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$1C
    XLSXFF[8] := $23; //taRightJustify
    Stream.WriteBuffer(XLSXFF, SizeOf(XLSXFF)); //$1D

    Stream.WriteBuffer(XLSXFF1, SizeOf(XLSXFF1));   //$1E
    Stream.WriteBuffer(XLSXFB, SizeOf(XLSXFB));     //$1F
    Stream.WriteBuffer(XLSXFRF, SizeOf(XLSXFRF));   //$20
    Stream.WriteBuffer(XLSXFRF1, SizeOf(XLSXFRF1)); //$21

    // Columns
    for i := 0 to Gr.Columns.Count - 1 do
    begin
      XLSCOL[2] := i;
      XLSCOL[3] := i;
      XLSCOL[4] := 36 * Gr.Columns[i].Width;
      Stream.WriteBuffer(XLSCOL, SizeOf(XLSCOL));
    end;
    Stream.WriteBuffer(XLSDimension, SizeOf(XLSDimension));
  end;

  procedure DoWriteHeader;
  var
    i: Integer;
    S: String;
  begin
    // Draw Heders
    for i := 0 to  Gr.Columns.Count - 1 do
    begin
      S := Gr.Columns[i].Title.Caption;
      XLSLAbel[1] := Length(S) + 8;
      XLSLabel[2] := TotalCount;
      XLSLabel[3] := i;
      XLSLabel[4] := $16;
      XLSLabel[5] := Length(S);
      Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
      Stream.WriteBuffer(Pointer(S)^, Length(S));
    end;
    Inc(TotalCount);
  end;

  procedure DoWriteRecord;
  var
    i: Integer;
    S: String;
    C: Integer;
    F: Double;
    FMT: Word;
  begin
    for i := 0 to  Gr.Columns.Count - 1 do
    begin
      if not (Gr.Columns[i].Field.DataType in [ftDate, ftDateTime, ftTime]) then begin
        case Gr.Columns[i].Alignment of
         taLeftJustify : FMT := $19;
         taCenter : FMT := $18;
         taRightJustify : FMT := $1A;
        else
          FMT := $18;
        end;
      end else begin
        case Gr.Columns[i].Alignment of
         taLeftJustify : FMT := $1C;
         taCenter : FMT := $1B;
         taRightJustify : FMT := $1D;
        else
          FMT := $1B;
        end;
      end;
      if not Gr.Columns[i].Field.IsNull then begin
        case Gr.Columns[i].Field.DataType of
          ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
          begin
            C := Gr.Columns[i].Field.AsInteger;
            C := C shl 2 + 2;
            XLSRK[2] := TotalCount;
            XLSRK[3] := i;
            XLSRK[4] := FMT;
            Stream.WriteBuffer(XLSRK, SizeOf(XLSRK));
            Stream.WriteBuffer(C, SizeOf(C));
          end;
          ftFloat, ftCurrency, ftBCD, ftDate, ftDateTime, ftTime:
          begin
            F := Gr.Columns[i].Field.AsFloat;
            XLSNumber[2] := TotalCount;
            XLSNumber[3] := i;
            XLSNumber[4] := FMT;
            Stream.WriteBuffer(XLSNumber, SizeOf(XLSNumber));
            Stream.WriteBuffer(F, SizeOf(F));
          end;
        else
          S := Gr.Columns[i].Field.AsString;
          XLSLAbel[1] := Length(S) + 8;
          XLSLabel[2] := TotalCount;
          XLSLabel[3] := i;
          XLSLabel[4] := FMT;
          XLSLabel[5] := Length(S);
          Stream.WriteBuffer(XLSLabel, SizeOf(XLSLabel));
          Stream.WriteBuffer(Pointer(S)^, Length(S));
        end;
      end else begin
        XLSBlank[2] := TotalCount;
        XLSBlank[3] := i;
        XLSBlank[4] := FMT;
        Stream.WriteBuffer(XLSBlank, SizeOf(XLSBlank));
      end;
    end;
    Inc(TotalCount);
  end;

  procedure DoEndWriting;
  begin
    Stream.WriteBuffer(XLSEOF, SizeOf(XLSEOF));
  end;

begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    DoBeginWritind;
    TotalCount := 0;
    DoWriteHeader;
    DS := Gr.DataSource.DataSet;
    if (DS <> nil) and DS.Active then begin
      bm := DS.Bookmark;
      DS.DisableControls;
      try
        DS.First;
        while not DS.Eof do begin
          DoWriteRecord;
          DS.Next;
        end;
      finally
        DS.Bookmark := bm;
        DS.EnableControls;
      end;
    end;
    DoEndWriting;
  finally
    Stream.Free;
    Stream := nil;
  end;
end;

function ColorToRGB(Color: TColor): Longint;
begin
  if Color < 0 then
    Result := GetSysColor(Color and $000000FF) else
    Result := Color;
end;

end.
