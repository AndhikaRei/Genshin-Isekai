/* include modul eksternal
:- include('inventory.pl').
:- include('items.pl').
*/

:- dynamic(exp/3).
:- dynamic(player/8).
:- dynamic(playerEquipment/3).

/* Job, Level, HP (and also Max HP), Attack, Defense */
growthRate(swordsman, 1, 150, 5, 3).
growthRate(archer, 1, 50, 8, 2).
growthRate(sorcerer, 1, 100, 6, 3).

/* Base Stats di Level 1 */
/* Job, Level, HP, MaxHP, Attack, Defense, Exp, Gold */
baseStat(swordsman, 1, 500, 500, 30, 25, 0, 10000).
baseStat(archer, 1, 400, 400, 50, 20, 0, 100000).
baseStat(sorcerer, 1, 450, 450, 45, 10, 0, 100000).

/* Pas milih class, assert player dengan BaseStat dari jobnya */
/* Di main pas bagian inisialisasi (atau di init.pl juga boleh kalau mau */
/* assertz(Player(......)) */
exp(1,0,1).
/* exp(Lv, _, Total) :- Total is Lv*Lv*lv. */
status :- player(X, Lvl, HP, MaxHP, Att, Def, E, G),
		  playerEquipment(Weapon, Armor, Acc),
		  write('Class : '), write(X), nl,
		  write('Level : '), write(Lvl), nl,
		  write('HP : '), write(HP), write('/'), write(MaxHP), nl, /* Untuk accessory nambah Max HP tapi belum dikoding */
          write('Attack : '), write(Att), printEqStat(Weapon), nl,
		  write('Defense : '), write(Def), printEqStat(Armor), nl,
		  write('Exp : '), write(E), write('/'), exp(_,_,Total), write(Total), nl,
		  write('Gold : '), write(G), nl, nl,
		  write('Weapon : '), write(Weapon), nl,
		  write('Armor : '), write(Armor), nl,
		  write('Accessory : '), write(Acc), nl.

printEqStat(X) :-
	(equipment(X, _, _, Stat) ->
		write(' (+'), write(Stat), write(')')
	;
		write('')
	).

levelUp(X) :- 
	growthRate(X, L, Health, Attack, Defense),
	player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
	retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
	NewLvl is Lvl + L, NewHP is HP + Health, NewMax is MaxHP + Health, NewAtt is Att + Attack, NewDeff is Def + Defense,
	assertz(player(Job, NewLvl, NewHP, NewMax, NewAtt, NewDeff, E, G)).

addExp(X) :-
	exp(Lv,Xbefore,Total), NewExp is Xbefore + X,
	(NewExp >= Total ->
		format('Level Up!!! ~n', []),
		NewExp2 is NewExp-Total, NewLvl is Lv + 1, NewTotal is NewLvl*NewLvl*NewLvl,
		retract(exp(Lv,Xbefore,Total)),
		assertz(exp(NewLvl,NewExp2,NewTotal)),
		player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
		retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
		assertz(player(Job, Lvl, HP, MaxHP, Att, Def, NewExp2, G)),
		levelUp(Job)
	; 
		Xremain is Total-NewExp,
		format('You gain ~d exp ~n', [X]), format('You need ~d exp to level uo ~n', [Xremain]),
		retract(exp(Lv,Xbefore,Total)),
		assertz(exp(Lv,NewExp,Total)),
		player(Job, Lvl, HP, MaxHP, Att, Def, E, G),
		retract(player(Job, Lvl, HP, MaxHP, Att, Def, E, G)),
		assertz(player(Job, Lvl, HP, MaxHP, Att, Def, NewExp, G))
	).

/* Memakai equipment dengan nama X */
equip(X) :- inventory(Inv), \+member([X, _], Inv), !, write('You do not have that item'), fail.
equip(X) :- equipment(X, Job, _, _), player(PlayerJob, _, _, _, _, _, _, _), Job \== universal, Job \== PlayerJob, !, write('You are not a/an '), write(Job), fail.
equip(X) :-
	equipment(X, _, Stat, _),
	playerEquipment(Weap, Armor, Acc),
	(Stat == atk ->
		(Weap \== none ->
			addItem(Weap, 1),
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(X, Armor, Acc)),
			write('You equipped '), write(X)
		;
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(X, Armor, Acc)),
			write('You equipped '), write(X)
		)
	; Stat == def ->
		(Armor \== none ->
			addItem(Armor, 1),
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, X, Acc)),
			write('You equipped '), write(X)
		;
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, X, Acc)),
			write('You equipped '), write(X)
		)
	;
		/* Untuk accessory nambah Max HP tapi belum dikoding */
		(Acc \== none ->
			addItem(Acc, 1),
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, Armor, X)),
			write('You equipped '), write(X)
		;
			drop(X),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, Armor, X)),
			write('You equipped '), write(X)
		)
	).

/* Melepas equipment di slot X */
unequip(_) :- inventory(Inv), itemCount(Inv, Count), Count =:= 100, !, write('Inventory full, cannot unequip item').
unequip(X) :-
	playerEquipment(Weap, Armor, Acc),
	(X == weapon ->
		(Weap == none ->
			write('You do not have any weapon equipped')
		;
			addItem(Weap, 1),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(none, Armor, Acc)),
			write('You unequipped '), write(Weap)
		)
	; X == armor ->
		(Armor == none ->
			write('You do not have any armor equipped')
		;
			addItem(Armor, 1),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, none, Acc)),
			write('You unequipped '), write(Armor)
		)
	; X == accessory -> /* Untuk accessory nambah Max HP tapi belum dikoding */
		(Acc == none ->
			write('You do not have any accessory equipped')
		;
			addItem(Acc, 1),
			retract(playerEquipment(Weap, Armor, Acc)),
			assertz(playerEquipment(Weap, Armor, none)),
			write('You unequipped '), write(Acc)
		)
	;
		write('Invalid input, use "unequip(weapon). / unequip(armor). / unequip(accessory)."')
	).
