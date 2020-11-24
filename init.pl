/* Inisialisasi Game */
:- include('peta.pl').
:- include('quest.pl').
:- include('player.pl').
:- include('store.pl').
:- include('inventory.pl').
:- include('saveloadtest.pl').
:- include('battle.pl').
:- include('enemy.pl').


:- dynamic(gameStarted/0).
:- dynamic(inBattle/0).

/* Start Game */
start :-
    \+ gameStarted,!,
    write('**************************************************************************************************'), nl,
	write('Selamat datang di Genshin Asik. Anda barusan saja ditabrak oleh truk.'), nl,
	write('Apa yang ada harapkan?'), nl,
	write('Masuk ke isekai?'), nl,
	write('Truknya yang hancur karena kamu terlalu kuat?'), nl, 
	write('Mendapat seorang istri yang sangat uwu?'), nl,
	write('atau dijadikan tubes untuk IF\'19?'), nl,
	write('Kenyataannya adalah kamu dijadikan tubes untuk IF\'19. Walaupun sebenarnya masuk isekai juga tidak salah.'), nl,
	write('Kamu mau jadi apa? Pilih dan pikirkan baik-baik. Pilihanmu akan memengaruhi kehidupanmu di dunia ini.'), nl,
	write('1. Swordsman'), nl,
	write('2. Archer'), nl,
	write('3. Sorcerer'), nl,
	write(' > '),
/*    format('Welcome to Genshin Asik. Choose your job ~n 1. Swordsman ~n 2. Archer ~n 3. Sorcerer ~n > ',[]), */
    replenishQuest, initialExp, initPpos, replenishBoss, read(A), chooseJob(A).

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* chooseJob : memilih job */
chooseJob(A) :-
    A =\= 1, A =\= 2, A =\= 3, !,write('Invalid input, please write start. again '), fail.

chooseJob(A) :-
    A =:= 1,
    baseStat('swordsman',C,D,E,F,G),
    assertz(player('swordsman',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Sword', 1], ['Health Potion (S)', 5]])),
    !,
    write('You choose swordsman, let\'s explore the world'), nl,
	equip('Wooden Sword'), nl,
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 2,
    baseStat('archer',C,D,E,F,G),
    assertz(player('archer',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Bow', 1], ['Health Potion (S)', 5]])),
    !,
    write('You choose archer, let\'s explore the world'), nl,
	equip('Wooden Bow'), nl,
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 3,
    baseStat('sorcerer',C,D,E,F,G),
    assertz(player('sorcerer',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Staff', 1], ['Health Potion (S)', 5]])),
    !,
    write('You choose sorcerer, let\'s explore the world'), nl,
	equip('Wooden Staff'), nl,
    write('**************************************************************************************************'),nl.

/* help : menampilkan menu bantuan */
help :-
    \+gameStarted, !,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Genshin Asik                                     *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. start.  -> Start a new game                                                              *'),nl,
    write('*    2. load.   -> Load game                                                                     *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    inBattle,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Battle Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. attack.        -> Basic attack                                                           *'),nl,
    write('*    2. specialAttack. -> Use special attack on your enemy                                       *'),nl,
    write('*    3. Potions =                                                                                *'),nl,
	write('*                   usePotion(hps). -> Use Health Potion (S)                                     *'),nl,
	write('*                   usePotion(hpm). -> Use Health Potion (M)                                     *'),nl,
	write('*                   usePotion(hpl). -> Use Health Potion (L)                                     *'),nl,
	write('*                   usePotion(atk). -> Use Attack Potion                                         *'),nl,
	write('*                   usePotion(def). -> Use Defense Potion                                        *'),nl,
    write('*    4. flee.          -> Run away from battle                                                   *'),nl,
    write('*    5. enemyStatus.   -> Display current enemy status                                           *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    inStore,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Store Menu                                       *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. store.     -> Enter store                                                                *'),nl,
    write('*    2. exitStore. -> Exit store                                                                 *'),nl,
    write('*    3. gacha.     -> Try your luck with gacha                                                   *'),nl,
    write('*    4. buyPotion. -> Buy potions                                                                *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    gameStarted,!,
    write('**************************************************************************************************'),nl,
    write('*                                 Welcome to Adventure Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. Movement =                                                                               *'),nl,
	write('*                   w.   -> Move up                                                              *'),nl,
	write('*                   a.   -> Move left                                                            *'),nl,
	write('*                   s.   -> Move down                                                            *'),nl,
	write('*                   d.   -> Move right                                                           *'),nl,	
	write('*                   t.   -> Teleport                                                             *'),nl,
    write('*                   map. -> View map                                                             *'),nl,
    write('*    2. Quest =                                                                                  *'),nl,
	write('*                   tq. -> Take a quest                                                          *'),nl,
	write('*                   pq. -> Print quest status                                                    *'),nl,
	write('*                   fq. -> Finish current quest                                                  *'),nl,
    write('*    3. Inventory =                                                                              *'),nl,
    write('*                   inventory.              -> Show inventory                                    *'),nl,
	write('*                   drop(item_name, count). -> Drop count item_name                              *'),nl,
	write('*    4. Equipment =                                                                              *'),nl,
	write('*                   equip(item_name).   -> Equip item_name                                       *'),nl,
	write('*                   unequip(weapon).    -> Unequip your weapon                                   *'),nl,
	write('*                   unequip(armor).     -> Unequip your armor                                    *'),nl,
	write('*                   unequip(accessory). -> Unequip your accessory                                *'),nl,
    write('*    5. Potions =                                                                                *'),nl,
	write('*                   usePotion(hps). -> Use Health Potion (S)                                     *'),nl,
	write('*                   usePotion(hpm). -> Use Health Potion (M)                                     *'),nl,
	write('*                   usePotion(hpl). -> Use Health Potion (L)                                     *'),nl,
    write('*    6. Your Status =                                                                            *'),nl,
	write('*                   status. -> Print your status                                                 *'),nl,
    write('*    7. Store =                                                                                  *'),nl,
    write('*                   store. -> enter store                                                        *'),nl,
    write('*    8. Option =                                                                                 *'),nl,
    write('*                   save. -> save data                                                           *'),nl,
    write('*                   finish. -> exit game                                                         *'),nl,
    write('**************************************************************************************************'),nl.