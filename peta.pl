:- dynamic(elmtPeta/3).
:- dynamic(playerPos/2).

/* =================================Kelompok Perpetaan==============================================*/

/* playerPos(A,B) player mempunyai posisi di (A,B) */
initPpos :-
    retractall(playerPos(_,_)), assertz(playerPos(2,2)).
/* elmtPeta(A,B,C) posisi C ada di peta dengan koordinat A,B */
elmtPeta(0,_,'#'). elmtPeta(_,0,'#'). elmtPeta(_,19,'#'). elmtPeta(14,_,'#').
elmtPeta(5,1,'#'). elmtPeta(5,2,'#'). elmtPeta(5,3,'#'). elmtPeta(5,7,'#'). elmtPeta(5,8,'#'). elmtPeta(5,9,'#'). elmtPeta(5,10,'#').
elmtPeta(1,10,'#'). elmtPeta(2,10,'#'). elmtPeta(3,10,'#'). elmtPeta(4,10,'#').
/* elmtPeta(3,8,'Q'). elmtPeta(12,3,'Q'). elmtPeta(13,17,'Q'). elmtPeta(2,12,'Q'). */
elmtPeta(4,2,'S').
/* elmtPeta(3,17,'H'). elmtPeta(3,19,'A'). */
elmtPeta(1,4,'1'). elmtPeta(1,5,'2'). elmtPeta(1,6,'3'). elmtPeta(11,2,'1'). elmtPeta(12,17,'2'). elmtPeta(2,13,'3').

/* ukuranPeta(A,B) peta memiliki A baris dan B kolom */
ukuranPeta(15,20).

/* printElmtPeta(A,B) memprint sebuah element di peta pada kolom A baris B */
printElmtPeta(_,20) :-
    !,write('\n').
printElmtPeta(A,B) :-
    playerPos(A,B),!, write('P').
printElmtPeta(A,B) :-
    elmtPeta(A,B,C),!, write(C).
printElmtPeta(A,B) :-
    \+elmtPeta(A,B,_),!, write('-').

/* printPeta(A,B) memprint peta dari elemen awal hingga A,B*/
printPeta(14,20):- !.
printPeta(A,B):-
    ukuranPeta(C,D), A < C, B =< D,
    B =:= (D), printElmtPeta(A,B),
    B1 is 0, A1 is (A+1), printPeta(A1,B1).
printPeta(A,B):-
    ukuranPeta(C,D), A < C, B =< D,
    printElmtPeta(A,B),
    B1 is (B+1), printPeta(A,B1).

/* map perintah untuk memanggil peta */
map:-
    /* gameStarted(_),  (somebody start the game) */
    printPeta(0,0),!.

/* =================================================================================================*/

/* =================================Kelompok Perpindahan============================================*/
/* w : berjalan keatas */
w :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
w :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
w :-
    inStore,!,write('You are in store, type "help." to see command in store').
w :-
    playerPos(A,B), A1 is A-1, elmtPeta(A1,B,'#'),!,
    write('You hit a fence').
w:-   
    playerPos(A,B), A1 is A-1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A1, B))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* a : berjalan ke kiri */
a :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
a :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
a :-
    inStore,!,write('You are in store, type "help." to see command in store').
a :-
    playerPos(A,B), B1 is B-1, elmtPeta(A,B1,'#'),!,
    write('You hit a fence').
a:-   
    playerPos(A,B), B1 is B-1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A, B1))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* s : berjalan kebawah */
s :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
s :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
s :-
    inStore,!,write('You are in store, type "help." to see command in store').
s :-
    playerPos(A,B), A1 is A+1, elmtPeta(A1,B,'#'),!,
    write('You hit a fence').
s :- 
    playerPos(A,B), A1 is A+1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A1, B))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* d : berjalan kekanan */
d :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
d :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
d :-
    inStore,!,write('You are in store, type "help." to see command in store').
d :-
    playerPos(A,B), B1 is B+1, elmtPeta(A,B1,'#'),!,
    write('You hit a fence').
d :- 
    playerPos(A,B), B1 is B+1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A, B1))
    /* random_encounter_enemy, */
    /* another activity, */ .
    
/* t : teleport */
t :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
t  :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
t :-
    inStore,!,write('You are in store, type "help." to see command in store').
t :-
    playerPos(A,B),elmtPeta(A,B,'1'),elmtPeta(A1,B1,'1'), A1 \== A, B1 \== B,!, retract(playerPos(A, B)), assertz(playerPos(A1, B1)).
t :-
    playerPos(A,B),elmtPeta(A,B,'2'),elmtPeta(A1,B1,'2'), A1 \== A, B1 \== B,!, retract(playerPos(A, B)), assertz(playerPos(A1, B1)).
t :-
    playerPos(A,B),elmtPeta(A,B,'3'),elmtPeta(A1,B1,'3'), A1 \== A, B1 \== B,!, retract(playerPos(A, B)), assertz(playerPos(A1, B1)).
t :-
    !, write('You cant teleport here').
