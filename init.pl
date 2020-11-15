/* Inisialisasi Game */
:- include('peta.pl').
:- dynamic(gameStarted/0).
:- dynamic(inBattle/0).

/* Start Game */
start :-
    \+ gameStarted, ! , assertz(gameStarted).

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* Pengganti Sementaara Battle */
battle :-
    \+ inBattle, ! , assertz(inBattle), write('Anda menenukan slime').

battle :-
    !, retract(inBattle), write('Anda menang').