:- dynamic(playerCDSpecial/1).
:- dynamic(enemyCDSpecial/1).

battle:- \+inBattle, write('You are currently not in a battle'), nl, !.
battle:- 
    inBattleEnemy(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef),
    write('You found a '), write(Enemy), nl,
    write('Level: '), write(Lvl), nl,
    write('Health: '), write(TMaxHP), nl,
    write('Attack: '), write(TAtk), nl,
    write('Defense: '), write(TDef), nl, nl,
    write('What will you do?').

attack :- .
specialAttack :- 
    (playerCDSpecial(X) ->
        write('Your special is still on cooldown')
    ;
        player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
        inBattleEnemy(),
        DMG is Att * Lvl,
    ).
usePotion:- .

enemyTurn :- .
enemyAttack:- .
enemySpecialAttack:- 
    (enemyCDSpecial(X) ->
        enemyAttack
    ;
    ).

stopBattle:- .

% Pelarian
successFlee(X):- X = 1, write('You flee from battle'), nl, stopBattle, !.
successFlee(X):- X = 2, write('Uh oh, your attempt to run was unsuccessful!'), nl, !.
flee:- \+inBattle, write('This command is only available in battle'), nl, !.
flee:- random(1,3,X), successFlee(X).

winBattle:- write('You have slain your enemy. Proceed with your journey, Traveler!'), nl, stopBattle, !.
loseBattle:- write('Despite your best efforts, it was all in vain as you were defeated by the enemy. Keep your heads up, Traveler!'), nl, stopBattle, !.