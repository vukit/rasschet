project "rasschet"
include "domains.pro"

global database
  cost(reallist,reallist).
  flow(string,real).
  discipline(string,string,reallist,stringlist).
  person(string,reallist).
  actdata(string,string,char).
  list(integer,stringlist).
  num_tab(integerlist,reallist).

global predicates
/********************** Предикаты расчета нагрузки *************************/   
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
/************************* Общие предикаты ****************************/  
  menuop(integer)-(i).
  menupos(integer,integer,integer)-(o,i,o).
  choice(integer,integer)-(o,i).
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
predicates
  repeat.
/*************** Окна скроллера и выбора ************************************/
  choice_win(integer,integer,integer,string,
            integer,integer,integer,integer,string).
    dochoice(integer,string,integer).
    initchoice(string,integer).           
  findflow.
  finddiscipline.
  scroll_win(integer,integer,integer,integer,
                  integer,integer,integer,integer).
    h(integer,string).
    print(stringlist).
    printtext(integer,stringlist).
    printlist(stringlist,integer,integer,integer).
    viewlist(integer,integer,integer).
    view(integer,integer,integer).
/********************** Предикаты главного меню ****************************/ 
 start.
 menu.
 process(integer).

/********************** Предикаты ввода данных *****************************/
 datamenu.
 indata(integer).
  dataop(integer).
  datapos(integer,integer,integer).
  statusline(integer).
  datafile(string).
  createfile(char,string).
  recount.
  retake(stringlist,integer).
  callevalload(string,integer).
  inputcoast.
     coastpunkt(stringlist).
     typepunktcoast(stringlist,integer).
     writecoast(reallist,integer).
     printcoast.
     delinput(integer).
     poscoast(integer,integer,integer,integer).
     inputc(integer,integer).
     cost_to_db.
   inputflows.
     posflows(integer,integer,integer).
     inputf(integer,integer).
     contrcost(stringlist).
     flowspunkt(stringlist).
     typepunktflows(stringlist,integer).   
     typevalue(reallist,integer).
     evalcost.
     creatlist(stringlist,integer,stringlist).
     clfleid(integer).
     clcost(integer).
     flow_to_db(string,integer).

/************************ Предикаты распределения **************************/ 
 findfile(string).
 distrpos(integer,integer,integer).
 statuslinedistr(integer).
 distribution.
   inputd(integer,integer).
   in_to_actdata(integer,string).
   clearwin(integer).
   printflow.
   writeflow(string,integer,integer).
   posgroup(integer,integer,integer,integer).
   name_to_db(string,integer).
   distrpersonal.
   printname(stringlist,integer,integer).
   findperson(string,integer).
   takecost(reallist).
   evalload(string,integer,integer).
   increase(string,integer,integer).
   groups(stringlist,integer).
   lector(string,string).
   includestr(string,integer).
   listvacantion.
   printload.
   person_to_db(string,integer,char).
   inputperson(integer,integer).

/*************************** Предикаты протоколов **************************/
  createdatabase(integer).
  formstr(string,reallist,string).
  createlist.
  protocol(integer,string).    
  loadperson(string).
  restorename.
  summary.
  total(real,real,real,real).
  distributionlist(string,stringlist,integer).
  flowlist(string).
  controllook(integer).
  lookdistribution.
  loaddiscipline(string).
  flow_discip. 
goal 
  makewindow(1,6,0,"",0,0,25,80),
  clearwindow,
  cursor(0,63),write("   Written by "),
  cursor(1,63),write("Mark V. Vaisman,"),
  cursor(2,63),write("  version 5.0,"),
  cursor(3,63),write("     1994."),
  start.

