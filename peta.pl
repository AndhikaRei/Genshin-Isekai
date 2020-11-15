:- dynamic(elmtPeta/3).
:- dynamic(playerPos/2).

/* =================================Kelompok Perpetaan==============================================*/

/* playerPos(A,B) player mempunyai posisi di (A,B) */
playerPos(2,2).

/* elmtPeta(A,B,C) posisi C ada di peta dengan koordinat A,B */
elmtPeta(0,_,'#'). elmtPeta(_,0,'#'). elmtPeta(_,19,'#'). elmtPeta(14,_,'#').
elmtPeta(5,1,'#'). elmtPeta(5,2,'#'). elmtPeta(5,3,'#'). elmtPeta(5,7,'#'). elmtPeta(5,8,'#'). elmtPeta(5,9,'#'). elmtPeta(5,10,'#').
elmtPeta(1,10,'#'). elmtPeta(2,10,'#'). elmtPeta(3,10,'#'). elmtPeta(4,10,'#').
elmtPeta(3,8,'Q'). elmtPeta(12,3,'Q'). elmtPeta(13,17,'Q'). elmtPeta(2,12,'Q').
elmtPeta(4,2,'S').
elmtPeta(3,17,'D').

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
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
w :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
w :-
    playerPos(A,B), A1 is A-1, elmtPeta(A1,B,'#'),!,
    write('Anda menabrak pagar').
w:-   
    playerPos(A,B), A1 is A-1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A1, B))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* a : berjalan ke kiri */
a :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
a :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
a :-
    playerPos(A,B), B1 is B-1, elmtPeta(A,B1,'#'),!,
    write('Anda menabrak pagar').
a:-   
    playerPos(A,B), B1 is B-1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A, B1))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* s : berjalan kebawah */
s :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
s :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
s :-
    playerPos(A,B), A1 is A+1, elmtPeta(A1,B,'#'),!,
    write('Anda menabrak pagar').
s :- 
    playerPos(A,B), A1 is A+1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A1, B))
    /* random_encounter_enemy, */
    /* another activity, */ .

/* d : berjalan kekanan */
d :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
d :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
d :-
    playerPos(A,B), B1 is B+1, elmtPeta(A,B1,'#'),!,
    write('Anda menabrak pagar').
d :- 
    playerPos(A,B), B1 is B+1,!,
    retract(playerPos(A, B)),
    assertz(playerPos(A, B1))
    /* random_encounter_enemy, */
    /* another activity, */ .

