/* Inisialisasi Game */
:- include('peta.pl').
:- include('quest.pl').
:- include('player.pl').
:- include('store.pl').
:- include('inventory.pl').
:- include('saveloadtest.pl').
:- dynamic(gameStarted/0).
:- dynamic(inBattle/0).

/* Start Game */
start :-
    \+ gameStarted,!,
    write('**************************************************************************************************'),nl,
    format('Welcome to Genshin Asik. Choose your job ~n 1. Swordsman ~n 2. Archer ~n 3. Sorcerer ~n > ',[]),
    read(A),chooseJob(A).

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* chooseJob : memilih job */
chooseJob(A) :-
    A =:= 1,
    baseStat('swordsman',X,B,C,D,E,F,G),
    assertz(player('swordsman',X,B,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Sword', 1], ['Health Potion', 5]])),
    !,
    write('You choose swordsman, let\'s explore the world'),
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 2,
    baseStat('archer',X,B,C,D,E,F,G),
    assertz(player('archer',X,B,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Bow', 1], ['Health Potion', 5]])),
    !,
    write('You choose archer, let\'s explore the world'),
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 3,
    baseStat('sorcerer',X,B,C,D,E,F,G),
    assertz(player('sorcerer',X,B,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Staff', 1], ['Health Potion', 5]])),
    !,
    write('You choose sorcerer, let\'s explore the world'),
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =\= 1, A =\= 2, A =\= 3, !,write('Invalid input, please write start. again ').

/* help : menampilkan menu bantuan */
help :-
    inBattle,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Battle Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*                                 Menu List Here                                                 *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    inStore,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Store Menu                                       *'),nl,
    write('**************************************************************************************************'),nl,
    write('*                                 Menu List Here                                                 *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    gameStarted,!,
    write('**************************************************************************************************'),nl,
    write('*                                 Welcome to Adventure Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. Movement = | w.-> up | a.-> left | s.-> down | d.-> right | t.-> teleport |              *'),nl,
    write('*    2. Quest = | tq.-> take a quest | pq.-> print quest status | fq.-> finish quest |           *'),nl,
    write('*    3. Inventory = | inventory.-> show inventory | drop(item,count).-> drop item *count |       *'),nl,
    write('*    4. Equipment = | equip(item).-> equip item | unequip(item).-> unequip item |                *'),nl,
    write('*    5. Dll.                                                                                     *'),nl,
    write('**************************************************************************************************'),nl.

/* Pengganti Sementaara Battle */
battle :-
    \+ inBattle, ! , assertz(inBattle), write('Anda menenukan slime').

battle :-
    !, retract(inBattle), write('Anda menang').