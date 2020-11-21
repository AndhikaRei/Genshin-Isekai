:- dynamic(playerCDSpecial/1).
:- dynamic(enemyCDSpecial/1).

battle:- 
    inBattleEnemy(Enemy, Lvl, _, TMaxHP, TAtk, TSAtk, TDef, _),
    write('You found a '), write(Enemy), nl,
    write('Level: '), write(Lvl), nl,
    write('Health: '), write(TMaxHP), nl,
    write('Attack: '), write(TAtk), nl,
    write('Special Attack : '), write(TSAtk), nl,
    write('Defense: '), write(TDef), nl, nl,
    write('What will you do?').

% bagian player
attack :- 
    player(_, _, _, _, Att, _, _, _),
    inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp),
    DMG is Att - TDef,
    THPNew is THP - DMG,
    write('You deal '), write(DMG), write(' damage'), nl,
    (THPNew =< 0 ->
        winBattle /* dapet XP & gold */
    ;
        retract(inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp)),
        assertz(inBattleEnemy(Enemy, TLvl, THPNew, TMaxHP, TAtk, TSAtk, TDef, TExp)),
        write(Enemy), write(' has '), write(THPNew), write(' HP left'), nl,
        (playerCDSpecial(X) ->
            XNew is X - 1,
            retract(playerCDSpecial(X)),
            (XNew =\= 0 ->
                assertz(playerCDSpecial(XNew))
            ;
                true
            )
        ;
            true
        ),
        enemyTurn
    ).
    
specialAttack :- 
    (playerCDSpecial(_) ->
        write('Your special is still on cooldown')
    ;
        player(_, Lvl, _, _, Att, _, _, _),
        inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp),
        DMG is Att * Lvl,
        THPNew is THP - DMG,
        write('You used your special attack'), nl,
        write('You deal '), write(DMG), write(' damage'), nl,
        (THPNew =< 0 ->
            winBattle /* dapet XP & gold */
        ;
            retract(inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp)),
            assertz(inBattleEnemy(Enemy, TLvl, THPNew, TMaxHP, TAtk, TSAtk, TDef, TExp)),
            assertz(playerCDSpecial(3)),
            write(Enemy), write(' has '), write(THPNew), write(' HP left'), nl,
            enemyTurn
        )
    ).

% potion
usePotion :- 
    inventory(Inv),
    (member(['Health Potion', _], Inv) ->
        player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
        potion('Health Potion', HPInc),
        HPNew is HP + HPInc,
        (HPNew >= MaxHP ->
            HPNew is MaxHP
        ;
            true
        ),
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HPNew, MaxHP, Att, Def, E, G)),
        drop('Health Potion')
    ;
        write('You do not have any potion')
    ).
usePotion   .

% bagian enemy
enemyTurn :- 
    (enemyCDSpecial(_) -> 
        enemyAttack
    ;
        random(1, 4, X),
        (X =:= 3 ->
            enemySpecialAttack
        ;
            enemyAttack
        )
    ).
enemyAttack:- 
    player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
    inBattleEnemy(Enemy, _, _, _, TAtk, _, _, _),
    DMG is TAtk - Def,
    HPNew is HP - DMG,
    write(Enemy), write(' deal '), write(DMG), write(' damage'), nl,
    (HPNew =< 0 ->
        loseBattle /* player kalah */
    ;
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HPNew, MaxHP, Att, Def, E, G)),
        (enemyCDSpecial(X) ->
            XNew is X - 1,
            retract(enemyCDSpecial(X)),
            (XNew =\= 0 ->
                assertz(enemyCDSpecial(XNew))
            ;
                true
            )
        ;
            true
        )
    ).

enemySpecialAttack:- 
    player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
    inBattleEnemy(Enemy, _, _, _, _, TSAtk, _, _),
    DMG is TSAtk - Def,
    HPNew is HP - DMG,
    write(Enemy), write(' used their special attack'), nl,
    write(Enemy), write(' deal '), write(DMG), write(' damage'), nl,
    (HPNew =< 0 ->
        loseBattle /* player kalah */
    ;
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HPNew, MaxHP, Att, Def, E, G)),
        assertz(enemyCDSpecial(3))
    ).

stopBattle:- 
    (playerCDSpecial(X) -> retract(playerCDSpecial(X)) ; true),
    (retract(enemyCDSpecial(Y)) -> retract(enemyCDSpecial(Y)) ; true),
    retract(inBattleEnemy(_, _, _, _, _, _, _, _)),
    retract(inBattle).

% Pelarian
successFlee(X):- X = 1, write('You flee from battle'), nl, stopBattle, !.
successFlee(X):- X = 2, write('Uh oh, your attempt to run was unsuccessful!'), nl, enemyTurn, !.
flee:- \+inBattle, write('This command is only available in battle'), nl, !.
flee:- random(1,3,X), successFlee(X).

winBattle:- write('You have slain your enemy. Proceed with your journey, Traveler!'), nl, stopBattle, !.
loseBattle:- write('Despite your best efforts, it was all in vain as you were defeated by the enemy. Keep your heads up, Traveler!'), nl, stopBattle, !.