clauses
  repeat.repeat:-repeat.
  choice_win(No,Att1,Att2,Title,Row0,Col0,Sizerow,Sizecol,Out):-
       makewindow(No,Att1,Att2,Title,Row0,Col0,Sizerow,Sizecol),
       list(Pos,List),Size=Sizerow-2,printlist(List,0,3,Size),
       cursoroff,cursor(0,1),write("<"),
       initchoice(Out,Sizerow),cursoron,!.
  dochoice(72,_,_):-cursor(Row,_),Row>0,list(Pos,List),
                    Pos1=Pos-1,Pred=Row-1,
                    cursor(Row,1),write(" "),
                    cursor(Pred,1),write("<"),
                    retract(list(Pos,List)),
                    assertz(list(Pos1,List)),fail.
  dochoice(72,_,_):-cursor(Row,_),Row=0,list(Pos,List),Pos<>1,
                    Pos1=Pos-1,scroll(-1,0),
                    takestr(List,Pos1,Str),
                    cursor(1,1),write(" "),
                    cursor(0,3),write(Str),
                    cursor(0,1),write("<"),
                    retract(list(Pos,List)),
                    assertz(list(Pos1,List)),fail.                   
  dochoice(80,_,Sizerow):-cursor(Row,_),Row<Sizerow-3,list(Pos,List),
                          Pos1=Pos+1,Next=Row+1,
                          takestr(List,Pos1,Str),Str<>"",
                          cursor(Row,1),write(" "),
                          cursor(Next,1),write("<"),
                          retract(list(Pos,List)),
                          assertz(list(Pos1,List)),fail.
  dochoice(80,_,Sizerow):-cursor(Row,_),Sizerow=Row+3,list(Pos,List),
                          Pos1=Pos+1,
                          takestr(List,Pos1,Str),Str<>"",
                          scroll(1,0),Row1=Row-1,
                          cursor(Row1,1),write(" "),
                          cursor(Row,3),write(Str),
                          cursor(Row,1),write("<"),
                          retract(list(Pos,List)),
                          assertz(list(Pos1,List)),fail.                   
  dochoice(13,Out,_):-list(Pos,List),takestr(List,Pos,Out),!.
  initchoice(Out,Sizerow):-repeat,key(Code),
                           dochoice(Code,Out,Sizerow),!.     
  findflow:-flow(Flow,_),
            list(1,List),List1=[Flow|List],
            retract(list(1,List)),
            assertz(list(1,List1)),fail.
  findflow.          
  finddiscipline:-actdata(Flow,_,_),
                  discipline(Flow,Discip,_,_),
                  list(1,List),List1=[Discip|List],
                  retract(list(1,List)),
                  assertz(list(1,List1)),fail.
  finddiscipline.                 
  scroll_win(No,Att1,Row0,Col0,Sizerow,Sizecol,Head,Code):-
       makewindow(No,Att1,0,"",Row0,Col0,Sizerow,Sizecol),
       list(Pos,List),printlist(List,0,1,Sizerow),
       cursor(0,0),view(Sizerow,Head,Code),!.
  printlist([],_,_,_):-!.
  printlist(_,Row,_,Row):-!.
  printlist([Str|T],Row,Col,Sizerow):-
             cursor(Row,Col),write(Str),
             Row1=Row+1,printlist(T,Row1,Col,Sizerow),!.
  h(1,"Поток             Дисциплина          Лектор              Число групп").
  h(2,"Ф.И.0.            Лекции      Семинары      Лабораторные     Нагрузка").
  h(3,"Ф.И.О.            Тек. конул.     Экз. консул.   Курсовые    Экзамены").
  h(4,"Ф.И.О             Зачеты       Коллоквиум      Контрольные     Д/З").
  h(5,"").
  print([]):-flush(printer),!.
  print([H|T]):-write(H,"\n"),print(T),!.
  printtext(13,List):-removewindow,shiftwindow(No),New=No+1,
                      makewindow(New,79,4," Внимание ",11,27,3,27),
                      cursor(0,1),write(" Идет печать текста... "),
                      writedevice(printer),print(List),writedevice(screen),!.
  printtext(_,_):-writedevice(screen),!.
  viewlist(72,_,_):-
                  cursor(Row,_),Row>0,list(Pos,List),
                  Pos1=Pos-1,Pred=Row-1,
                  cursor(Pred,0),
                  retract(list(Pos,List)),
                  assertz(list(Pos1,List)),fail.
  viewlist(72,_,_):-
                  cursor(Row,_),Row=0,list(Pos,List),Pos<>1,
                  Pos1=Pos-1,scroll(-1,0),
                  takestr(List,Pos1,Str),
                  cursor(0,1),write(Str),
                  cursor(0,0),
                  retract(list(Pos,List)),
                  assertz(list(Pos1,List)),fail.                   
  viewlist(80,Sizerow,_):-
                  cursor(Row,_),Row<Sizerow-1,list(Pos,List),
                  Pos1=Pos+1,Next=Row+1,
                  cursor(Next,0),
                  retract(list(Pos,List)),
                  assertz(list(Pos1,List)),fail.
  viewlist(80,Sizerow,_):-
                  cursor(Row,_),Sizerow=Row+1,list(Pos,List),
                  Pos1=Pos+1,scroll(1,0),
                  takestr(List,Pos1,Str),
                  Row1=Sizerow-1,
                  cursor(Row1,1),write(Str),
                  cursor(Row1,0),
                  retract(list(Pos,List)),
                  assertz(list(Pos1,List)),fail.     
  viewlist(59,_,Head):-
                  shiftwindow(No),New=No+1,
                  cursoroff,
                  makewindow(New,62,14," Внимание ",8,20,7,40),
                  cursor(1,2),write("Установите принтер в режим печати !"),
                  cursor(2,2),write("Когда принтер будет готов,нажите на"),
                  cursor(3,17),write("Enter"),
                  list(N,List),h(Head,Str),
                  key(Code),printtext(Code,[Str|List]),cursoron,
                  removewindow,shiftwindow(No),fail.
  viewlist(27,_,_):-!.
  viewlist(9,_,_):-!.
  view(Sizerow,Head,Code):-repeat,key(Code),viewlist(Code,Sizerow,Head),!.
/************************ Г л а в н о е   м е н ю **************************/  
  start:-cursoroff,
         makewindow(2,15,15," М Е Н Ю ",7,27,11,19),
         cursor(1,2),menuop(1),
         cursor(3,2),menuop(3),
         cursor(5,2),menuop(5),
         cursor(7,2),menuop(7),
         cursor(1,2),
         makewindow(3,31,0,"",9,29,1,15),
         cursor(0,1),menuop(1),
         menu.
  menu:- repeat,
         key(Code),
         choice(Punkt,Code),
         Code=13,
         process(Punkt),start.
  process(1):- filename(" Имя файла ",Name),datafile(Name),deletewindows(3),
                makewindow(1,15,15," Ввод данных ",0,0,25,80),clearwindow,
                makewindow(2,15,15," Тип данных ",1,1,3,78),
                cursor(0,5),dataop(5),
                cursor(0,35),dataop(35),
                cursor(0,5),
                makewindow(3,31,0,"",2,5,1,13),cursor(0,2),dataop(5),
                statusline(1),
                datamenu,save(Name),cleardatabase,
                deletewindows(2),shiftwindow(1),removewindow. 
   process(3):- filename(" Имя файла ",Name),findfile(Name),deletewindows(3),
                makewindow(1,15,15," Распределение ",0,0,25,80),clearwindow,
                statuslinedistr(2),
                makewindow(3,15,15," Нагрузка ",1,40,22,39), 
                makewindow(2,15,15," Текущий поток ",1,1,22,39),
                cursoron,
                cursor(1,1),write("Поток : "),
                cursor(2,1),write("Дисциплина : "),
                cursor(3,1),write("Отделение (д/в) : "),
                cursor(5,1),write("\196\196\196\196\196\196\196\196\196\196",
                                  "\196\196\196\196\196\196\196\196\196\196",
                                  "\196\196\196\196\196\196\196\196\196\196",
                                  "\196\196\196\196"),
                cursor(1,19),
                assert(person("",[0,0,0,0,0,0,0,0,0,0,0,0])),
                distribution,
                retract(actdata(_,_,_)),retract(person("",_)),
                save(Name),cleardatabase,
                deletewindows(3),
                shiftwindow(1),removewindow. 
   process(5):- assert(list(1,
                ["1. Распределение по потокам",
                 "2. Лекции, семинары, лабораторные, нагрузка",
                 "3. Консультации, курсовые, экзамены",
                 "4. Зачеты, коллоквиумы, контрольные, д/з",
                 "5. Итоговый : лекции, семинары, лабораторные, нагрузка",
                 "6. Итоговый : консультации, курсовые, экзамены",
                 "7. Итоговый : зачеты, коллоквиумы, контрольные, д/з"])),
                choice_win(4,15,15," Тип протокола ",18,6,6,60,Out),
                removewindow,
                retract(list(_,_)),
                frontchar(Out,Num,Str),char_int(Num,Number),
                createdatabase(Number),        
                cleardatabase,shiftwindow(1). 
   process(7):-cursoron,removewindow,removewindow,exit.
    
