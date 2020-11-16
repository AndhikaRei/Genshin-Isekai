:- dynamic(quest/6).
/* quest(A,A1,B,B1,C,C1) membunuh slime sejumlah A, goblin sejumlah B, dan wolf sejumlah C1, tanpa mempedulikan jenisnya (?) */

/* tq : takeQuest di tempat dimana simbol 'Q' berada, quest tidak bisa dicancel dan setelah quest diambil maka quest hilang */
tq :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
tq :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
tq :- 
    quest(_,_,_,_,_,_) ,!, write('You cant take multiple quest at once').
tq :- 
    playerPos(A,B),elmtPeta(A,B,'Q'), random(3, 13, A1), random(6, 15, B1), random(3, 10, C1),
    assertz(quest(A1,A1,B1,B1,C1,C1)),!, 
    format('You must slay : ~n 1.~d Slime ~n 2.~d Goblin ~n 3.~d Wolf ~n Good luck with the quest !! ~n  ', [A1,B1,C1]),
    retract(elmtPeta(A, B,'Q')), assertz(elmtPeta(A, B,'-')).
tq :-
    !,write('You cant take quest here ').

/* pq : print quest status (remaining enemies to be killed) */
pq :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
pq :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
pq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
pq :-
    quest(A,A1,B,B1,C,C1) ,!, format('Quest status  slime: ~d/~d, goblin : ~d/~d, wolf : ~d/~d',[A1,A,B1,B,C1,C]).

/* fq : finish the quest) */
fq :-
    \+gameStarted,!, write('Game belum dimulai, silahkan ketik "start." untuk memulai').
fq :-
    inBattle,!, write('Anda sedang dalam pertarungam, silahkan ketik "help." untuk melihat command saat di pertarungan').
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