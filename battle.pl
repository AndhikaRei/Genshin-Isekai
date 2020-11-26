:- dynamic(playerCDSpecial/1).
:- dynamic(enemyCDSpecial/1).
:- dynamic(atkPotion/1).
:- dynamic(defPotion/1).

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
    (atkPotion(Pot) -> PotAtk is Pot ; PotAtk is 0),
    DMGTemp is Att + PotAtk + EqAtk - TDef,
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
        player(Job, Lvl, _, _, Att, _, _, _),
        inBattleEnemy(Enemy, TLvl, THP, TMaxHP, TAtk, TSAtk, TDef, TExp, MinGold, MaxGold),
        playerEquipment(Weap, _, _),
        (Weap == none ->
            EqAtk is 0
        ;
            equipment(Weap, _, _, EqAtk)
        ),
        (atkPotion(Pot) -> PotAtk is Pot ; PotAtk is 0),
		((Job == sorcerer) -> random(22, 26, Sp)
		; 
        random(10, 16, Sp)),
        DMGTemp is Att + PotAtk + (Sp * Lvl) + EqAtk - TDef,
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
usePotion(Type) :-
    inventory(Inv),
    (Type == hps ->
        hPPot('Health Potion (S)')
    ;Type == hpm ->
        hPPot('Health Potion (M)')
    ;Type == hpl ->
        hPPot('Health Potion (L)')
    ;Type == atk ->
        (\+inBattle -> 
            write('Cannot use Attack Potion outside of battle')
        ;
            (member(['Attack Potion', _], Inv) ->
                potion('Attack Potion', AttInc),
                write('Your attack will increase by '), write(AttInc), write(' for the duration of this battle'), nl,
                assertz(atkPotion(AttInc)),
                drop('Attack Potion')
            ;
                write('You do not have any Attack Potion')
            )
        )
    ;Type == def ->
        (\+inBattle -> 
            write('Cannot use Defense Potion outside of battle')
        ;
            (member(['Defense Potion', _], Inv) ->
                (\+defPotion(_) ->
                    potion('Defense Potion', DefInc),
                    write('Your defense will increase by '), write(DefInc), write(' for the duration of this battle'), nl,
                    assertz(defPotion(DefInc)),
                    drop('Defense Potion')
                ;
                    write('You already used a Defense Potion this battle')
                )
            ;
                write('You do not have any Defense Potion')
            )
        )
    ;
        write('Invalid input, use:'), nl,
        write('usePotion(hps). : Health Potion (S)'), nl,
        write('usePotion(hpm). : Health Potion (M)'), nl,
        write('usePotion(hpl). : Health Potion (L)'), nl,
        write('usePotion(atk). : Attack Potion'), nl,
        write('usePotion(def). : Defense Potion'), nl
    ).

hPPot(Name) :-
    inventory(Inv),
    (member([Name, _], Inv) ->
        player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
        (HP =:= MaxHP ->
            write('You are already at full health')
        ;
            potion(Name, HPInc),
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
            drop(Name)
        )
    ;
        write('You do not have any '), write(Name)
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
    (defPotion(Pot) -> PotDef is Pot ; PotDef is 0),
    DMGTemp is TAtk - Def - PotDef,
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
        write('You have '), write(HPNew), write(' HP left'),
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
    (defPotion(Pot) -> PotDef is Pot ; PotDef is 0),
    DMGTemp is TSAtk - Def - PotDef,
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
        write('You have '), write(HPNew), write(' HP left'),
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
    (atkPotion(Z) -> retract(atkPotion(Z)) ; true),
    (defPotion(W) -> retract(defPotion(W)) ; true),
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