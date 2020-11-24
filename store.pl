:- dynamic(inStore/0).

/* Masuk store jika berada pada petak store di map */
store :- \+gameStarted,!, write('The game has not started, type "start." to play the game').
store :- inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
store :- playerPos(X, Y), \+elmtPeta(X, Y, 'S'), !, write('There is no store here').
store :-
    (inStore ->
        write('You are already in a store, use "exitStore." to exit')
    ;
        assertz(inStore),
        write('What do you want to buy?'), nl,
        write('1. Gacha (1000 Gold)'), nl,
        write('2. Potions')
    ).

/* Keluar store jika berada di dalam store */
exitStore :- \+gameStarted,!, write('The game has not started, type "start." to play the game').
exitStore :- inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
exitStore :-
    (inStore ->
        retract(inStore),
        write('Thank you for coming')
    ;
        write('You are not in a store')
    ).

/* Gacha jika berada di store */
/* 70% Common, 20% Rare, 10% Legendary */
gacha :- \+gameStarted,!, write('The game has not started, type "start." to play the game').
gacha :- inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
gacha :- \+inStore, !, write('You cannot use gacha because you are not in a store').
gacha :- inventory(Inv), itemCount(Inv, Count), Count =:= 100, !, write('Inventory full, cannot use gacha').
gacha :-
    player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
    (G >= 1000 ->
        NewG is G - 1000,
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HP, MaxHP, Att, Def, E, NewG)),
        random(1, 11, Rarity),
        (between(1, 7, Rarity) ->
            random(0, 18, Id),
            item(Name, Id),
            addItem(Name, 1),
            write('You get '), write(Name)
        ; between(8, 9, Rarity) ->
            random(18, 32, Id),
            item(Name, Id),
            addItem(Name, 1),
            write('You get '), write(Name)
        ;
            random(32, 39, Id),
            item(Name, Id),
            addItem(Name, 1),
            write('You get '), write(Name)
        ),
		nl,
		eqStatus(Name)
    ;
        write('You do not have enough gold')
    ).

/* Membeli potion jika berada di store */
/* Masih cuma 1 potion doang dan belinya cuma bisa satu per command */
buyPotion :- \+gameStarted,!, write('The game has not started, type "start." to play the game').
buyPotion :- inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
buyPotion :- \+inStore, !, write('You cannot buy potion because you are not in a store').
buyPotion :- inventory(Inv), itemCount(Inv, Count), Count =:= 100, !, write('Inventory full, cannot buy potion').
buyPotion :-
    write('What potion do you want to buy?'), nl,
    write('1. Health Potion (S) (100 Gold)'), nl,
    write('2. Health Potion (M) (300 Gold)'), nl,
    write('3. Health Potion (L) (500 Gold)'), nl,
    write('4. Attack Potion (200 Gold)'), nl,
    write('5. Defense Potion (200 Gold)'), nl,
    write(' > '), read(X),
    (X == 1 -> pot('Health Potion (S)', 100)
    ; X == 2 -> pot('Health Potion (M)', 300)
    ; X == 3 -> pot('Health Potion (L)', 500)
    ; X == 4 -> pot('Attack Potion', 200)
    ; X == 5 -> pot('Defense Potion', 200)
    ; 
        write('What do you want to buy?'), nl,
        write('1. Gacha (1000 Gold)'), nl,
        write('2. Potions')
    ).

pot(Pot, Price) :-
    player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
    (G >= Price ->
        NewG is G - Price,
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HP, MaxHP, Att, Def, E, NewG)),
        addItem(Pot, 1),
        write('You bought 1 '), write(Pot)
    ;
        write('You do not have enough gold')
    ).