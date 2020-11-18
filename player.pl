/* include modul eksternal
:- include('inventory.pl').
:- include('items.pl').
*/

:- dynamic(exp/2).
:- dynamic(player/8).

/* Job, Level, HP (and also Max HP), Attack, Defense */
growthRate(swordsman, 1, 150, 5, 3).
growthRate(archer, 1, 50, 8, 2).
growthRate(sorcerer, 1, 100, 6, 3).

/* Base Stats di Level 1 */
/* Job, Level, HP, MaxHP, Attack, Defense, Exp, Gold */
baseStat(swordsman, 1, 500, 500, 30, 25, 1, 10000).
baseStat(archer, 1, 400, 400, 50, 20, 1, 100000).
baseStat(sorcerer, 1, 450, 450, 45, 10, 1, 100000).
/* 

/* Pas milih class, assert player dengan BaseStat dari jobnya */
/* Di main pas bagian inisialisasi (atau di init.pl juga boleh kalau mau */
/* assertz(Player(......)) */

exp(X, X * X * X).
status :- player(X, Lvl, HP, MaxHP, Att, Def, E, G),
		  write('Class : '), write(X), nl,
		  write('HP : '), write(HP), write('/'), write(MaxHP), nl,
          write('Attack : '), write(Att), nl,
		  write('Defense : '), write(Def), nl,
		  write('Exp : '), write(E), write('/'), exp(Lvl, Total), write(Total), nl,
		  write('Gold : '), write(G), nl.

levelUp(X) :- growthRate(X, L, Health, Attack, Defense),
			  player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
			  retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
			  NewLvl is Lvl + L, NewHP is HP + Health, NewMax is MaxHP + Health, NewAtt is Att + Attack, NewDeff is Def + Defense,
			  assertz(player(Job, NewLvl, NewHP, NewMax, NewAtt, NewDeff, E, G)).

