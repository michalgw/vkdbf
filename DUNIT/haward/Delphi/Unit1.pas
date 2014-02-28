unit Unit1;

interface

//{$DEFINE VKDBF_LOGGIN}

uses
  {$IFDEF VKDBF_LOGGIN}VKDBFLogger,{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, VKDBFDataSet, ExtCtrls, DBCtrls, DBTables,
  StdCtrls;

type
  TForm1 = class(TForm)
    db: TVKDBFNTX;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Edit1: TEdit;
    db1: TVKDBFNTX;
    Label1: TLabel;
    Memo1: TMemo;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i, t, k, l, m, id, recno: integer;
  oldtm, tm, b: string;
  f: TextFile;
begin
  db.Active := true;
  //db1.Active:=true;
  Label1.Caption := 'Open';
  Application.ProcessMessages;
  k := 0;
  l := 0;
  m := StrToInt(Edit1.Text);
  Label1.Caption := 'Start';
  Application.ProcessMessages;
  Button1.Enabled := false;
  db.Last;
  //db.First;
  while not db.bof do
  //while not db.eof do
  begin
    t:=GetTickCount;

    //Memo1.Lines.Add(IntToStr(db.RecNo) + ' ');
    //if db.RLock(db.RecNo) then
    //if db.RLock() then
    {$IFDEF VKDBF_LOGGIN}
    VKDBFLogger.log.Write('db.RLock(db.RecNo): ' + IntToStr(db.RecNo));
    {$ENDIF}
    if db.RLock(db.RecNo) then
    begin
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Edit;');
      {$ENDIF}
      db.Edit;
      l := db.FieldByName('num').AsInteger;
      oldtm := IntToStr(db.FieldByName('tm').AsInteger);
      //        id:=db.FieldByName('id').AsInteger;
      //         recno:=db.RecNo;
      tm := oldtm + Edit1.Text;
      db.FieldByName('num').AsInteger := l + m;
      db.FieldByName('tm').AsInteger := StrToInt(tm);
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Post;');
      {$ENDIF}
      db.Post;
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Unlock;');
      {$ENDIF}
      db.Unlock;
//      Application.ProcessMessages;
      //       sleep(50);
      //       db1.AppendRecord([id,recno,oldtm,l,tm,l+m]);
      t:=GetTickCount()-t;
      k:=k+t;
      if k > 1000 then
       begin
        Caption:= IntToStr(db.RecNo);
        Application.ProcessMessages;
        k:=0;
       end;

    end
    else
      Memo1.Lines.Add('Ne udalos zablokirivat zapis N' + IntToStr(db.RecNo));
    db.Prior;
    //db.Next;
//    k := t;
  end;
  Label1.Caption := 'Stop';
  db.Close;
  //db1.Close;
  Button1.Enabled := true;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i, t, k, l, m, id, recno: integer;
  oldtm, tm, b: string;
  f: TextFile;
begin
  db.Active := true;
  Label1.Caption := 'Open';
  Application.ProcessMessages;
  k := 0;
  l := 0;
  m := StrToInt(Edit1.Text);
  Label1.Caption := 'Start';
  Application.ProcessMessages;
  Button1.Enabled := false;
  db.Last;
  while not db.Bof do
  begin
    t:=GetTickCount;

    if db.RLock(db.RecNo) then
    begin
      db.Edit;
      l := db.FieldByName('num').AsInteger;
      oldtm := IntToStr(db.FieldByName('tm').AsInteger);
      //        id:=db.FieldByName('id').AsInteger;
      //         recno:=db.RecNo;
      //tm := oldtm + Edit1.Text;
      tm := Edit1.Text;
      db.FieldByName('num').AsInteger := 1;
      db.FieldByName('tm').AsInteger := StrToInt(tm);
      db.Post;
      db.Unlock;
//      Application.ProcessMessages;
      //       sleep(50);
      //       db1.AppendRecord([id,recno,oldtm,l,tm,l+m]);
      t:=GetTickCount()-t;
      k:=k+t;
      if k > 1000 then
       begin
        Caption:= IntToStr(db.RecNo);
        Application.ProcessMessages;
        k:=0;
       end;

    end
    else
      Memo1.Lines.Add('Ne udalos zablokirivat zapis N' + IntToStr(db.RecNo));
    db.Prior;
    //db.Next;
//    k := t;
  end;
  Label1.Caption := 'Stop';
  db.Close;
  //db1.Close;
  Button1.Enabled := true;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, t, k, l, m, id, recno: integer;
  oldtm, tm, b: string;
  f: TextFile;
begin
  db.Active := true;
  //db1.Active:=true;
  Label1.Caption := 'Open';
  Application.ProcessMessages;
  k := 0;
  l := 0;
  m := StrToInt(Edit1.Text);
  Label1.Caption := 'Start';
  Application.ProcessMessages;
  Button1.Enabled := false;
  db.First;
  while not db.eof do
  begin
    t:=GetTickCount;

    //Memo1.Lines.Add(IntToStr(db.RecNo) + ' ');
    //if db.RLock(db.RecNo) then
    //if db.RLock() then
    {$IFDEF VKDBF_LOGGIN}
    VKDBFLogger.log.Write('db.RLock(db.RecNo): ' + IntToStr(db.RecNo));
    {$ENDIF}
    if db.RLock(db.RecNo) then
    begin
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Edit;');
      {$ENDIF}
      db.Edit;
      l := db.FieldByName('num').AsInteger;
      oldtm := IntToStr(db.FieldByName('tm').AsInteger);
      //        id:=db.FieldByName('id').AsInteger;
      //         recno:=db.RecNo;
      tm := oldtm + Edit1.Text;
      db.FieldByName('num').AsInteger := l + m;
      db.FieldByName('tm').AsInteger := StrToInt(tm);
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Post;');
      {$ENDIF}
      db.Post;
      {$IFDEF VKDBF_LOGGIN}
      VKDBFLogger.log.Write('db.Unlock;');
      {$ENDIF}
      db.Unlock;
//      Application.ProcessMessages;
      //       sleep(50);
      //       db1.AppendRecord([id,recno,oldtm,l,tm,l+m]);
      t:=GetTickCount()-t;
      k:=k+t;
      if k > 1000 then
       begin
        Caption:= IntToStr(db.RecNo);
        Application.ProcessMessages;
        k:=0;
       end;

    end
    else
      Memo1.Lines.Add('Ne udalos zablokirivat zapis N' + IntToStr(db.RecNo));
    db.Next;
//    k := t;
  end;
  Label1.Caption := 'Stop';
  db.Close;
  //db1.Close;
  Button1.Enabled := true;
end;

end.