/************************* В в о д   д а н н ы х ***************************/

   datafile(Name):- existfile(Name),consult(Name),cursoroff.		    	
   datafile(Name):- str_len(Name,Length),
                    Xd=38+Length,X0=36-Xd/2,
                    makewindow(4,79,4," Внимание ",20,X0,3,Xd),
                    beep,cursor(0,2),
                    write("Файл ",Name," не найден. Создать? (y/n) "),
                    readchar(Ask),cursoroff,createfile(Ask,Name).
   createfile('y',Name):-asserta(cost([0,0,0,0,0,0],[0,0,0,0,0,0])).
   createfile(_,_):- removewindow,shiftwindow(3),fail.
   dataop(5):- write("Стоимость").
   dataop(35):- write("Потоки").
   datapos(35,5,35). datapos(5,35,5).  
   statusline(1):- shiftwindow(1),
                   cursor(22,1),write("                          ",
                                      "                          ",
                                      "                          "),
                   cursor(22,1),write(" F1 : Пересчет нагрузки  ",
                                      " ESC : Выход в меню"), 
                   shiftwindow(2),shiftwindow(3).
   delinput(3):-!.
   delinput(No):- shiftwindow(No),removewindow,
                  No1=No-1,delinput(No1). 
   datamenu:- repeat,
              key(Code),indata(Code),Code=27.
   indata(27):-!.
   indata(77):- shiftwindow(2),cursor(_,Col),
                shiftwindow(3),Col<=63,
                removewindow,
                datapos(_,Col,Next),shiftwindow(2),cursor(0,Next),
                makewindow(3,31,0,"",2,Next,1,13),
                cursor(0,2),dataop(Next),!.  
   indata(75):- shiftwindow(2),cursor(_,Col),
                shiftwindow(3),Col>=5,
                removewindow,
                datapos(Pred,Col,_),shiftwindow(2),cursor(0,Pred),
                makewindow(3,31,0,"",2,Pred,1,13),
                cursor(0,2),dataop(Pred),!.
   indata(59):- retractall(person(_,_)),
                cursoron,
                makewindow(4,15,15," Пересчет нагрузки ",4,2,20,76),
                makewindow(5,15,0,"",5,3,3,74),
                cursor(1,5),write("Поток"),
                cursor(1,25),write("Дисциплина"),
                cursor(1,50),write("Отделение"),
                makewindow(6,15,0,"",7,3,16,74),
                cursor(1,5),
                assert(actdata("","",'д')),
                recount,
                retract(actdata(_,_,_)),
                removewindow,removewindow,removewindow,
                cursoroff,!.
   indata(13):- shiftwindow(2),cursor(_,Col),Col=5,
                shiftwindow(1),
                cursor(22,1),write("                  ",
                                   "                  ",
                                   "                  "),
                cursor(22,1),write("ESC : Конец ввода "), 
                shiftwindow(2),shiftwindow(3),
                makewindow(4,15,15," Стоимость ",4,1,19,78),
                cursor(1,30),write(" Дневное отделение"),
                coastpunkt(L),typepunktcoast(L,2),
                cursor(9,30),write(" Вечернее отделение"),
                typepunktcoast(L,10),
                printcoast,cursor(2,48),
                cursoron,inputcoast,delinput(4),
                statusline(1),cursoroff,! .
   indata(13):- shiftwindow(2),cursor(_,Col),Col=35,
                shiftwindow(1),
                cursor(22,1),write("                  "),
                cursor(22,1),
                write("Alt-F1 : удалить поток    ", 
                      "Alt-F2 : удалить дисциплину    ",
                      "ESC : Конец ввода"), 
                shiftwindow(2),shiftwindow(3),
                makewindow(5,15,15," Информация о стоимости ",4,40,19,39),
                contrcost(C),typepunktflows(C,1),
                makewindow(4,15,15," Потоки ",4,1,19,39),
                flowspunkt(F),typepunktflows(F,1),
                assert(actdata("","",'д')),
                cursor(1,25),cursoron,inputflows,
                retract(actdata(_,_,_)),delinput(5),
                statusline(1),cursoroff,!.
   callevalload("",_):-!.
   callevalload(Name,Pos):-person(Name,_),evalload(Name,Pos,1),!.
   callevalload(Name,Pos):-assert(person(Name,[0,0,0,0,0,0,0,0,0,0,0,0])),
                           evalload(Name,Pos,1),!. 
   retake([],_):-!.
   retake([H|T],N):-callevalload(H,N),N1=N+1,retake(T,N1).
   recount:-discipline(Flow,Discip,_,Persons),cursor(Row,_), 
            cursor(Row,5),write(Flow),
            cursor(Row,25),write(Discip),
            cursor(Row,50),readln(Str),
            frontchar(Str,N,End),
            actdata(F,D,C),
            retract(actdata(F,D,C)),
            assert(actdata(Flow,Discip,N)),
            retake(Persons,1),fail.
   recount:-!.         
   coastpunkt(["Экзамена.................", 
               "Зачета...................", 
               "Коллоквиума..............", 
               "Контрольной работы.......", 
               "Консультации.............", 
               "Курсовой работы.........."]). 
   typepunktcoast([],_).
   typepunktcoast([H|T],No):-cursor(No,22),write(H),No1=No+1,
                             typepunktcoast(T,No1). 
   writecoast([],_).
   writecoast([H|T],Row):-cursor(Row,48),write(H),Row1=Row+1,
                          writecoast(T,Row1).
   printcoast:- cost(D,E),writecoast(D,2),writecoast(E,10),!.
   printcoast.
   poscoast(15,2,3,1).poscoast(2,3,4,2).
   poscoast(3,4,5,3).poscoast(4,5,6,4).
   poscoast(5,6,7,5).poscoast(6,7,10,6).
   poscoast(7,10,11,1).poscoast(10,11,12,2).
   poscoast(11,12,13,3).poscoast(12,13,14,4).
   poscoast(13,14,15,5).poscoast(14,15,2,6).
   poscoast(15,16,2,6).poscoast(7,8,10,6).
   inputc(72,_):-cursor(Row,_),poscoast(Pred,Row,_,_),cursor(Pred,48),fail.
   inputc(80,_):-cursor(Row,_),poscoast(_,Row,Next,_),cursor(Next,48),fail.
   inputc(27,_).
   inputc(Code,Adr):-Code>42,Code<58,membyte($0040,$001A,Adr),
                     cost_to_db,fail.
   cost_to_db:-cursor(Row,_),Row<9,readln(Item),str_real(Item,Value),
               poscoast(_,Row,Next,Pos),
               cost(D,E),insert(D,Value,Pos,Out),
               retract(cost(_,_)),asserta(cost(Out,E)),cursor(Next,48),!.
   cost_to_db:-cursor(Row,_),Row>9,readln(Item),str_real(Item,Value),
               poscoast(_,Row,Next,Pos),
               cost(D,E),insert(E,Value,Pos,Out),
               retract(cost(_,_)),asserta(cost(D,Out)),cursor(Next,48),!.
   cost_to_db:-cursor(Row,_),poscoast(Pred,Row,_,_),cursor(Pred,48),beep.
   inputcoast:- repeat,membyte($0040,$001A,Adr),key(Code),inputc(Code,Adr).
   posflows(15,1,2).posflows(1,2,5).posflows(2,5,6).posflows(5,6,7).
   posflows(6,7,8).posflows(7,8,9).posflows(8,9,10).posflows(9,10,11).
   posflows(10,11,12).posflows(11,12,13).posflows(12,13,14).
   posflows(13,14,15).posflows(14,15,1).
   flowspunkt(["Поток................",
              "Численность групп....",
              "",
              "",
              "Дисциплина...........",
              "Количество групп.....",
              "Лекции...............",
              "Семинары.............",
              "Лабораторные работы..",
              "Контрольные работы...",
              "Домашние задания.....",
              "Коллоквиумы..........",
              "Зачеты...............",
              "Экзамены.............",
              "Курсовик............."]).
   contrcost(["    Дневного отделения",
              "",
              "Лектора.......",
              "",
              "Группы........",
              "",
              "Потока........",
              "",
              "    Вечернего отделения",
              "",
              "Лектора.......",
              "",
              "Группы........",
              "",
              "Потока........"]).
   typepunktflows([],_).
   typepunktflows([H|T],Row):-cursor(Row,2),write(H),Row1=Row+1,
                              typepunktflows(T,Row1).
   typevalue([],_).
   typevalue([H|T],Row):-cursor(Row,25),write(H),Row1=Row+1,
                         typevalue(T,Row1).
   inputf(72,_):-cursor(Row,_),posflows(Pred,Row,_),cursor(Pred,25),fail.
   inputf(80,_):-cursor(Row,_),posflows(_,Row,Next),cursor(Next,25),fail.
   inputf(104,_):-actdata(Flow,_,_),Flow<>"",
                  retract(flow(Flow,_)),
                  retractall(discipline(Flow,_,_,_)),
                  shiftwindow(5),clcost(3),shiftwindow(4),
                  cursor(1,25),write("              "),clfleid(2),
                  cursor(1,25),fail.
   inputf(105,_):-actdata(Flow,Discip,_),
                  retract(discipline(Flow,Discip,_,_)),
                  shiftwindow(5),clcost(3),shiftwindow(4),
                  clfleid(5),cursor(5,25),fail.
   inputf(13,_):-cursor(Row,_),Row=1,
                 assert(list(1,[])),findflow,
                 choice_win(10,15,15," Потоки ",6,30,8,20,Out),
                 retract(list(_,_)),removewindow,
                 cursor(1,25),write("            "),
                 cursor(1,25),write(Out),flow_to_db(Out,1),fail.
   inputf(13,_):-cursor(Row,_),Row=5,
                 actdata(Flow,_,_),Flow<>"",
                 assert(list(1,[])),finddiscipline,
                 choice_win(10,15,15," Дисциплины ",10,30,8,20,Out),
                 retract(list(_,_)),removewindow,
                 cursor(5,25),write("            "),
                 cursor(5,25),write(Out),flow_to_db(Out,5),fail.
   inputf(27,_).
   inputf(Code,Adr):-Code<>27,Code<>72,Code<>80,Code<>104,Code<>105,Code<>13,
                     membyte($0040,$001A,Adr),
                     cursor(Row,_),readln(Value),flow_to_db(Value,Row),fail.
   creatlist(_,0,[]):-!.
   creatlist([],N,Out):-N1=N-1,creatlist([],N1,Out1),Out=[""|Out1].
   creatlist([H|T],N,Out):-N1=N-1,creatlist(T,N1,Out1),Out=[H|Out1].
   clfleid(1).
   clfleid(Row):-cursor(Row,25),write("            "),
                 posflows(_,Row,Next),clfleid(Next),!.
   clcost(16):-!.
   clcost(9):-clcost(11),!.
   clcost(Row):-cursor(Row,17),write("              "),
                Next=Row+1,clcost(Next).
   evalcost:-actdata(Flow,Discip,_),Flow<>"",Discip<>"",
             flow(Flow,Num),cost(D,E),
             discipline(Flow,Discip,L,_),
             discipline(Flow,Discip,[Ag,_,_,_,_,_,_,_,_,_],_),
             lecload(D,L,Num,Out1),groupload(D,L,Num,Out2),
             lecload(E,L,Num,Out3),groupload(E,L,Num,Out4),
             Total1=Out1+Ag*Out2,Total2=Out3+Ag*Out4,
             shiftwindow(5),clcost(3),
             cursor(3,17),writef("%5.1f",Out1),
             cursor(5,17),writef("%5.1f",Out2),
             cursor(7,17),writef("%5.1f",Total1),
             cursor(11,17),writef("%5.1f",Out3),
             cursor(13,17),writef("%5.1f",Out4),
             cursor(15,17),writef("%5.1f",Total2),
             shiftwindow(4).
   evalcost.
   flow_to_db(Value,1):-Value<>"",flow(Value,Data),clfleid(2),
                        cursor(2,25),write(Data),
                        shiftwindow(5),clcost(3),shiftwindow(4),
                        retract(actdata(_,_,_)),
                        assert(actdata(Value,"",'д')),cursor(2,25),!.
   flow_to_db(Value,1):-Value<>"",assert(flow(Value,0)),clfleid(2),
                        shiftwindow(5),clcost(3),shiftwindow(4),
                        retract(actdata(_,_,_)),
                        assert(actdata(Value,"",'д')),cursor(2,25),!.
   flow_to_db(Value,2):-actdata(Flow,_,_),str_real(Value,Data),
                        retract(flow(Flow,_)),
                        assert(flow(Flow,Data)),
                        evalcost,
                        cursor(5,25),!.
   flow_to_db(Value,5):-Value<>"",
                        actdata(Flow,_,_),Flow<>"",
                        discipline(Flow,Value,L,_),
                        clfleid(6),typevalue(L,6),
                        retract(actdata(_,_,_)),
                        assert(actdata(Flow,Value,0)),
                        evalcost,
                        cursor(6,25),!.
   flow_to_db(Value,5):-Value<>"",
                        actdata(Flow,_,_),Flow<>"",
                        assert(discipline(Flow,Value,[0,0,0,0,0,0,0,0,0,0],[])),
                        clfleid(6),
                        retract(actdata(_,_,_)),
                        assert(actdata(Flow,Value,'д')),
                        evalcost,
                        cursor(6,25),!.
   flow_to_db(Value,6):-actdata(Flow,Discip,_),
                        discipline(Flow,Discip,L,Persons),
                        str_real(Value,Data),
                        Num=Data+1,
                        insert(L,Data,1,Out),
                        creatlist(Persons,Num,List),
                        retract(discipline(Flow,Discip,_,_)),
                        assert(discipline(Flow,Discip,Out,List)),
                        evalcost,cursor(7,25),!.
   flow_to_db(Value,Row):-Row>6,Row<16,actdata(Flow,Discip,_),
                          discipline(Flow,Discip,L,List),
                          str_real(Value,Data),Pos=Row-5,
                          insert(L,Data,Pos,Out),
                          retract(discipline(Flow,Discip,_,_)),
                          assert(discipline(Flow,Discip,Out,List)),
                          evalcost,
                          posflows(_,Row,Next),cursor(Next,25),!.
   flow_to_db(Value,Row):-cursor(Row,25),beep.
   inputflows:- repeat,membyte($0040,$001A,Adr),key(Code),inputf(Code,Adr).
