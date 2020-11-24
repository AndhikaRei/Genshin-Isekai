:- dynamic(playerCDSpecial/1).
:- dynamic(enemyCDSpecial/1).

battle:- 
    inBattleEnemy(_, Lvl, _, TMaxHP, TAtk, TSAtk, TDef, _, _, _),
    write('Level: '), write(Lvl), nl,
    write('Health: '), write(TMaxHP), nl,
    write('Attack: '), write(TAtk), nl,
    write('Special Attack : '), write(TSAtk), nl,
    write('Defense: '), write(TDef), nl, nl,
    write('What will you do?').

% bagian player
attack :- 
    player(_, _, _, _, Att, _, _, _),
    inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold),
    playerEquipment(Weap, _, _),
    (Weap == none ->
        EqAtk is 0
    ;
        equipment(Weap, _, _, EqAtk)
    ),
    DMGTemp is Att + EqAtk - TDef,
    (DMGTemp < 0 ->
        DMG is 0
    ; 
        DMG is DMGTemp
    ),
    THPNew is THP - DMG,
    write('You deal '), write(DMG), write(' damage'), nl,
    (THPNew =< 0 ->
        winBattle /* dapet XP & gold */
    ;
        retract(inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold)),
        assertz(inBattleEnemy(Enemy, TLvl, THPNew, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold)),
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
        inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold),
        playerEquipment(Weap, _, _),
        (Weap == none ->
            EqAtk is 0
        ;
            equipment(Weap, _, _, EqAtk)
        ),
        DMGTemp is (Att * Lvl) + EqAtk - TDef,
        (DMGTemp < 0 ->
            DMG is 0
        ; 
            DMG is DMGTemp
        ),
        THPNew is THP - DMG,
        write('You used your special attack'), nl,
        write('You deal '), write(DMG), write(' damage'), nl,
        (THPNew =< 0 ->
            winBattle /* dapet XP & gold */
        ;
            retract(inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold)),
            assertz(inBattleEnemy(Enemy, TLvl, THPNew, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold)),
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
        (HP =:= MaxHP ->
            write('You are already at full health')
        ;
            potion('Health Potion', HPInc),
            HPTemp is HP + HPInc,
            (HPTemp >= MaxHP ->
                HPNew is MaxHP
            ;
                HPNew is HPTemp
            ),
            HPAdd is HPNew - HP,
            write('You heal '), write(HPAdd), write(' HP'), nl,
            retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
            assertz(player(Job, Lvl, HPNew, MaxHP, Att, Def, E, G)),
            drop('Health Potion')
        )
    ;
        write('You do not have any Health Potion')
    ),
    (member(['Attack Potion', _], Inv) ->
        player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
        potion('Attack Potion', AttInc),
        AttNew is Att + AttInc,
        write('Your attack will now deal '), write(AttNew), write(' damage'), nl,
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HP, MaxHP, AttNew, Def, E, G)),
        drop('Attack Potion')
    ;
        write('You do not have any Attack Potion')
    ),
    (member(['Defense Potion', _], Inv) ->
        player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
        potion('Defense Potion Potion', DefInc),
        DefNew is Def + DefInc,
        write('You increased your defence to '), write(DefNew), nl,
        retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
        assertz(player(Job, Lvl, HP, MaxHP, Att, DefNew, E, G)),
        drop('Defense Potion')
    ;
        write('You do not have any Defense Potion')
    ).


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
    inBattleEnemy(Enemy, _, _, _, TAtk, _, _, _, _, _),
    DMGTemp is TAtk - Def,
    (DMGTemp < 0 ->
        DMG is 0
    ; 
        DMG is DMGTemp
    ),
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
    inBattleEnemy(Enemy, _, _, _, _, TSAtk, _, _, _, _),
    DMGTemp is TSAtk - Def,
    (DMGTemp < 0 ->
        DMG is 0
    ; 
        DMG is DMGTemp
    ),
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

enemyStatus :-
    (inBattle ->
        inBattleEnemy(Enemy, Level, HP, MaxHP, Atk, SAtk, Def, _, _, _),
        idEnemy(Id, Enemy),
        printGBEnemy(Id),
        write('Enemy : '), write(Enemy), nl,
        write('Level : '), write(Level), nl,
        write('HP : '), write(HP), write('/'), write(MaxHP), nl,
        write('Attack : '), write(Atk), nl,
        write('Special Attack : '), write(SAtk), nl,
        write('Defense : '), write(Def), nl
    ;
        write('You are not in a battle')
    ).

stopBattle:- 
    (playerCDSpecial(X) -> retract(playerCDSpecial(X)) ; true),
    (enemyCDSpecial(Y) -> retract(enemyCDSpecial(Y)) ; true),
    retractall(inBattleEnemy(_, _, _, _, _, _, _, _, _, _)),
    retract(inBattle), (livingBosses(0,0) -> winTheGame; true).

% Pelarian
successFlee(X):- X = 1, write('You flee from battle'), nl, stopBattle, !.
successFlee(X):- X = 2, write('Uh oh, your attempt to run was unsuccessful!'), nl, enemyTurn, !.
flee:- \+inBattle, write('This command is only available in battle'), nl, !.
flee:- random(1,3,X), successFlee(X).

winBattle:-
    write('You have slain your enemy. Proceed with your journey, Traveler!'), nl,
    inBattleEnemy(Enemy, _, _, _, _, _, _, ExpGain, MinGold, MaxGold), idEnemy(ID,Enemy),
	(ID =:= 7 -> 
        livingBosses(A,B), retract(livingBosses(A,B)), assertz(livingBosses(0,B)), 
        retract(elmtPeta(X, Y,'H')), write('You killed the mighty hypostasis, good luck dude!'), nl 
    ; ID =:= 8 -> 
        livingBosses(A,B), retract(livingBosses(A,B)), assertz(livingBosses(A,0)), 
        retract(elmtPeta(X, Y,'A')), write('You killed the mighty adrius, good luck dude!'), nl 
    ; true 
    ),
	stopBattle,
    addExp(ExpGain),
	MaxGoldPoss is MaxGold + 1,
	random(MinGold, MaxGoldPoss, GoldGain),
	addGold(GoldGain),
    (quest(_,_,_,_,_,_) -> progressById(ID); true),
    !.
	
loseBattle :- write('Despite your best efforts, it was all in vain as you were defeated by the enemy. Keep your heads up, Traveler!'), nl, finish, !.
winTheGame :- write('You are the savior of this realm, I will move you back to your own world, see you yuusha-sama!!'), nl, finish, !.