project "rasschet"
include "domains.pro"
global predicates
  lecload(reallist,reallist,real,real)-(i,i,i,o).
  groupload(reallist,reallist,real,real)-(i,i,i,o).
  curhelp(reallist,reallist,real,real)-(i,i,i,o).
  examhelp(reallist,reallist,real,real)-(i,i,i,o).
  kurswork(reallist,reallist,real,real)-(i,i,i,o).
  lecexam(reallist,reallist,real,real)-(i,i,i,o).
  groupexam(reallist,reallist,real,real)-(i,i,i,o).
  test(reallist,reallist,real,real)-(i,i,i,o).
  leccoll(reallist,reallist,real,real)-(i,i,i,o).
  groupcoll(reallist,reallist,real,real)-(i,i,i,o).
  contrwork(reallist,reallist,real,real)-(i,i,i,o).
  homework(reallist,reallist,real,real)-(i,i,i,o).
  choice(integer,integer)-(o,i).
  menuop(integer)-(i).
  menupos(integer,integer,integer)-(o,i,o).
  key(integer)-(o),(i).
  cursoron.
  cursoroff.
  deletewindows(integer)-(i).
  cleardatabase.
  insert(reallist,real,integer,reallist)-(i,i,i,o).
  take(reallist,integer,real)-(i,i,o).
  connect(stringlist,stringlist,stringlist)-(i,i,o).
  insertstr(stringlist,string,integer,stringlist)-(i,i,i,o).
  takestr(stringlist,integer,string)-(i,i,o).
  filename(string,string)-(i,o).
  str_of_empty(integer,integer,string)-(i,i,o).
  conver(real,string)-(i,o).
clauses
 /********************** Р а с ч е т   н а г р у з о к *********************

               СТОИМОСТЬ:          ЧИСЛО ЧАСОВ:
               экзамена     C1     число групп  N1     численность Num
               зачета       C2     лекции       N2
               коллоквиума  C3     семинары     N3
               контрольной  C4     лабораторные N4
               консультации C5     контрольные  N5
               курсовой     C6     Д/З          N6
                                   коллоквиумы  N7
                                   зачет        N8
                                   экзамен      N9
                                   курсовик     N10
*/  
  lecload([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=N2+(N1*Num*N9*C1/2)+(N1*Num*N7*C3/3)+2*N1*N9+N2*N1*C5.
  
  groupload([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=N3+N4+(Num*N9*C1/2)+(Num*N7*C3/2)+(N8*Num*C2)+
      (N6+N5)*Num*C4+(Num*N10*C6).
  
  curhelp([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=N2*N1*C5.
  
  examhelp([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=2*N1*N9.
  
  kurswork([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=Num*N10*C6.
  
  lecexam([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=0.5*N1*N9*C1*Num.
  
  groupexam([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=0.5*N9*Num*C1.
  
  test([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=N8*Num*C2.
  
  leccoll([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=N7*N1*Num*C3/3.
  
  groupcoll([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=0.5*N7*Num*C3.
  
  contrwork([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=Num*N5*C4.
  
  homework([C1,C2,C3,C4,C5,C6],[N1,N2,N3,N4,N5,N6,N7,N8,N9,N10],Num,Out):-
  Out=Num*N6*C4.

  menuop(1):- write("Ввод данных"),!.
  menuop(3):- write("Распределение"),!.
  menuop(5):- write("Протоколы"),!.
  menuop(7):- write("Выход"),!.
  menupos(7,1,3):-!.
  menupos(1,3,5):-!.
  menupos(3,5,7):-!.
  menupos(5,7,1):-!.
  choice(Pred,72):- shiftwindow(2),cursor(Row,_),
                    menupos(Pred,Row,_),cursor(Pred,2),
                    shiftwindow(3),removewindow,
                    Row1=Pred+8,makewindow(3,31,0,"",Row1,29,1,15),
                    cursor(0,1),menuop(Pred).
  choice(Next,80):- shiftwindow(2),cursor(Row,_),
                    menupos(_,Row,Next),cursor(Next,2),
                    shiftwindow(3),removewindow,
                    Row1=Next+8,makewindow(3,31,0,"",Row1,29,1,15),
                    cursor(0,1),menuop(Next).
  choice(Row,13):- shiftwindow(2),cursor(Row,_).
  key(Code):- readchar(Key),char_int(Key,Code),not(Code=0),!.
  key(Code):- readchar(Key),char_int(Key,Code).
  cursoroff:- bios($10,reg($100,0,$2000,0,0,0,0,0),reg(_,_,_,_,_,_,_,_)).
  cursoron:-  bios($10,reg($100,0,$607,0,0,0,0,0),reg(_,_,_,_,_,_,_,_)).
  deletewindows(1):-!.                            
  deletewindows(Lastwindow):-  shiftwindow(Lastwindow),
                               removewindow,
                               Beforewindow=Lastwindow-1,
                               deletewindows(Beforewindow).
  cleardatabase:- retractall(_),fail.
  cleardatabase.
  insert([H|T],V,1,[V|T]):-!.
  insert([H|T],V,Pos,Out):-Cur=Pos-1,insert(T,V,Cur,Out1),Out=[H|Out1].
  take([H|T],1,H):-!.
  take([H|T],Num,Out):-Num1=Num-1,take(T,Num1,Out).
  connect([],Q,Q):-!.
  connect([HP|TP],Q,[HP|TR]):-connect(TP,Q,TR).
  insertstr([H|T],V,1,[V|T]):-!.
  insertstr([H|T],V,Pos,Out):-Cur=Pos-1,insertstr(T,V,Cur,Out1),Out=[H|Out1].
  takestr([H|T],1,H):-!.
  takestr([],_,""):-!.
  takestr([H|T],Num,Out):-Num1=Num-1,takestr(T,Num1,Out).
  filename(Title,Name):-makewindow(6,31,15,Title,20,22,3,29),
   		        cursor(0,1),cursoron,readln(Name),removewindow.
  str_of_empty(Busy,Busy,""):-!.
  str_of_empty(Busy,All,Str):-All1=All-1,
                              str_of_empty(Busy,All1,Str1),
                              concat(Str1," ",Str).
  conver(Val,Str):-V=trunc(Val)+round(10*(Val-trunc(Val)))/10,
                   str_real(Str,V),!.