/*********************** Р а с п р е д е л е н и е *************************/ 

   findfile(Name):- existfile(Name),consult(Name),
                    assert(actdata("","",'д')),cursoroff.
   findfile(Name):- str_len(Name,Length),
                    Xd=21+Length,X0=36-Xd/2,cursoroff,
                    makewindow(4,79,4," Ошибка ",20,X0,3,Xd),
                    cursor(0,2),write("Файл ",Name," не найден"),beep,
                    readchar(_),removewindow,shiftwindow(3),fail.
  statuslinedistr(2):-scroll(-1,0),cursor(22,1),
                      write("F1 : Начать распределение   ",
                            "F2 : Просмотр вакансий   ",
                            "Esc : Выход в меню ").
  statuslinedistr(3):-scroll(-1,0),cursor(22,1),
                      write("Esc : Закончить распределение").
  statuslinedistr(4):-scroll(-1,0),cursor(22,1),
                      write("\24\25 : Листание текста   ",
                            "F1 : Вывод на принтер   ",
                            "Esc : Конец просмотра"). 
  distrpos(3,1,2).distrpos(1,2,3).distrpos(2,3,1).
  inputd(59,_):-actdata(Flow,Discip,N),
                discipline(Flow,Discip,_,_),
                shiftwindow(1),statuslinedistr(3),
                shiftwindow(3),clearwin(1),cursor(1,1),
                printload,shiftwindow(2),
                printflow,cursor(7,10),
                distrpersonal,cursor(1,19),
                shiftwindow(1),statuslinedistr(2),
                shiftwindow(3),shiftwindow(2),
                fail.
  inputd(60,_):-shiftwindow(1),statuslinedistr(4),
                makewindow(4,15,15," Вакансии ",1,1,22,78),
                makewindow(5,15,0,"",2,2,3,76),
                h(1,Head),cursor(1,1),write(Head),
                assert(list(1,[])),
                listvacantion,
                scroll_win(6,15,5,2,17,76,1,_),
                retract(list(_,_)),
                removewindow,removewindow,removewindow,
                statuslinedistr(2),shiftwindow(3),shiftwindow(2),fail.
  inputd(13,_):-cursor(Row,_),Row=1,
                assert(list(1,[])),findflow,
                choice_win(10,15,15," Потоки ",2,30,8,20,Out),
                retract(list(_,_)),removewindow,
                cursor(1,19),write("            "),
                cursor(1,19),write(Out),
                in_to_actdata(1,Out),fail.
  inputd(13,_):-cursor(Row,_),Row=2,
                actdata(Flow,Discip,N),Flow<>"",
                assert(list(1,[])),finddiscipline,
                choice_win(10,15,15," Дисциплины ",3,30,8,20,Out),
                retract(list(_,_)),removewindow,
                cursor(2,19),write("            "),
                cursor(2,19),write(Out),
                in_to_actdata(2,Out),fail.
  inputd(27,_).
  inputd(80,_):-cursor(Row,_),distrpos(_,Row,Next),cursor(Next,19),fail.
  inputd(72,_):-cursor(Row,_),distrpos(Pred,Row,_),cursor(Pred,19),fail.
  inputd(Code,Adr):-Code<>27,Code<>13,Code<>72,Code<>80,Code<>59,Code<>60,
                    Code<>75,Code<>77,
                    membyte($0040,$001A,Adr),cursor(Row,_),
                    readln(Value),in_to_actdata(Row,Value),fail.
  lector("","свободен"):-!.
  lector(_,"занят").
  increase("",Groups,Groups1):-Groups=Groups1+1,!.
  increase(_,Groups1,Groups1):-!.
  groups([],0).
  groups([H|T],Groups):-groups(T,Groups1),increase(H,Groups,Groups1),!.
  includestr("свободен",G):-G>=0,!.
  includestr("занят",G):-G<>0,!.
  includestr("занят",0):-fail.
  listvacantion:-discipline(Flow,Discip,_,[L|G]),
                 lector(L,Lector),groups(G,Groups),
                 includestr(Lector,Groups),
                 str_int(Gr,Groups),
                 list(N,List),
                 str_len(Flow,Len1),str_of_empty(Len1,20,Empty1),
                 concat(Flow,Empty1,Str1),
                 concat(Str1,Discip,Str2),
                 str_len(Discip,Len2),str_of_empty(Len2,20,Empty2),
                 concat(Str2,Empty2,Str3),
                 concat(Str3,Lector,Str4),
                 str_len(Lector,Len3),str_of_empty(Len3,20,Empty3),
                 concat(Str4,Empty3,Str5),
                 concat(Str5,Gr,Str),
                 retract(list(N,List)),
                 assertz(list(N,[Str|List])),fail.
  listvacantion.
  in_to_actdata(1,Value):-actdata(_,Discip,N),
                          retract(actdata(_,_,_)),
                          assert(actdata(Value,Discip,N)),
                          cursor(2,19),!.
  in_to_actdata(2,Value):-actdata(Name,_,N),
                          retract(actdata(_,_,_)),
                          assert(actdata(Name,Value,N)),
                          cursor(3,19),!.
  in_to_actdata(3,Value):-frontchar(Value,N,End),
                          actdata(Name,Discip,_),
                          retract(actdata(_,_,_)),
                          assert(actdata(Name,Discip,N)),
                          cursor(1,19),!.
  clearwin(19):-!.
  clearwin(Row):-cursor(Row,1),write("                                    "),
                 Row1=Row+1,clearwin(Row1),!.
  printname([],_,_).
  printname(_,19,_).
  printname([H|T],Row,Col):-cursor(Row,Col),write(H),Row1=Row+1,
                             printname(T,Row1,Col).
  writeflow(_,0,_).
  writeflow(Flow,Ag,Row):-cursor(Row,1),N=Row-7,write(Flow,N),Row1=Row+1,
                          Ag1=Ag-1,writeflow(Flow,Ag1,Row1),!.
  writeflow(_,_,_).                                        
  printflow:-actdata(Flow,Discip,_),
             discipline(Flow,Discip,[Ag|T],List),clearwin(7),
             writeflow(Flow,Ag,8),cursor(7,1),write("Лектор"),
             printname(List,7,10),!.
  printflow:-clearwin(7),cursor(1,19),beep,fail.
  posgroup(Ag,Pred,Row,Next):-Row>7,Ag>Row-7,Pred=Row-1,Next=Row+1.
  posgroup(Ag,Pred,Row,Next):-Row=7,Pred=Ag+7,Next=8.
  posgroup(Ag,Pred,Row,Next):-Row=Ag+7,Pred=Row-1,Next=7.
  inputperson(72,_):-actdata(Flow,Discip,_),
                     discipline(Flow,Discip,[Ag|_],_),
                     cursor(Row,_),
                     posgroup(Ag,Pred,Row,_),
                     cursor(Pred,10),fail.
  inputperson(80,_):-actdata(Flow,Discip,_),
                     discipline(Flow,Discip,[Ag|_],_),
                     cursor(Row,_),
                     posgroup(Ag,_,Row,Next),
                     cursor(Next,10),fail.
  inputperson(27,_).
  inputperson(Code,Adr):-Code<>72,Code<>80,Code<>27,
                         Code<>13,Code<>59,Code<>60,
                         membyte($0040,$001A,Adr),cursor(Row,_),
                         readln(Name),
                         name_to_db(Name,Row),
                         actdata(Flow,Discip,_),
                         discipline(Flow,Discip,[Ag|_],_),
                         posgroup(Ag,_,Row,Next),
                         cursor(Next,10),fail.
  name_to_db(Name,Row):-Pos=Row-6,
                        findperson(Name,Pos),
                        shiftwindow(3),clearwin(1),cursor(1,1),
                        printload,shiftwindow(2),
                        !.                       
  takecost(Out):-actdata(_,_,N),N='д',cost(Out,_),!.
  takecost(Out):-actdata(_,_,N),N='Д',cost(Out,_),!.
  takecost(Out):-cost(_,Out),!.
  printload:-person(Name,[Load|_]),Name<>"",cursor(Row,_),
             cursor(Row,1),write(Name),
             cursor(Row,20),writef("%5.1f",Load),
             Row1=Row+1,cursor(Row1,1),Row1=19,!.
  printload:-!.                
  evalload(Name,1,Op):-person(Name,L),takecost(C),
                       actdata(Flow,Discip,_),
                       flow(Flow,Num),
                       discipline(Flow,Discip,D,_),
                       curhelp(C,D,Num,Curhelp2),
                       examhelp(C,D,Num,Examhelp2),
                       leccoll(C,D,Num,Leccoll2),
                       lecexam(C,D,Num,Lecexam2),
                       lecload(C,D,Num,Load2),
                       take(D,2,Lec2),
                       take(L,1,Load1),take(L,2,Lec1),
                       take(L,7,Leccoll1),take(L,9,Lecexam1),
                       take(L,11,Curhelp1),take(L,12,Examhelp1),
                       Load=Load1+Op*Load2,Lec=Lec1+Op*Lec2,
                       Leccoll=Leccoll1+Op*Leccoll2,
                       Curhelp=Curhelp1+Op*Curhelp2,
                       Examhelp=Examhelp1+Op*Examhelp2,
                       Lecexam=Lecexam1+Op*Lecexam2,
                       insert(L,Load,1,L1),insert(L1,Lec,2,L2),
                       insert(L2,Leccoll,7,L3),insert(L3,Curhelp,11,L4),
                       insert(L4,Examhelp,12,L5),insert(L5,Lecexam,9,L6),
                       retract(person(Name,_)),asserta(person(Name,L6)),!.
  evalload(Name,Pos,Op):-Pos>1,person(Name,L),takecost(C),
                         actdata(Flow,Discip,_),
                         flow(Flow,Num),
                         discipline(Flow,Discip,D,_),
                         kurswork(C,D,Num,Kurs2),
                         groupexam(C,D,Num,Gexam2),
                         test(C,D,Num,Test2),
                         groupcoll(C,D,Num,Gcoll2),
                         contrwork(C,D,Num,Contr2),
                         homework(C,D,Num,Home2),
                         groupload(C,D,Num,Load2),
                         take(D,3,Prac2),take(D,4,Lab2),
                         take(L,3,Prac1),take(L,4,Lab1),
                         take(L,10,Kurs1),take(L,9,Gexam1),
                         take(L,8,Test1),take(L,7,Gcoll1),
                         take(L,5,Contr1),take(L,6,Home1),
                         take(L,1,Load1),
                         Load=Load1+Op*Load2,Prac=Prac1+Op*Prac2,
                         Lab=Lab1+Op*Lab2,Kurs=Kurs1+Op*Kurs2,
                         Gexam=Gexam1+Op*Gexam2,Test=Test1+Op*Test2,
                         Gcoll=Gcoll1+Op*Gcoll2,Contr=Contr1+Op*Contr2,
                         Home=Home1+Op*Home2,
                         insert(L,Load,1,L1),insert(L1,Prac,3,L2),
                         insert(L2,Lab,4,L3),insert(L3,Kurs,10,L4),
                         insert(L4,Gexam,9,L5),insert(L5,Test,8,L6),
                         insert(L6,Gcoll,7,L7),insert(L7,Contr,5,L8),
                         insert(L8,Home,6,L9),
                         retract(person(Name,_)),asserta(person(Name,L9)).
  findperson(Name,Pos):-person(Name,_),
                        actdata(Flow,Discip,_),
                        discipline(Flow,Discip,L,Namelist),
                        takestr(Namelist,Pos,Oldname),
                        evalload(Name,Pos,1),
                        evalload(Oldname,Pos,-1),
                        insertstr(Namelist,Name,Pos,Newlist),
                        retract(discipline(Flow,Discip,_,_)),
                        assert(discipline(Flow,Discip,L,Newlist)),!.
  findperson(Name,Pos):-makewindow(4,79,15,"",6,2,3,37),beep,
                        write(" Новая фамилия ! Ввести ? (д/н) "),
                        readchar(Ask),
                        person_to_db(Name,Pos,Ask).
  person_to_db(Name,Pos,'д'):-assert(person(Name,[0,0,0,0,0,0,0,0,0,0,0,0])),
                              actdata(Flow,Discip,_),
                              discipline(Flow,Discip,L,Namelist),
                              takestr(Namelist,Pos,Oldname),
                              evalload(Name,Pos,1),
                              evalload(Oldname,Pos,-1),
                              insertstr(Namelist,Name,Pos,Newlist),
                              retract(discipline(Flow,Discip,_,_)),
                              assert(discipline(Flow,Discip,L,Newlist)),
                              removewindow,!.
  person_to_db(Name,Pos,'Д'):-
                             assert(person(Name,[0,0,0,0,0,0,0,0,0,0,0,0])),
                             actdata(Flow,Discip,_),
                             discipline(Flow,Discip,L,Namelist),
                             takestr(Namelist,Pos,Oldname),
                             evalload(Name,Pos,1),
                             evalload(Oldname,Pos,-1),
                             insertstr(Namelist,Name,Pos,Newlist),
                             retract(discipline(Flow,Discip,_,_)),
                             assert(discipline(Flow,Discip,L,Newlist)),
                             removewindow,!.
  person_to_db(Name,Pos,_):-removewindow,
                            actdata(Flow,Discip,_),
                            discipline(Flow,Discip,L,Namelist),
                            takestr(Namelist,Pos,Oldname),
                            evalload(Oldname,Pos,-1),
                            insertstr(Namelist,"",Pos,Newlist),
                            retract(discipline(Flow,Discip,_,_)),
                            assert(discipline(Flow,Discip,L,Newlist)),
                            Row=Pos+6,cursor(Row,10),
                            write("                           "),!.
  distrpersonal:-repeat,membyte($0040,$001A,Adr),key(Code),
                 inputperson(Code,Adr),!.           
  distribution:-repeat,membyte($0040,$001A,Adr),key(Code),inputd(Code,Adr).
