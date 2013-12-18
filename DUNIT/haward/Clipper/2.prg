set confirm on
sele 1
use test shared
if neterr()
  alert('Ошибка открытия')
  return
endif
/*sele 2
use log shared
if neterr()
  alert('Ошибка открытия')
  return
endif*/
a=1
@0,0 say '=>' get a picture '9'
read
_tm1=0
_tm0=seconds()
sele 1
//go bottom
do while !eof()
//do while !bof()
  do while !rlock()
  enddo
  _oldtm=tm
  _newtm=val(alltrim(str(tm))+str(a,1))
  _oldnum=num
  _newnum=num+a
  _rn=recno()
  repl num with _newnum,tm with _newtm
  //commit
  unlock
  skip
  /*sele 2
  dbappend()
  do while neterr()
  enddo
  repl id with a,recno with _rn,oldnum with _oldnum,oldtm with _oldtm,newnum with _newnum,newtm with _newtm
  unlock
  sele 1*/
enddo
_tm1=seconds()
//?sectotime(_tm1-_tm0,.t.)
