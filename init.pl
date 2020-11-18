/* Inisialisasi Game */
:- include('peta.pl').
:- include('quest.pl').
:- include('player.pl').
:- include('store.pl').
:- include('inventory.pl').
:- dynamic(gameStarted/0).
:- dynamic(inBattle/0).

/* Start Game */
start :-
    \+ gameStarted,!,
    format('Welcome to Genshin Asik. Choose your job ~n 1. Swordsman ~n 2. Archer ~n 3. Sorcerer ~n > ',[]),
    read(A),chooseJob(A).

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* chooseJob : memilih job */
chooseJob(A) :-
    A =:= 1, baseStat('swordsman',X,B,C,D,E,F,G), assertz(player('swordsman',X,B,C,D,E,F,G)),assertz(gameStarted),!,
    write('You choose swordsman, let’s explore the world').

chooseJob(A) :-
    A =:= 2, baseStat('archer',X,B,C,D,E,F,G), assertz(player('archer',X,B,C,D,E,F,G)),assertz(gameStarted),!,
    write('You choose archer, let’s explore the world').

chooseJob(A) :-
    A =:= 3, baseStat('sorcerer',X,B,C,D,E,F,G), assertz(player('sorcerer',X,B,C,D,E,F,G)),assertz(gameStarted),!,
    write('You choose sorcerer, let’s explore the world').

chooseJob(A) :-
    A =\= 1, A =\= 2, A =\= 3, !,write('Invalid input, please write start. again ').

/* Pengganti Sementaara Battle */
battle :-
    \+ inBattle, ! , assertz(inBattle), write('Anda menenukan slime').

battle :-
    !, retract(inBattle), write('Anda menang').