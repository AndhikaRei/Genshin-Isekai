:- dynamic(quest/6).
/* quest(A,A1,B,B1,C,C1) membunuh slime sejumlah A, goblin sejumlah B, dan wolf sejumlah C1, tanpa mempedulikan jenisnya (?) */

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
    retract(elmtPeta(A, B,'Q')), assertz(elmtPeta(A, B,'-')).
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
    /* get gold and exp */
    write('Congratulation for finishing the quest').

/* Fungsi untuk ngeprogress quest nya (kalau kill suatu monster maka fungsi ini dijalakan dan menambah progress dengan mengurangi jumlah monster yang dibunuh(+penanganan kasus negatif)), nunggu battle */
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
            assertz(quest(A,A1,B,B2,C,C2))
        )
    ).