/*************************** Протоколы ************************************/
   createdatabase(49):-filename(" Имя файла ",Name),
                       loaddiscipline(Name),
                       deletewindows(3),
                       protocol(49," Распределение "),!.
   createdatabase(Number):-Number>49,Number<53,
                           filename(" Имя файла ",Name),
                           loadperson(Name),
                           deletewindows(3),
                           protocol(Number,""),!.
   createdatabase(Number):-Number>52,Number<56,Num=Number-3,
                           filename(" Имя первого файла ",Name1),
                           loadperson(Name1),
                           filename(" Имя второго файла ",Name2),
                           loadperson(Name2),
                           deletewindows(3),
                           summary,
                           protocol(Num," Итоговый "),!.
   flow_discip:-discipline(Flow,Discip,_,_),
                list(N,List),
                concat(Flow," , ",Str1),
                concat(Str1,Discip,Str),
                retract(list(N,List)),assert(list(N,[Str|List])),fail.
   flow_discip.                 
   loaddiscipline(Name):-existfile(Name),consult(Name),
                         retractall(cost(_,_)),
                         retractall(flow(_,_)),
                         retract(person(_,_)),!.
   loaddiscipline(Name):-cleardatabase,findfile(Name),!.                       
   loadperson(Name):-existfile(Name),consult(Name),
                     retractall(cost(_,_)),
                     retractall(flow(_,_)),
                     retractall(discipline(_,_,_,_)),!.
   loadperson(Name):-cleardatabase,findfile(Name),!.                  
   restorename:-person(Name,L),frontchar(Name,First,End),First='@',
               retract(person(Name,L)),assert(person(End,L)),fail.
   restorename:-!.            
   summary:-person(Name,[F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12]),
            retract(person(Name,[F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12])),
            concat("@",Name,Buffer),
            asserta(person(Buffer,[F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12])),
            person(Name,[S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12]),
            T1=F1+S1,T2=F2+S2,
            T3=F3+S3,T4=F4+S4,
            T5=F5+S5,T6=F6+S6,
            T7=F7+S7,T8=F8+S8,
            T9=F9+S9,T10=F10+S10,
            T11=F11+S11,T12=F12+S12,
            retractall(person(Name,_)),
            retract(person(Buffer,[F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12])),
            asserta(person(Name,[T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12])),
            fail.
   summary:-restorename,!.         
   total(0,0,0,0):-!.
   total(V1,V2,V3,V4):- num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[S1,S2,S3,S4]),
                        T1=S1+V1,T2=S2+V2,T3=S3+V3,T4=S4+V4,
                        retract(num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[S1,S2,S3,S4])),
                        assertz(num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[T1,T2,T3,T4])),!.
   formstr(Name,L,Out):-num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[S1,S2,S3,S4]),
                        concat("  ",Name,Namefull),
                        str_len(Name,D),
                        str_of_empty(D,L1,Str),
                        concat(Namefull,Str,Str1),
                        take(L,N1,V1),conver(V1,Item1),
                        str_len(Item1,D1),
                        concat(Str1,Item1,Str2),
                        str_of_empty(D1,L2,Str3),
                        concat(Str2,Str3,Str4),
                        take(L,N2,V2),conver(V2,Item2),
                        str_len(Item2,D2),
                        concat(Str4,Item2,Str5),
                        str_of_empty(D2,L3,Str6),
                        concat(Str5,Str6,Str7),
                        take(L,N3,V3),conver(V3,Item3),
                        str_len(Item3,D3),
                        concat(Str7,Item3,Str8),
                        str_of_empty(D3,L4,Str9),
                        concat(Str8,Str9,Str10),
                        take(L,N4,V4),conver(V4,Item4),
                        concat(Str10,Item4,Out),
                        total(V1,V2,V3,V4).
   createlist:-person(Name,L),
               formstr(Name,L,Str),
               list(N,List),
               retract(list(N,List)),
               assertz(list(N,[Str|List])),fail.
   createlist:-list(N,List),
               num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[S1,S2,S3,S4]),
               retract(num_tab([N1,N2,N3,N4,L1,L2,L3,L4],[S1,S2,S3,S4])),
               assertz(num_tab([1,2,3,4,L1,L2,L3,L4],[S1,S2,S3,S4])),
               L=[S1,S2,S3,S4],
               formstr("Итог",L,Str),  
               Line1="_____________________________________",
               Line2="_____________________________________",
               concat(Line1,Line2,Line),
               Total=[Line,Str],
               connect(List,Total,List1),
               retract(list(N,List)),
               assert(list(N,List1)),!.
   distributionlist(_,[],_):-!.
   distributionlist(Flow,[H|T],N):-str_int(Num,N),
                                   concat(Flow,Num,Str1),
                                   str_len(Str1,Len),
                                   str_of_empty(Len,20,Empty),
                                   concat(Str1,Empty,Str2),
                                   concat(Str2,H,Str3),
                                   concat("   ",Str3,Str),
                                   N1=N+1,
                                   distributionlist(Flow,T,N1),
                                   list(Pos,List),
                                   retract(list(Pos,List)),
                                   assert(list(Pos,[Str|List])).
   flowlist(Out):-discipline(Flow,Discip,_,[Lector|Persons]),
                  concat(Flow," , ",Str1),
                  concat(Str1,Discip,Out),
                  list(N,List),retract(list(N,List)),assert(list(1,[])),
                  str_len("Лектор",Len),str_of_empty(Len,20,Empty),
                  concat("Лектор",Empty,Str2),
                  concat(Str2,Lector,Str3),concat("   ",Str3,L),
                  concat(" ",Flow,F),concat(" ",Discip,D),
                  distributionlist(Flow,Persons,1),
                  list(Pos,List1),retract(list(Pos,List1)),
                  assert(list(Pos,[F|[D|[L|List1]]])),!.
   flowlist(_):-beep,!.               
   controllook(27):-!.
   controllook(_):-fail.
   lookdistribution:-repeat,
                     shiftwindow(2),cursor(22,1),
                     write("\24\25 Enter : Выбор",
                           "                    ",
                           "                    ",
                           "                    "),
                     shiftwindow(3),                           
                     assert(list(1,[])),flow_discip,
                     choice_win(4,15,15," Поток и дисциплина ",1,50,22,28,Out),
                     flowlist(Out),
                     shiftwindow(2),cursor(22,1),
                     write("\24\25 : Листание текста  ",
                             "Tab : Выбор  ",
                             "F1 : Вывод на принтер  ",
                             "Esc : Выход в меню"),
                     shiftwindow(4),shiftwindow(3),        
                     scroll_win(5,15,2,2,20,47,5,Code),
                     shiftwindow(5),removewindow,
                     shiftwindow(4),removewindow,
                     list(Pos,List),retract(list(Pos,List)),
                     controllook(Code).
   protocol(49,Title):-makewindow(2,15,15,"",0,0,25,80),
                       makewindow(3,15,15,Title,1,1,22,49),
                       lookdistribution,
                       deletewindows(3),!.
   protocol(50,Title):-makewindow(2,15,15,Title,0,0,25,80),
                       cursor(22,2),
                       write("\24\25 : Листание текста   ",
                             "F1 : Вывод на принтер   ",
                             "Esc : Выход в меню "),
                        makewindow(3,15,15,"",1,1,22,78),
                        makewindow(4,15,0,"",2,2,3,76),
                        h(2,Head),cursor(1,3),write(Head),
                        assert(list(1,[])),
                        assert(num_tab([2,3,4,1,18,12,14,17],[0,0,0,0])),
                        createlist,
                        scroll_win(5,15,5,2,17,76,2,_),
                        deletewindows(5),!.               
   protocol(51,Title):-makewindow(2,15,15,Title,0,0,25,80),
                       cursor(22,2),
                       write("\24\25 : Листание текста   ",
                             "F1 : Вывод на принтер   ",
                             "Esc : Выход в меню "),
                       makewindow(3,15,15,"",1,1,22,78),
                       makewindow(4,15,0,"",2,2,3,76),
                       h(3,Head),cursor(1,3),write(Head),
                       assert(list(1,[])),
                       assert(num_tab([11,12,10,9,18,16,15,12],[0,0,0,0])),
                       createlist,
                       scroll_win(5,15,5,2,17,76,3,_),
                       deletewindows(5),!.
   protocol(52,Title):-makewindow(2,15,15,Title,0,0,25,80),
                       cursor(22,2),
                       write("\24\25 : Листание текста   ",
                             "F1 : Вывод на принтер   ",
                             "Esc : Выход в меню "),
                       makewindow(3,15,15,"",1,1,22,78),
                       makewindow(4,15,0,"",2,2,3,76),
                       h(4,Head),cursor(1,3),write(Head),
                       assert(list(1,[])),
                       assert(num_tab([8,7,5,6,18,13,16,16],[0,0,0,0])),
                       createlist,
                       scroll_win(5,15,5,2,17,76,4,_),
                       deletewindows(5),!.
