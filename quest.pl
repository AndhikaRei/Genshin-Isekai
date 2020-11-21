/* quest(A,A1,B,B1,C,C1) membunuh slime sejumlah A, goblin sejumlah B, dan wolf sejumlah C1, tanpa mempedulikan jenisnya (?) */
:- dynamic(quest/6).

/* questRemaining(A,B,C,D) A,B,C,D menyimbolkan 4 quest yang ada di map dan nilainya akan satu jika quest nya masih ada */
:- dynamic(questRemaining/4).

/* replenishQuest : merefresh quest yang ada */
replenishQuest :-
    retractall(questRemaining(_,_,_,_)), retractall(elmtPeta(_,_,'Q')), retractall(quest(_,_,_,_,_,_)),
    assertz(elmtPeta(3,8,'Q')),assertz(elmtPeta(12,3,'Q')), assertz(elmtPeta(13,17,'Q')), assertz(elmtPeta(2,12,'Q')),
    assertz(questRemaining(1,1,1,1)).

/* livingBosses(A,B) A menandakan apakah hypostatis masih hidup, B menandakan apakah Adrius masih hidup atau tidak */
:- dynamic(livingBosses/2).

/* replenishBoss : merefresh boss yang ada */
replenishBoss :-
    retractall(livingBosses(_,_)),
    assertz(elmtPeta(3,17,'H')),assertz(elmtPeta(1,17,'A')), assertz(livingBosses(1,1)).

/* tq : takeQuest di tempat dimana simbol 'Q' berada, quest tidak bisa dicancel dan setelah quest diambil maka quest hilang */
tq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
tq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
tq :- 
    quest(_,_,_,_,_,_) ,!, write('You cant take multiple quest at once').
tq :- 
    playerPos(A,B),elmtPeta(A,B,'Q'),!, random(3, 13, A1), random(6, 15, B1), random(3, 10, C1),
    assertz(quest(A1,A1,B1,B1,C1,C1)),!, 
    format('You must slay : ~n 1.~d Slime ~n 2.~d Goblin ~n 3.~d Wolf ~n Good luck with the quest !! ~n  ', [A1,B1,C1]),
    questRemaining(W,X,Y,Z),
    ( (A=:=3,B=:=8)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(0,X,Y,Z))
    ; (A=:=12,B=:=3)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(W,0,Y,Z))
    ; (A=:=13,B=:=17)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(W,X,0,Z))
    ; (A=:=2,B=:=12)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(W,X,Y,0))
    ),
    retract(elmtPeta(A, B,'Q')).
tq :-
    !,write('You cant take quest here ').

/* pq : print quest status (remaining enemies to be killed) */
pq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
pq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
pq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
pq :-
    quest(A,A1,B,B1,C,C1) ,!, format('Quest status  slime: ~d/~d, goblin : ~d/~d, wolf : ~d/~d',[A1,A,B1,B,C1,C]).

/* fq : finish the quest) */
fq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
fq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
fq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
fq :-
    quest(_,A1,_,B1,_,C1), A1 =\= 0, B1 =\= 0, C1 =\= 0 ,!, 
    write('You cannot finish your quest right now').
fq :-
    quest(A,0,B,0,C,0) ,!, retract(quest(A,0,B,0,C,0)), 
    ExpGain is (A*5 + B*13 +C*21), addExp(ExpGain), GoldGain is (A*200 + B*300 + C*500), addGold(GoldGain),
    write('Congratulation for finishing the quest').

/* Fungsi untuk ngeprogress quest nya (kalau kill suatu monster maka fungsi ini dijalakan dan menambah progress dengan mengurangi jumlah monster yang dibunuh(+penanganan kasus negatif)), nunggu battle */
progressById(IdEnemy):-
	(IdEnemy =:= 1 -> progressQuest(slime)
	;IdEnemy =:= 2 -> progressQuest(slime)
	;IdEnemy =:= 3 -> progressQuest(goblin)
	;IdEnemy =:= 4 -> progressQuest(goblin)
	;IdEnemy =:= 5 -> progressQuest(wolf)
	;IdEnemy =:= 6 -> progressQuest(wolf)
    ; true
	).

progressQuest(X) :-
    quest(A,A1,B,B1,C,C1),
    (X == slime ->
        (A1 =:= 0 ->
            format('You have killed many slimes, try killing another ~d goblin and ~d wolf ~n to complete your quest',[B1,C1])
            ;
            A2 is A1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A2,B,B1,C,C1))
        )
    ; X == goblin ->
        (B1 =:= 0 ->
            format('You have killed many goblin, try killing another ~d slime and ~d wolf ~n to complete your quest',[A1,C1])
            ;
            B2 is B1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B2,C,C1))
        )
    ; X == wolf ->
        (C1 =:= 0 ->
            format('You have killed many wolf, try killing another ~d slime and ~d goblin ~n to complete your quest',[A1,B1])
            ;
            C2 is C1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B1,C,C2))
        )
    ).