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

/* habitat slime di daerah nomor 1, baris ke 9-13 kolom 1-8 */
habitat(X, Y, slime) :- between(9,13,X), between(1,8,Y).

/* habitat goblin di daerah nomor 2, baris ke 9-13 kolom 12-19 */
habitat(X, Y, goblin) :- between(9,13,X), between(12,19,Y).

/* habitat wolf di daerah nomor 3, baris ke 1-5, kolom 11-17 */
habitat(X, Y, wolf) :- between(1,5,X), between(11,17,Y).


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
    assertz(playerPos(A1, B)),
    ( elmtPeta(A1,B,'A') -> bossEncounter
    ; elmtPeta(A1,B,'H') -> bossEncounter
    ; encounter
    )
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
    assertz(playerPos(A, B1)),
    ( elmtPeta(A,B1,'A') -> bossEncounter
    ; elmtPeta(A,B1,'H') -> bossEncounter
    ; encounter
    )
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
    assertz(playerPos(A1, B)),
    ( elmtPeta(A1,B,'A') -> bossEncounter
    ; elmtPeta(A1,B,'H') -> bossEncounter
    ; encounter
    )
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
    assertz(playerPos(A, B1)),
    ( elmtPeta(A,B1,'A') -> bossEncounter
    ; elmtPeta(A,B1,'H') -> bossEncounter
    ; encounter
    )
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


/******************** TAKEN FROM SPECIALACTION.PL ***************************/
/* bossEncounter apabila pemain menginajak lantai boss maka dia akan langsung melawan boss */
bossEncounter :- playerPos(A,B), elmtPeta(A,B,C),
    ( C == 'A' -> idEnemy(8,Enemy),
        write('You found the legendary wolf , Andrius, prepare yourself to face the Death!'),nl,
        assertz(inBattle), boss(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp),
        assertz(inBattleEnemy(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp)),battle,nl
    ; C == 'H' -> idEnemy(7,Enemy),
        write('You found the cubic of Madness , Hipostasis, prepare yourself to face the Death!'),nl,
        assertz(inBattle), boss(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp),
        assertz(inBattleEnemy(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp)),battle,nl
    ; true
    ).
/* Pemain 60% menemukan musuh Enemy dalam perjalanannya */
encounter   :- playerPos(A, B), \+elmtPeta(A, B, _), \+habitat(A,B,_),!.
encounter   :- playerPos(A, B), \+elmtPeta(A, B, _),
			    random(1, 11, X),!,
				(X < 7 ->
					/* BAGIAN BATTLE DI INIT.PL DI SINI */
					randomEnemy(IdEnemy),!,
                    idEnemy(IdEnemy,Enemy),
					assertz(inBattle),
                    printGBEnemy(IdEnemy),
					/* BAGIAN BATTLE DI INIT.PL DI SINI */
					
					player(_, Lvl, _, _, _, _, _, _),
					baseEnemy(Enemy, HP, Atk, SAtk, Def, Exp),
					growthEnemy(Enemy, GHP, GAtk, GSAtk, GDef, GExp),
					GLvl is Lvl - 1,
					/* semua stats adalah base stat + growthrate * pertambahan level */
					THP is HP + (GHP * GLvl), TMaxHP is THP,
					TAtk is Atk + (GAtk * GLvl), TSAtk is SAtk + (GSAtk * GLvl),
					TDef is Def + (GDef * GLvl), TExp is Exp + (GExp * GLvl),
					assertz(inBattleEnemy(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp)),
					battle,
					/* Ngeprint stats musuh */
					nl
				;	
					true
				).

/* merandom musuh yang ditemukan berdasarkan habitat */				
randomEnemy(IdEnemy) :- playerPos(A, B),
					  habitat(A, B, Musuh),
					  encounterHabitat(Musuh, IdEnemy).
					  
/* encounter di habitat slime akan memiliki persentase encounter dengan */
/* 70% ? slime */
/* 15% ? wolf */
/* 15% ? goblin */
encounterHabitat(slime, IdEnemy) :- random(1, 21, X),
					(X < 15 -> randomSlime(IdEnemy);
						(X < 18 -> randomGoblin(IdEnemy);
							randomWolf(IdEnemy)
						)
					).

/* encounter di habitat goblin akan memiliki persentase encounter dengan */
/* 70% ? goblin */
/* 15% ? wolf */
/* 15% ? slime */
encounterHabitat(goblin, IdEnemy) :- random(1, 21, X),
					(X < 15 -> randomGoblin(IdEnemy);
						(X < 18 -> randomSlime(IdEnemy);
							randomWolf(IdEnemy)
						)
					).
					
/* encounter di habitat wolf akan memiliki persentase encounter dengan */
/* 70% ? wolf */
/* 15% ? slime */
/* 15% ? goblin */
encounterHabitat(wolf, IdEnemy) :- random(1, 21, X),
					(X < 15 -> randomWolf(IdEnemy);
						(X < 18 -> randomGoblin(IdEnemy);
							randomSlime(IdEnemy)
						)
					).

randomSlime(IdEnemy) :- random(1, 3, X),!,
					  (X < 2 -> IdEnemy is 1; /* X = 1 */
						  IdEnemy is 2
					  ).

randomGoblin(IdEnemy) :- random(1, 3, X),!,
					  (X < 2 -> IdEnemy is 3; /* X = 1 */
						  IdEnemy is 4
					  ).

randomWolf(IdEnemy) :- random(1, 3, X),!,
					  (X < 2 -> IdEnemy is 5; /* X = 1 */
						  IdEnemy is 6
					  ).
