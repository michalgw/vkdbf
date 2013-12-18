unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin;

const
   CDXBlokSize = 512;
   ExtSpace = CDXBlokSize-24;

type

  pCDXHeader  = ^CDXHeader;
  CDXHeader  = packed Record
    Root       : LongInt;                {byte offset to root node}
    FreePtr    : LongInt;                {byte offset to next free block}
    ChgFlag    : Longint;                {Increments on modification}
    Key_Lgth   : Word;                   {length of key}
    IndexOpts  : Byte;
                         {bit field :   1 = unique
                                        8 = FOR clause
                                       32 = compact index
                                       64 = compound index}
    IndexSig   : Byte;
    Reserve3   : array [0..477] of Byte;
    Col8Kind   : array[0..7] of Char;
    AscDesc    : Word;     {0 = ascending; 1=descending}
    Reserve4   : Word;
    ForExpLen  : Word;     {length of FOR clause}
    Reserve5   : Word;
    KeyExpLen  : Word;     {length of index expression}
    KeyPool    : array[0..pred(CDXBlokSize)] of char;
  end;

   pCDXDataBlk  = ^CDXDataBlk;
   CDXDataBlk  = packed Record
      Node_Atr     : word;
      Entry_Ct     : word;
      Left_Ptr     : longint;
      Rght_Ptr     : Longint;
         case byte of
            0   :  (
                    FreeSpace  : Word;    {free space in this key}
                    RecNumMask : LongInt; {bit mask for record number}
                    DupCntMask : Byte;    {bit mask for duplicate byte count}
                    TrlCntMask : Byte;    {bit mask for trailing bytes count}
                    RecNumBits : Byte;    {num bits used for record number}
                    DupCntBits : Byte;    {num bits used for duplicate count}
                    TrlCntBits : Byte;    {num bits used for trail count}
                    ShortBytes : Byte;    {bytes needed for recno+dups+trail}
                    ExtData    : array [0..CDXBlokSize - 25] of Char;
                   );
            1    : (IntData  : array [0..CDXBlokSize - 13] of Char;)
   end;

   pCDXElement = ^CDXElement;
   CDXElement = packed Record
      Block_Ax  : Longint;
      Recrd_Ax  : Longint;
      Char_Fld  : array [0..255] of char;
   end;

  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
